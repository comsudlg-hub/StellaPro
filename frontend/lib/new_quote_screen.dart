import "package:flutter/material.dart";

class NewQuoteScreen extends StatefulWidget {
  const NewQuoteScreen({super.key});

  @override
  State<NewQuoteScreen> createState() => _NewQuoteScreenState();
}

class _NewQuoteScreenState extends State<NewQuoteScreen> {
  final _formKey = GlobalKey<FormState>();
  final _clientNameController = TextEditingController();
  final _clientPhoneController = TextEditingController();
  final _serviceDescriptionController = TextEditingController();
  final _priceController = TextEditingController();

  String _selectedFabric = "";
  String _selectedPriority = "normal";
  bool _isAutoPricing = true;
  double _suggestedPrice = 0.0;

  final List<String> _fabrics = [
    "Couro sintético preto - R\$ 85/m",
    "Linho bege - R\$ 120/m", 
    "Veludo azul - R\$ 150/m",
    "Suede marrom - R\$ 180/m",
    "Tecido técnico - R\$ 200/m"
  ];

  final Map<String, double> _fabricPrices = {
    "Couro sintético preto - R\$ 85/m": 85.0,
    "Linho bege - R\$ 120/m": 120.0,
    "Veludo azul - R\$ 150/m": 150.0,
    "Suede marrom - R\$ 180/m": 180.0,
    "Tecido técnico - R\$ 200/m": 200.0
  };

  @override
  void initState() {
    super.initState();
    _calculateSuggestedPrice();
  }

  void _calculateSuggestedPrice() {
    // Cálculo automático baseado em tecido + mão de obra + margem
    double fabricCost = _fabricPrices[_selectedFabric] ?? 0.0;
    double laborCost = 250.0; // Valor base mão de obra
    double profitMargin = 1.4; // 40% de margem
    double stellaCommission = 1.1; // 10% comissão

    setState(() {
      _suggestedPrice = (fabricCost + laborCost) * profitMargin * stellaCommission;
      if (_isAutoPricing) {
        _priceController.text = _suggestedPrice.toStringAsFixed(2);
      }
    });
  }

  void _togglePricingMode() {
    setState(() {
      _isAutoPricing = !_isAutoPricing;
      if (_isAutoPricing) {
        _priceController.text = _suggestedPrice.toStringAsFixed(2);
      } else {
        _priceController.clear();
      }
    });
  }

  void _validateManualPrice(String value) {
    if (!_isAutoPricing && value.isNotEmpty) {
      double manualPrice = double.tryParse(value) ?? 0.0;
      double difference = _suggestedPrice - manualPrice;
      double percentage = (_suggestedPrice > 0) ? (difference / _suggestedPrice * 100) : 0;

      if (percentage > 20) {
        // Alertar sobre valor muito abaixo
        _showPriceWarning(percentage);
      }
    }
  }

  void _showPriceWarning(double percentage) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Valor abaixo do recomendado"),
        content: Text("O valor inserido está ${percentage.toStringAsFixed(0)}% abaixo do preço sugerido. Deseja continuar?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Corrigir"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
            ),
            child: const Text("Continuar assim"),
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
          "Novo Orçamento",
          style: TextStyle(
            color: Color(0xFF42585c),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFFebe7dc),
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF42585c)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Seção Cliente
              const Text(
                "Dados do Cliente",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF42585c),
                ),
              ),
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _clientNameController,
                decoration: InputDecoration(
                  labelText: "Nome do Cliente",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF9c8158)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF9c8158), width: 2),
                  ),
                ),
                validator: (value) => value!.isEmpty ? "Campo obrigatório" : null,
              ),
              
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _clientPhoneController,
                decoration: InputDecoration(
                  labelText: "Telefone",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF9c8158)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF9c8158), width: 2),
                  ),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) => value!.isEmpty ? "Campo obrigatório" : null,
              ),
              
              const SizedBox(height: 24),
              
              // Seção Serviço
              const Text(
                "Detalhes do Serviço",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF42585c),
                ),
              ),
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _serviceDescriptionController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: "Descrição do Serviço",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF9c8158)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF9c8158), width: 2),
                  ),
                ),
                validator: (value) => value!.isEmpty ? "Campo obrigatório" : null,
              ),
              
              const SizedBox(height: 16),
              
              DropdownButtonFormField<String>(
                value: _selectedFabric,
                decoration: InputDecoration(
                  labelText: "Tecido",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF9c8158)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF9c8158), width: 2),
                  ),
                ),
                items: _fabrics.map((fabric) {
                  return DropdownMenuItem(
                    value: fabric,
                    child: Text(fabric),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedFabric = value!;
                    _calculateSuggestedPrice();
                  });
                },
                validator: (value) => value == null ? "Selecione um tecido" : null,
              ),
              
              const SizedBox(height: 24),
              
              // Seção Precificação
              const Text(
                "Precificação",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF42585c),
                ),
              ),
              const SizedBox(height: 16),
              
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _isAutoPricing ? null : _togglePricingMode,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isAutoPricing ? const Color(0xFF9c8158) : Colors.grey[300],
                        foregroundColor: _isAutoPricing ? Colors.white : const Color(0xFF42585c),
                      ),
                      child: const Text("Automático"),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _isAutoPricing ? _togglePricingMode : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: !_isAutoPricing ? const Color(0xFF9c8158) : Colors.grey[300],
                        foregroundColor: !_isAutoPricing ? Colors.white : const Color(0xFF42585c),
                      ),
                      child: const Text("Manual"),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(
                  labelText: "Valor do Orçamento (R\$)",
                  prefixText: "R\$ ",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF9c8158)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF9c8158), width: 2),
                  ),
                  suffixIcon: _isAutoPricing
                      ? const Tooltip(
                          message: "Preço calculado automaticamente",
                          child: Icon(Icons.auto_awesome, color: Colors.green),
                        )
                      : null,
                ),
                keyboardType: TextInputType.number,
                readOnly: _isAutoPricing,
                onChanged: _validateManualPrice,
                validator: (value) => value!.isEmpty ? "Campo obrigatório" : null,
              ),
              
              if (_isAutoPricing) ...[
                const SizedBox(height: 8),
                Text(
                  "Preço sugerido baseado em tecido + mão de obra + margem",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
              
              const SizedBox(height: 32),
              
              // Botão Criar Orçamento
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // TODO: Salvar orçamento no Firebase
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Orçamento criado com sucesso!")),
                    );
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF9c8158),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Criar Orçamento",
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
