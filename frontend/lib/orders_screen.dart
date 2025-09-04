import "package:flutter/material.dart";

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFebe7dc),
      appBar: AppBar(
        title: const Text(
          "Orçamentos e Ordens de Serviço",
          style: TextStyle(
            color: Color(0xFF42585c),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFFebe7dc),
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF42585c)),
      ),
      body: DefaultTabController(
        length: 4,
        child: Column(
          children: [
            // TabBar
            Container(
              color: const Color(0xFFebe7dc),
              child: TabBar(
                indicatorColor: const Color(0xFF9c8158),
                labelColor: const Color(0xFF42585c),
                unselectedLabelColor: const Color(0xFF2f4653),
                tabs: const [
                  Tab(text: "Todos"),
                  Tab(text: "Orçamentos"),
                  Tab(text: "Produção"),
                  Tab(text: "Finalizados"),
                ],
              ),
            ),
            
            Expanded(
              child: TabBarView(
                children: [
                  // Tab: Todos
                  _buildOrdersList([
                    _buildOrderItem(
                      code: "PO00010001",
                      client: "Maria Silva",
                      service: "Sofá 3 lugares",
                      status: "Orçamento",
                      statusColor: Colors.orange,
                    ),
                    _buildOrderItem(
                      code: "OE00010002", 
                      client: "João Santos",
                      service: "Poltrona",
                      status: "Enviado",
                      statusColor: Colors.blue,
                    ),
                    _buildOrderItem(
                      code: "OS00010003",
                      client: "Ana Costa",
                      service: "Cadeira",
                      status: "Produção",
                      statusColor: Colors.green,
                    ),
                  ]),
                  
                  // Tab: Orçamentos
                  _buildOrdersList([
                    _buildOrderItem(
                      code: "PO00010001",
                      client: "Maria Silva",
                      service: "Sofá 3 lugares",
                      status: "Orçamento",
                      statusColor: Colors.orange,
                    ),
                  ]),
                  
                  // Tab: Produção
                  _buildOrdersList([
                    _buildOrderItem(
                      code: "OS00010003",
                      client: "Ana Costa",
                      service: "Cadeira",
                      status: "Produção",
                      statusColor: Colors.green,
                    ),
                  ]),
                  
                  // Tab: Finalizados
                  _buildOrdersList([
                    _buildOrderItem(
                      code: "CT00010004",
                      client: "Carlos Oliveira",
                      service: "Loveseat",
                      status: "Entregue",
                      statusColor: Colors.purple,
                    ),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Novo orçamento
        },
        backgroundColor: const Color(0xFF9c8158),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildOrdersList(List<Widget> orders) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        ...orders,
        const SizedBox(height: 80), // Espaço para FAB
      ],
    );
  }

  Widget _buildOrderItem({
    required String code,
    required String client,
    required String service,
    required String status,
    required Color statusColor,
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
            // Cabeçalho com código e status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  code,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF42585c),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: statusColor),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 12),
            
            // Informações do cliente
            Text(
              "Cliente: $client",
              style: const TextStyle(
                color: Color(0xFF2f4653),
                fontWeight: FontWeight.w500,
              ),
            ),
            
            const SizedBox(height: 4),
            
            Text(
              "Serviço: $service",
              style: const TextStyle(color: Color(0xFF2f4653)),
            ),
            
            const SizedBox(height: 12),
            
            // Botões de ação
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      // TODO: Ver detalhes
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF9c8158),
                      side: const BorderSide(color: Color(0xFF9c8158)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text("Detalhes"),
                  ),
                ),
                
                const SizedBox(width: 8),
                
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: Ação principal
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF9c8158),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      status == "Orçamento" ? "Enviar" :
                      status == "Enviado" ? "Aprovar" :
                      status == "Produção" ? "Finalizar" : "Visualizar",
                    ),
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
