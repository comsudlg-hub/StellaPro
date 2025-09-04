import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "login_screen.dart";

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
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF9c8158),
          primary: const Color(0xFF9c8158),
          secondary: const Color(0xFF42585c),
          surface: const Color(0xFFebe7dc),
          background: const Color(0xFFebe7dc),
          onPrimary: Colors.white,
          onSecondary: Colors.white,
        ),
        scaffoldBackgroundColor: const Color(0xFFebe7dc),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFebe7dc),
          foregroundColor: Color(0xFF42585c),
          elevation: 0,
        ),
        cardTheme: const CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0)),
            side: BorderSide(color: Color(0xFF9c8158), width: 1),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF9c8158),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xFF42585c),
          ),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 42,
            fontWeight: FontWeight.bold,
            color: Color(0xFF42585c),
          ),
          bodyLarge: TextStyle(
            fontSize: 18,
            color: Color(0xFF2f4653),
          ),
        ),
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
                
                // Marca "StellaPro" - SEMPRE COM ZEN ANTIQUE SOFT
                const SizedBox(height: 20),
                Text(
                  "StellaPro",
                  style: GoogleFonts.zenAntiqueSoft(
                    textStyle: const TextStyle(
                      fontSize: 60,
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
                      // Botão Principal - REDUZIDO PARA 1/3
                      Container(
                        width: MediaQuery.of(context).size.width * 0.2, // 20% (1/3 de 60%)
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => LoginScreen()),
                            );
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
