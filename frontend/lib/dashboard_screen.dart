import "package:flutter/material.dart";
import "clients_screen.dart";
import "components/status_chip.dart";
import "utils/code_generator.dart";

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String _setorAtivo = "Vendas";

  // Dados de exemplo - depois virão do Firestore
  final List<Map<String, dynamic>> _pedidos = [
    {"codigo": "PO00010825", "cliente": "João Silva", "servico": "Reforma de Sofá", "status": "PO"},
    {"codigo": "NO00020825", "cliente": "Maria Santos", "servico": "Poltrona", "status": "NO"},
    {"codigo": "OA00030825", "cliente": "José Oliveira", "servico": "Sofá 3 lugares", "status": "OA"},
  ];

  void _showQuickStatusChange(BuildContext context, String codigo, String statusAtual) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Mudança Rápida de Status",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            
            // BOTÕES DE AÇÃO BASEADO NO STATUS ATUAL
            if (statusAtual == "PO") ...[
              _buildStatusButton("NO", "📋 Virar Novo Orçamento", Colors.blue, () {
                _changeOrderStatus(codigo, "NO");
                Navigator.pop(context);
              }),
            ],
            
            if (statusAtual == "NO") ...[
              _buildStatusButton("OA", "✅ Cliente Aprovou", Colors.green, () {
                _changeOrderStatus(codigo, "OA");
                Navigator.pop(context);
              }),
              _buildStatusButton("canceled", "❌ Cancelar", Colors.red, () {
                _changeOrderStatus(codigo, "canceled");
                Navigator.pop(context);
              }),
            ],
            
            if (statusAtual == "OA") ...[
              _buildStatusButton("VT", "📅 Agendar Visita Técnica", Colors.purple, () {
                _changeOrderStatus(codigo, "VT");
                Navigator.pop(context);
              }),
              _buildStatusButton("OS", "📝 Gerar OS Direto", Colors.teal, () {
                _changeOrderStatus(codigo, "OS");
                Navigator.pop(context);
              }),
            ],
            
            if (statusAtual == "VT") ...[
              _buildStatusButton("OS", "📝 Gerar Ordem de Serviço", Colors.teal, () {
                _changeOrderStatus(codigo, "OS");
                Navigator.pop(context);
              }),
            ],
            
            if (statusAtual == "OS") ...[
              _buildStatusButton("completed", "✅ Concluir Serviço", Colors.green, () {
                _changeOrderStatus(codigo, "completed");
                Navigator.pop(context);
              }),
            ],
            
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Fechar"),
            ),
          ],
        ),
      ),
    );
  }

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

  Widget _buildStatusButton(String status, String label, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 50),
      ),
      child: Text(label, style: const TextStyle(fontSize: 16)),
    );
  }

  void _changeOrderStatus(String codigo, String novoStatus) {
    // TODO: Integrar com Firebase Firestore
    final novoCodigo = CodeGenerator.updateCodeStatus(codigo, novoStatus);
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Status alterado: $codigo → $novoCodigo"),
        backgroundColor: Colors.green,
      ),
    );
    
    // Atualizar lista local
    setState(() {
      final pedido = _pedidos.firstWhere((p) => p["codigo"] == codigo);
      pedido["status"] = novoStatus;
      pedido["codigo"] = novoCodigo;
    });
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
          // BARRA DE AÇÕES RÁPIDAS POR SETOR
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
                
                // AÇÕES DO SETOR DE VENDAS
                if (_setorAtivo == 'Vendas') Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _buildTopActionButton(
                      icon: Icons.add,
                      label: "Novo Pedido PO",
                      onPressed: () {}, // Implementar
                    ),
                    _buildTopActionButton(
                      icon: Icons.send,
                      label: "Enviar Orçamento", 
                      onPressed: () {}, // Implementar
                    ),
                    _buildTopActionButton(
                      icon: Icons.calendar_today,
                      label: "Agendar Visita",
                      onPressed: () {}, // Implementar
                    ),
                    _buildTopActionButton(
                      icon: Icons.assignment,
                      label: "Gerar OS",
                      onPressed: () {}, // Implementar
                    ),
                  ],
                ),
              ],
            ),
          ),

          // LISTA DE PEDIDOS
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
                  
                  // LISTA DE PEDIDOS
                  ..._pedidos.map((pedido) => Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(pedido['codigo'], style: const TextStyle(fontWeight: FontWeight.bold)),
                                Text("Cliente: ${pedido['cliente']}"),
                                Text("Serviço: ${pedido['servico']}"),
                              ],
                            ),
                          ),
                          StatusChip(
                            status: pedido['status'],
                            code: pedido['codigo'],
                            onTap: () => _showQuickStatusChange(context, pedido['codigo'], pedido['status']),
                          ),
                        ],
                      ),
                    ),
                  )).toList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


