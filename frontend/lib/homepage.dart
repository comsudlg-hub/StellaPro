import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

void main() {
  runApp(const StellaProApp());
}

class StellaProApp extends StatelessWidget {
  const StellaProApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "StellaPro",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
                
                // Marca "StellaPro"
                const SizedBox(height: 20),
                Text(
                  "StellaPro",
                  style: GoogleFonts.zenAntiqueSoft(
                    textStyle: const TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF42585c),
                    ),
                  ),
                ),
                
                // Slogan
                Text(
                  "A medida certa para tapeçar seu futuro.",
                  style: GoogleFonts.playfairDisplay(
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                      color: Color(0xFF2f4653),
                    ),
                  ),
                ),
                
                // Container de Conteúdo Principal
                const SizedBox(height: 60),
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
                      // Botão Principal
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: const LinearGradient(
                            colors: [Color(0xFF9c8158), Color(0xFFebe7dc)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: ElevatedButton(
                          onPressed: () {},
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
                      
                      // Link de Cadastro
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Criar nova conta",
                          style: TextStyle(
                            color: Color(0xFF42585c),
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Espaço para conteúdo futuro
                const SizedBox(height: 80),
                
                // Rodapé (limpo)
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
