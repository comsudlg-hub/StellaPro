import "package:flutter/material.dart";
import "clients_screen.dart";
import "orders_screen.dart";
import "new_quote_screen.dart";
import "pedido_orcamento_screen.dart";

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFebe7dc),
      appBar: AppBar(
        title: const Text(
          "Dashboard StellaPro",
          style: TextStyle(
            color: Color(0xFF42585c),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFFebe7dc),
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF42585c)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cards de Resumo
            const Text(
              "Visão Geral",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF42585c),
              ),
            ),
            const SizedBox(height: 20),
            
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 1.5,
              children: [
                _buildDashboardCard(
                  icon: Icons.request_quote,
                  title: "Pedidos PO",
                  subtitle: "Novos: 2",
                  color: const Color(0xFF9c8158),
                ),
                
                _buildDashboardCard(
                  icon: Icons.construction,
                  title: "Em Produção",
                  subtitle: "OS Ativas: 1",
                  color: const Color(0xFF42585c),
                ),
                
                _buildDashboardCard(
                  icon: Icons.local_shipping,
                  title: "Entregas",
                  subtitle: "Hoje: 0",
                  color: const Color(0xFF2f4653),
                ),
                
                _buildDashboardCard(
                  icon: Icons.attach_money,
                  title: "Financeiro",
                  subtitle: "R\$ 1.250,00",
                  color: Colors.green,
                ),
              ],
            ),
            
            const SizedBox(height: 30),
            
            // Seção de Ações Rápidas
            const Text(
              "Ações Rápidas",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF42585c),
              ),
            ),
            const SizedBox(height: 20),
            
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _buildActionButton(
                  icon: Icons.add,
                  label: "Novo Pedido PO",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PedidoOrcamentoScreen()),
                    );
                  },
                ),
                _buildActionButton(
                  icon: Icons.people,
                  label: "Clientes",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ClientsScreen()),
                    );
                  },
                ),
                _buildActionButton(
                  icon: Icons.inventory,
                  label: "Estoque",
                  onPressed: () {},
                ),
                _buildActionButton(
                  icon: Icons.directions_car,
                  label: "Logística",
                  onPressed: () {},
                ),
              ],
            ),
            
            const SizedBox(height: 30),
            
            // Últimos Pedidos
            const Text(
              "Últimos Pedidos de Orçamento",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF42585c),
              ),
            ),
            const SizedBox(height: 20),
            
            _buildOrderItem(
              code: "PO00010003",
              client: "Ana Costa",
              service: "Reforma de Sofá",
              status: "Aguardando",
              statusColor: Colors.orange,
            ),
            
            _buildOrderItem(
              code: "PO00010002",
              client: "João Santos", 
              service: "Troca de Tecido",
              status: "Aguardando",
              statusColor: Colors.orange,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xFF9c8158), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: color),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF42585c),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                color: color,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF9c8158),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      icon: Icon(icon, size: 20),
      label: Text(label),
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
            
            const SizedBox(height: 8),
            
            Text(
              "Cliente: $client",
              style: const TextStyle(color: Color(0xFF2f4653)),
            ),
            
            Text(
              "Serviço: $service", 
              style: const TextStyle(color: Color(0xFF2f4653)),
            ),
          ],
        ),
      ),
    );
  }
}
