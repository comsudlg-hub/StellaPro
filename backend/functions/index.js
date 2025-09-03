const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

exports.setUserRole = functions.https.onCall(async (data, context) => {
  if (!context.auth || context.auth.token.role !== "admin") {
    throw new functions.https.HttpsError("permission-denied", "Apenas administradores podem definir papéis");
  }

  const { uid, role } = data;
  if (!uid || !role) {
    throw new functions.https.HttpsError("invalid-argument", "UID e role são obrigatórios");
  }

  const allowedRoles = ["admin", "cliente", "estofaria", "fornecedor"];
  if (!allowedRoles.includes(role)) {
    throw new functions.https.HttpsError("invalid-argument", `Role inválido: ${role}`);
  }

  await admin.auth().setCustomUserClaims(uid, { role });
  return { success: true, uid, role };
});

exports.getUserRole = functions.https.onCall(async (data, context) => {
  if (!context.auth || context.auth.token.role !== "admin") {
    throw new functions.https.HttpsError("permission-denied", "Apenas administradores podem consultar papéis");
  }

  const { uid } = data;
  if (!uid) {
    throw new functions.https.HttpsError("invalid-argument", "UID é obrigatório");
  }

  const user = await admin.auth().getUser(uid);
  return { success: true, uid, role: user.customClaims?.role || "nenhum" };
});
