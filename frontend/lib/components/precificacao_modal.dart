// Arquivo: lib/components/precificacao_modal.dart
import "package:flutter/material.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_core/firebase_core.dart";

class PrecificacaoModal extends StatefulWidget {
  final String orderId;
  final String orderCode;

  const PrecificacaoModal({super.key, required this.orderId, required this.orderCode});

  @override
  State<PrecificacaoModal> createState() => _PrecificacaoModalState();
}

class _PrecificacaoModalState extends State<PrecificacaoModal> {
  final _formKey = GlobalKey<FormState>();
  final _valorController = TextEditingController();
  final _prazoController = TextEditingController();
  final _observacoesController = TextEditingController();
  
  final Map<String, bool> _formasPagamento = {
    'cartao_credito': false,
    'cartao_debito': false,
    'pix': false,
    'dinheiro': false,
    'boleto': false,
    'transferencia': false,
  };

  void _calcularPrecoAutomatico() {
    final precoBase = 250.0;
    final taxaUrgencia = _prazoController.text.isEmpty ? 0 : (30 - int.parse(_prazoController.text)) * 10;
    final precoFinal = precoBase + taxaUrgencia;
    
    setState(() {
      _valorController.text = precoFinal.toStringAsFixed(2);
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Preço calculado: R\$ $precoFinal"))
    );
  }

  void _enviarOrcamento() async {
    if (_formKey.currentState!.validate()) {
      if (!_formasPagamento.containsValue(true)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Selecione pelo menos uma forma de pagamento"))
        );
        return;
      }

      try {
        final formasSelecionadas = _formasPagamento.entries
            .where((entry) => entry.value)
            .map((entry) => entry.key)
            .toList();

        await FirebaseFirestore.instance.collection("orcamentos").add({
          "codigo": widget.orderCode,
          "clienteId": widget.orderId,
          "valor": double.parse(_valorController.text),
          "prazo": int.parse(_prazoController.text),
          "formasPagamento": formasSelecionadas,
          "observacoes": _observacoesController.text,
          "status": "enviado",
          "dataEnvio": FieldValue.serverTimestamp(),
          "dataCriacao": FieldValue.serverTimestamp(),
        });

        print("📤 Orçamento enviado: ${widget.orderCode}");
        print("💵 Valor: R\$${_valorController.text}");
        print("📅 Prazo: ${_prazoController.text} dias");
        print("💳 Formas de pagamento: $formasSelecionadas");

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Orçamento enviado com sucesso! Cliente notificado."))
        );
        
        Navigator.pop(context);

      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erro ao enviar orçamento: $e"))
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Color(0xFFebe7dc),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          // CABEÇALHO COM BOTÃO FECHAR
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Precificação - ${widget.orderCode}",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF42585c)),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: Color(0xFF42585c)),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const Divider(color: Color(0xFF9c8158)),
          const SizedBox(height: 16),

          // CONTEÚDO DO MODAL
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // ... (resto do conteúdo do modal permanece igual)
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            const Text(
                              "Precificação Automática",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              "Sistema calcula o valor baseado na complexidade do serviço e prazo",
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: _calcularPrecoAutomatico,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF42585c),
                              ),
                              child: const Text("Calcular Preço Automaticamente"),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),
                    const Text("Precificação Manual", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    TextFormField(controller: _valorController, decoration: const InputDecoration(labelText: "Valor do Serviço (R\$)*"), keyboardType: TextInputType.number, validator: (value) => value!.isEmpty ? "Informe o valor" : null),
                    const SizedBox(height: 16),
                    TextFormField(controller: _prazoController, decoration: const InputDecoration(labelText: "Prazo de Entrega (dias)*"), keyboardType: TextInputType.number, validator: (value) => value!.isEmpty ? "Informe o prazo" : null),
                    const SizedBox(height: 24),
                    const Text("Formas de Pagamento*", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    ..._formasPagamento.entries.map((entry) => CheckboxListTile(title: Text(_getFormaPagamentoLabel(entry.key)), value: entry.value, onChanged: (value) => setState(() => _formasPagamento[entry.key] = value!))).toList(),
                    const SizedBox(height: 24),
                    TextFormField(controller: _observacoesController, decoration: const InputDecoration(labelText: "Observações"), maxLines: 3),
                    const SizedBox(height: 32),
                    ElevatedButton(onPressed: _enviarOrcamento, style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF9c8158), padding: const EdgeInsets.symmetric(vertical: 16)), child: const Text("Enviar Orçamento para Cliente", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getFormaPagamentoLabel(String key) {
    final labels = {
      'cartao_credito': 'Cartão de Crédito',
      'cartao_debito': 'Cartão de Débito',
      'pix': 'PIX',
      'dinheiro': 'Dinheiro',
      'boleto': 'Boleto Bancário',
      'transferencia': 'Transferência Bancária',
    };
    return labels[key] ?? key;
  }
}
