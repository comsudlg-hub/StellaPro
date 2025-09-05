import "package:flutter/material.dart";
import "clients_screen.dart";
import "screens/enviar_orcamento_screen.dart";
import "screens/enviar_orcamento_screen.dart";
import "pedido_orcamento_screen.dart";

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String _setorAtivo = 'Vendas';

  Widget _buildSetorTab(String setor, IconData icon, bool isActive) {
    return GestureDetector(
      onTap: () => setState(() => _setorAtivo = setor),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF9c8158) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFF9c8158)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: isActive ? Colors.white : const Color(0xFF9c8158)),
            const SizedBox(width: 4),
            Text(
              setor,
              style: TextStyle(
                color: isActive ? Colors.white : const Color(0xFF9c8158),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopActionButton({required IconData icon, required String label, required VoidCallback onPressed}) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF9c8158),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      icon: Icon(icon, size: 18),
      label: Text(label, style: const TextStyle(fontSize: 12)),
    );
  }

  Widget _buildOrderItem(String code, String client, String service, String status, Color statusColor) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(code, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF42585c))),
                  Text("Cliente: $client", style: const TextStyle(color: Color(0xFF2f4653))),
                  Text("Serviço: $service", style: const TextStyle(color: Color(0xFF2f4653))),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: statusColor),
              ),
              child: Text(status, style: TextStyle(color: statusColor, fontSize: 12)),
            ),
            IconButton(
              icon: const Icon(Icons.help_outline, color: Colors.grey, size: 20),
              onPressed: () => _showOrderDetails(context, code),
              tooltip: "Consultar detalhes",
            ),
            IconButton(
              icon: const Icon(Icons.bolt, color: Colors.orange, size: 20),
              onPressed: () => _showQuickStatusChange(context, code, status),
              tooltip: "Mudança rápida de status",
            ),
          ],
        ),
      ),
    );
  }

  void _showOrderDetails(BuildContext context, String code) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Detalhes do Pedido"),
        content: Text("Detalhes do pedido $code serão implementados."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Fechar"),
          ),
        ],
      ),
    );
  }

  void _showQuickStatusChange(BuildContext context, String code, String status) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Mudança de Status"),
        content: Text("Mudança de status para $status será implementada."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Fechar"),
          ),
        ],
      ),
    );
  }

  void _showPrecificacaoModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Precificação"),
        content: const Text("Sistema de precificação será implementado."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Fechar"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFebe7dc),
      appBar: AppBar(
        title: const Text(
          "Painel de Controle StellaPro",
          style: TextStyle(
            color: Color(0xFF42585c),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFFebe7dc),
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF42585c)),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: const Color(0xFFf5f3ee),
            child: Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildSetorTab('Vendas', Icons.sell, _setorAtivo == 'Vendas'),
                      _buildSetorTab('Logística', Icons.local_shipping, _setorAtivo == 'Logística'),
                      _buildSetorTab('Produção', Icons.build, _setorAtivo == 'Produção'),
                      _buildSetorTab('Gerência', Icons.business_center, _setorAtivo == 'Gerência'),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                
                if (_setorAtivo == 'Vendas') Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _buildTopActionButton(
                          icon: Icons.add,
                          label: "Novo Pedido PO",
                          onPressed: () => Navigator.push(context, 
                            MaterialPageRoute(builder: (context) => const PedidoOrcamentoScreen())),
                      onPressed: () => Navigator.push(context, 
                        MaterialPageRoute(builder: (context) => const PedidoOrcamentoScreen())),
                    ),
                    _buildTopActionButton(
                      icon: Icons.send,
                      label: "Enviar Orçamento",

                    ),
                    _buildTopActionButton(
                          icon: Icons.calendar_today,
                          label: "Agendar Visita",
                          onPressed: () => _showQuickStatusChange(context, null, "OA"),
                      onPressed: () => _showQuickStatusChange(context, "EXEMPLO", "OA"),
                    ),
                    _buildTopActionButton(
                          icon: Icons.assignment,
                          label: "Gerar OS",
                          onPressed: () => _showQuickStatusChange(context, null, "VT"),
                      onPressed: () => _showQuickStatusChange(context, "EXEMPLO", "VT"),
                    ),
                  ],
                ),
                
                if (_setorAtivo != 'Vendas') const Text("Em desenvolvimento...", style: TextStyle(color: Color(0xFF42585c))),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Últimos Pedidos",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF42585c),
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  _buildOrderItem("PO00010825", "João Silva", "Reforma de Sofá", "Aguardando", Colors.orange),
                  _buildOrderItem("NO00020825", "Maria Santos", "Poltrona", "Precificando", Colors.blue),
                  _buildOrderItem("OA00030825", "José Oliveira", "Sofá 3 lugares", "Aprovado", Colors.green),
                  _buildOrderItem("VT00040825", "Ana Costa", "Loveseat", "Visita Agendada", Colors.purple),
                  _buildOrderItem("OS00050825", "Carlos Souza", "Cadeira", "Em produção", Colors.teal),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}



















// Adicionar no início do _DashboardScreenState
final List<Map<String, dynamic>> _pedidosPO = [
  {
    'id': '1',
    'codigo': 'PO00010825',
    'cliente': 'João Silva',
    'servico': 'Reforma de Sofá 3 lugares',
    'status': 'aguardando',
    'data': '2025-08-01'
  },
  {
    'id': '2', 
    'codigo': 'PO00020825',
    'cliente': 'Maria Santos',
    'servico': 'Poltrona Executiva',
    'status': 'aguardando',
    'data': '2025-08-02'
  },
  {
    'id': '3',
    'codigo': 'PO00030825', 
    'cliente': 'José Oliveira',
    'servico': 'Sofá Retrátil',
    'status': 'aguardando',
    'data': '2025-08-03'
  }
];

  // ✅ FUNÇÃO PARA ENVIAR ORÇAMENTO (AGORA RECEBE O PEDIDO)
  void _showEnviarOrcamentoScreen(BuildContext context, Map<String, dynamic> pedido) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EnviarOrcamentoScreen(
          orderId: pedido['id'],
          orderCode: pedido['codigo'],
        ),
      ),
    );
  }



