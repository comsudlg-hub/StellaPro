// ARQUIVO: lib/screens/enviar_orcamento_screen.dart
// TELA PARA O REPRESENTANTE INSERIR DADOS MANUALMENTE

import "package:flutter/material.dart";
import "package:cloud_firestore/cloud_firestore.dart";

class EnviarOrcamentoScreen extends StatefulWidget {
  final String orderId;
  final String orderCode;

  const EnviarOrcamentoScreen({super.key, required this.orderId, required this.orderCode});

  @override
  State<EnviarOrcamentoScreen> createState() => _EnviarOrcamentoScreenState();
}

class _EnviarOrcamentoScreenState extends State<EnviarOrcamentoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _valorController = TextEditingController();
  final _prazoController = TextEditingController();
  final _observacoesController = TextEditingController();
  
  // FORMAS DE PAGAMENTO FLEXÍVEIS
  String _formaPagamentoSelecionada = '';
  final List<Map<String, dynamic>> _opcoesPagamento = [
    {'value': 'pix', 'label': 'PIX à Vista', 'selected': false},
    {'value': 'cartao_1x', 'label': 'Cartão 1x sem juros', 'selected': false},
    {'value': 'cartao_2x', 'label': 'Cartão 2x com juros', 'selected': false},
    {'value': 'cartao_5x', 'label': 'Cartão 5x com juros', 'selected': false},
    {'value': 'cartao_10x', 'label': 'Cartão 10x com juros', 'selected': false},
    {'value': 'entrada_50', 'label': '50% entrada + 50% entrega', 'selected': false},
    {'value': 'personalizado', 'label': 'Personalizado (negociável)', 'selected': false},
  ];

  // ✅ ENVIAR ORÇAMENTO PARA O CLIENTE
  void _enviarOrcamento() async {
    if (_formKey.currentState!.validate()) {
      if (_formaPagamentoSelecionada.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Selecione uma forma de pagamento"))
        );
        return;
      }

      try {
        // SALVAR NO FIRESTORE
        await FirebaseFirestore.instance.collection("orcamentos").add({
          "codigo": widget.orderCode,
          "clienteId": widget.orderId,
          "valor": double.parse(_valorController.text),
          "prazo": int.parse(_prazoController.text),
          "formaPagamento": _formaPagamentoSelecionada,
          "observacoes": _observacoesController.text,
          "status": "orcamento_enviado",
          "dataEnvio": FieldValue.serverTimestamp(),
          "tipo": "manual" // ✅ DIFERENCIAR ORÇAMENTO MANUAL
        });

        // ✅ ENVIAR PARA CLIENTE (EMAIL/WHATSAPP)
        print("📤 ORÇAMENTO ENVIADO: ${widget.orderCode}");
        print("💵 Valor: R\$${_valorController.text}");
        print("📅 Prazo: ${_prazoController.text} dias");
        print("💳 Forma de pagamento: $_formaPagamentoSelecionada");

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Orçamento enviado para o cliente!"))
        );
        
        Navigator.pop(context);

      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erro: $e"))
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFebe7dc),
      appBar: AppBar(
        title: Text("Enviar Orçamento - ${widget.orderCode}"),
        backgroundColor: const Color(0xFF9c8158),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // ✅ VALOR DO SERVIÇO
              TextFormField(
                controller: _valorController,
                decoration: const InputDecoration(
                  labelText: "Valor do Serviço (R\$)*",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? "Informe o valor" : null,
              ),

              const SizedBox(height: 20),

              // ✅ PRAZO DE ENTREGA
              TextFormField(
                controller: _prazoController,
                decoration: const InputDecoration(
                  labelText: "Prazo de Entrega (dias)*",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? "Informe o prazo" : null,
              ),

              const SizedBox(height: 20),

              // ✅ FORMAS DE PAGAMENTO
              const Text(
                "Forma de Pagamento*",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              
              Column(
                children: _opcoesPagamento.map((opcao) {
                  return RadioListTile(
                    title: Text(opcao['label']),
                    value: opcao['value'],
                    groupValue: _formaPagamentoSelecionada,
                    onChanged: (value) {
                      setState(() {
                        _formaPagamentoSelecionada = value!;
                      });
                    },
                  );
                }).toList(),
              ),

              const SizedBox(height: 20),

              // ✅ OBSERVAÇÕES
              TextFormField(
                controller: _observacoesController,
                decoration: const InputDecoration(
                  labelText: "Observações ou Condições Especiais",
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                maxLines: 3,
              ),

              const SizedBox(height: 30),

              // ✅ BOTÃO ENVIAR
              ElevatedButton(
                onPressed: _enviarOrcamento,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF9c8158),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  "Enviar Orçamento para Cliente",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
