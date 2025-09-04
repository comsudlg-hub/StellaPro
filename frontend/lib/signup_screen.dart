import "package:flutter/material.dart";

class SignupScreen extends StatelessWidget {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final TextEditingController confirmarSenhaController = TextEditingController();

  SignupScreen({super.key});

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
                  "Criar Nova Conta",
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
                      // Campo Nome Completo
                      TextFormField(
                        controller: nomeController,
                        decoration: InputDecoration(
                          labelText: "Nome Completo",
                          hintText: "Digite seu nome completo",
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
                      
                      // Campo Email
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: "Email",
                          hintText: "Digite seu email",
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
                        controller: senhaController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Senha",
                          hintText: "Crie uma senha segura",
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
                      
                      // Campo Confirmar Senha
                      TextFormField(
                        controller: confirmarSenhaController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Confirmar Senha",
                          hintText: "Digite a senha novamente",
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
                      
                      // Botão Cadastrar
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
                            // TODO: Implementar cadastro
                            Navigator.pop(context); // Volta para login
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          child: const Text(
                            "Cadastrar",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // Link para Login
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Volta para login
                        },
                        child: const Text(
                          "Já tem uma conta? Fazer login",
                          style: TextStyle(
                            color: Color(0xFF42585c),
                            decoration: TextDecoration.underline,
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
