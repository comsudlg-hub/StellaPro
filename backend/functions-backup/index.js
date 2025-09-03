const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

/**
 * Cloud Function para definir papéis (roles) de usuários
 * Apenas administradores podem executar esta função
 */
exports.setUserRole = functions.https.onCall(async (data, context) => {
  // Verificar se o usuário está autenticado e é administrador
  if (!context.auth || context.auth.token.role !== "admin") {
    throw new functions.https.HttpsError(
        "permission-denied",
        "Apenas administradores podem definir papéis de usuários"
    );
  }

  const { uid, role } = data;

  // Validar os dados de entrada
  if (!uid || !role) {
    throw new functions.https.HttpsError(
        "invalid-argument",
        "Os campos 'uid' e 'role' são obrigatórios"
    );
  }

  // Validar os papéis permitidos
  const allowedRoles = ["admin", "cliente", "estofaria", "fornecedor"];
  if (!allowedRoles.includes(role)) {
    throw new functions.https.HttpsError(
        "invalid-argument",
        `Papel inválido. Permitidos: ${allowedRoles.join(", ")}`
    );
  }

  try {
    // Definir claims customizados do usuário
    await admin.auth().setCustomUserClaims(uid, { role });
    
    // Registrar a ação no Firestore para auditoria
    await admin.firestore().collection("adminLogs").add({
      action: "setUserRole",
      performedBy: context.auth.uid,
      targetUser: uid,
      role: role,
      timestamp: admin.firestore.FieldValue.serverTimestamp()
    });

    return { 
      success: true, 
      message: `Papel '${role}' definido com sucesso para o usuário ${uid}`,
      uid: uid,
      role: role
    };
  } catch (error) {
    console.error("Erro ao definir papel do usuário:", error);
    throw new functions.https.HttpsError(
        "internal",
        "Erro interno ao definir papel do usuário"
    );
  }
});

/**
 * Cloud Function para obter o papel atual do usuário
 * Apenas administradores podem executar esta função
 */
exports.getUserRole = functions.https.onCall(async (data, context) => {
  // Verificar se o usuário está autenticado e é administrador
  if (!context.auth || context.auth.token.role !== "admin") {
    throw new functions.https.HttpsError(
        "permission-denied",
        "Apenas administradores podem consultar papéis de usuários"
    );
  }

  const { uid } = data;

  // Validar os dados de entrada
  if (!uid) {
    throw new functions.https.HttpsError(
        "invalid-argument",
        "O campo 'uid' é obrigatório"
    );
  }

  try {
    // Obter os dados do usuário
    const user = await admin.auth().getUser(uid);
    const customClaims = user.customClaims || {};
    
    return { 
      success: true, 
      uid: uid,
      role: customClaims.role || "nenhum",
      email: user.email
    };
  } catch (error) {
    console.error("Erro ao obter papel do usuário:", error);
    throw new functions.https.HttpsError(
        "internal",
        "Erro interno ao obter papel do usuário"
    );
  }
});
