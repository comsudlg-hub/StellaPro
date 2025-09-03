const { initializeTestEnvironment } = require("@firebase/rules-unit-testing");
const fs = require("fs");

describe("Firestore Security Rules", () => {
  let testEnv;

  beforeAll(async () => {
    testEnv = await initializeTestEnvironment({
      projectId: "stellapro",
      firestore: {
        rules: fs.readFileSync("../db/firestore.rules", "utf8"),
      },
    });
  });

  afterAll(async () => {
    await testEnv.cleanup();
  });

  test("Cliente só pode ler os próprios dados", async () => {
    const cliente = testEnv.authenticatedContext("user123", { role: "cliente" });
    const db = cliente.firestore();

    // Deve conseguir ler seus próprios dados
    await expect(db.collection("clientes").doc("user123").get()).resolves.not.toBeNull();

    // Não deve conseguir ler dados de outro cliente
    await expect(db.collection("clientes").doc("outroUser").get()).rejects.toThrow();
  });

  test("Estofaria só pode gerenciar seus próprios funcionários", async () => {
    const estofaria = testEnv.authenticatedContext("estofaria123", { estofariaId: "estofaria123" });
    const db = estofaria.firestore();

    // Deve conseguir gerenciar seus próprios funcionários
    await expect(db.collection("estofarias").doc("estofaria123").collection("funcionarios").doc("func1").set({
      nome: "Funcionário Teste",
      cargo: "Tapeceiro"
    })).resolves.not.toBeNull();

    // Não deve conseguir acessar funcionários de outra estofaria
    const outraEstofaria = testEnv.authenticatedContext("estofaria123", { estofariaId: "estofaria123" });
    const dbOutra = outraEstofaria.firestore();
    await expect(dbOutra.collection("estofarias").doc("outraEstofaria").collection("funcionarios").doc("func1").get()).rejects.toThrow();
  });
});
