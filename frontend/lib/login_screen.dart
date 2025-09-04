import "package:flutter/material.dart";

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFebe7dc),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Logo (Poltrona)
                const SizedBox(height: 40),
                Icon(
                  Icons.chair_rounded,
                  size: 80,
                  color: const Color(0xFF9c8158),
                ),
                
                // Título
                const SizedBox(height: 20),
                const Text(
                  "Acessar StellaPro",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF42585c),
                  ),
                ),
                
                // Container do Formulário
                const SizedBox(height: 40),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: const Color(0xFFebe7dc),
                    border: Border.all(color: const Color(0xFF9c8158), width: 2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      // Campo Email
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: "Email",
                          hintText: "Digite seu e-mail", // HINT TEXT CORRETO
                          labelStyle: const TextStyle(color: Color(0xFF42585c)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Color(0xFF9c8158)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Color(0xFF9c8158), width: 2),
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // Campo Senha
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Senha",
                          hintText: "Digite sua senha", // HINT TEXT CORRETO
                          labelStyle: const TextStyle(color: Color(0xFF42585c)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Color(0xFF9c8158)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Color(0xFF9c8158), width: 2),
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 30),
                      
                      // Botão Entrar
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: const LinearGradient(
                            colors: [Color(0xFF9c8158), Color(0xFFebe7dc)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          border: Border.all(
                            color: const Color(0xFF9c8158),
                            width: 2,
                          ),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            // TODO: Implementar login com Firebase
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          child: const Text(
                            "Entrar",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // Link para Cadastro
                      TextButton(
                        onPressed: () {
                          // TODO: Navegar para tela de cadastro
                        },
                        child: const Text(
                          "Criar nova conta",
                          style: TextStyle(
                            color: Color(0xFF42585c),
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 10),
                      
                      // Link para Recuperar Senha
                      TextButton(
                        onPressed: () {
                          // TODO: Implementar recuperação de senha
                        },
                        child: const Text(
                          "Esqueci minha senha",
                          style: TextStyle(
                            color: Color(0xFF42585c),
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
