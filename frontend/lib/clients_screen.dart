import "package:flutter/material.dart";

class ClientsScreen extends StatelessWidget {
  const ClientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFebe7dc),
      appBar: AppBar(
        title: const Text(
          "Gestão de Clientes",
          style: TextStyle(
            color: Color(0xFF42585c),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFFebe7dc),
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF42585c)),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // TODO: Implementar adição de cliente
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Barra de Pesquisa
            TextField(
              decoration: InputDecoration(
                hintText: "Buscar cliente por nome, CPF...",
                prefixIcon: const Icon(Icons.search, color: Color(0xFF9c8158)),
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
            
            // Lista de Clientes
            Expanded(
              child: ListView(
                children: [
                  // Cliente de exemplo 1
                  _buildClientCard(
                    name: "Maria Silva",
                    cpf: "123.456.789-00",
                    phone: "(11) 99999-9999",
                    orders: 3,
                  ),
                  
                  // Cliente de exemplo 2
                  _buildClientCard(
                    name: "João Santos",
                    cpf: "987.654.321-00", 
                    phone: "(11) 98888-8888",
                    orders: 1,
                  ),
                  
                  // Cliente de exemplo 3
                  _buildClientCard(
                    name: "Ana Costa",
                    cpf: "456.789.123-00",
                    phone: "(11) 97777-7777",
                    orders: 5,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implementar adição de cliente
        },
        backgroundColor: const Color(0xFF9c8158),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildClientCard({
    required String name,
    required String cpf,
    required String phone,
    required int orders,
  }) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xFF9c8158), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF42585c),
                  ),
                ),
                Chip(
                  label: Text(
                    "$orders OS",
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  backgroundColor: const Color(0xFF9c8158),
                ),
              ],
            ),
            
            const SizedBox(height: 8),
            
            Text(
              "CPF: $cpf",
              style: const TextStyle(color: Color(0xFF2f4653)),
            ),
            
            const SizedBox(height: 4),
            
            Text(
              "Telefone: $phone", 
              style: const TextStyle(color: Color(0xFF2f4653)),
            ),
            
            const SizedBox(height: 12),
            
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      // TODO: Ver histórico de ordens
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF9c8158),
                      side: const BorderSide(color: Color(0xFF9c8158)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text("Ver OS"),
                  ),
                ),
                
                const SizedBox(width: 8),
                
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: Novo orçamento
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF9c8158),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text("Novo Orçamento"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
