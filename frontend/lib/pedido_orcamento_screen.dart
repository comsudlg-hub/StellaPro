import "package:flutter/material.dart";

class PedidoOrcamentoScreen extends StatefulWidget {
  const PedidoOrcamentoScreen({super.key});

  @override
  State<PedidoOrcamentoScreen> createState() => _PedidoOrcamentoScreenState();
}

class _PedidoOrcamentoScreenState extends State<PedidoOrcamentoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _clientNameController = TextEditingController();
  final _clientEmailController = TextEditingController();
  final _clientPhoneController = TextEditingController();
  final _clientAddressController = TextEditingController();
  final _clientNumberController = TextEditingController();
  final _clientComplementController = TextEditingController();
  final _clientNeighborhoodController = TextEditingController();
  final _clientCityController = TextEditingController();
  final _clientStateController = TextEditingController();
  final _clientZipCodeController = TextEditingController();
  final _serviceDescriptionController = TextEditingController();
  final _otherServiceController = TextEditingController();
  final _otherFurnitureController = TextEditingController();

  // Tipos de serviço - Lista suspensa múltipla escolha
  final List<Map<String, dynamic>> _serviceTypes = [
    {'value': 'fabricacao', 'label': 'Fabricação', 'selected': false},
    {'value': 'manutencao', 'label': 'Manutenção', 'selected': false},
    {'value': 'impermeabilizacao', 'label': 'Impermeabilização', 'selected': false},
    {'value': 'higienizacao', 'label': 'Higienização', 'selected': false},
    {'value': 'outros', 'label': 'Outros', 'selected': false},
  ];
  bool _showOtherServiceField = false;

  // Tipos de estofado - Lista suspensa múltipla escolha com quantidades
  final List<Map<String, dynamic>> _furnitureTypes = [
    {'value': 'sofa', 'label': 'Sofá', 'selected': false, 'quantity': 0},
    {'value': 'poltrona', 'label': 'Poltrona', 'selected': false, 'quantity': 0},
    {'value': 'cadeira', 'label': 'Cadeira', 'selected': false, 'quantity': 0},
    {'value': 'outros', 'label': 'Outros', 'selected': false, 'quantity': 0},
  ];
  bool _showOtherFurnitureField = false;

  void _toggleServiceSelection(int index) {
    setState(() {
      _serviceTypes[index]['selected'] = !_serviceTypes[index]['selected'];
      
      // Mostrar/ocultar campo "Outros" para serviços
      if (_serviceTypes[index]['value'] == 'outros') {
        _showOtherServiceField = _serviceTypes[index]['selected'] as bool;
        if (!_showOtherServiceField) {
          _otherServiceController.clear();
        }
      }
    });
  }

  void _toggleFurnitureSelection(int index) {
    setState(() {
      _furnitureTypes[index]['selected'] = !_furnitureTypes[index]['selected'];
      
      // Mostrar/ocultar campo "Outros" para estofados
      if (_furnitureTypes[index]['value'] == 'outros') {
        _showOtherFurnitureField = _furnitureTypes[index]['selected'] as bool;
        if (!_showOtherFurnitureField) {
          _otherFurnitureController.clear();
        }
      }
    });
  }

  void _updateFurnitureQuantity(int index, int quantity) {
    setState(() {
      _furnitureTypes[index]['quantity'] = quantity;
    });
  }

  bool _hasSelectedServices() {
    return _serviceTypes.any((service) => service['selected'] as bool);
  }

  bool _hasSelectedFurniture() {
    return _furnitureTypes.any((furniture) => furniture['selected'] as bool);
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (!_hasSelectedServices()) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Selecione pelo menos um tipo de serviço")),
        );
        return;
      }

      if (!_hasSelectedFurniture()) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Selecione pelo menos um tipo de estofado")),
        );
        return;
      }

      // TODO: Salvar no Firebase e mudar status para PO
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Pedido de orçamento enviado com sucesso!")),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFebe7dc),
      appBar: AppBar(
        title: const Text(
          "Solicitar Orçamento",
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
              // Seção Dados Pessoais
              const Text(
                "Dados Pessoais",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF42585c),
                ),
              ),
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _clientNameController,
                decoration: _buildInputDecoration("Nome Completo *"),
                validator: (value) => value!.isEmpty ? "Campo obrigatório" : null,
              ),
              
              const SizedBox(height: 12),
              
              TextFormField(
                controller: _clientEmailController,
                decoration: _buildInputDecoration("E-mail *"),
                keyboardType: TextInputType.emailAddress,
                validator: (value) => value!.isEmpty ? "Campo obrigatório" : null,
              ),
              
              const SizedBox(height: 12),
              
              TextFormField(
                controller: _clientPhoneController,
                decoration: _buildInputDecoration("Telefone *"),
                keyboardType: TextInputType.phone,
                validator: (value) => value!.isEmpty ? "Campo obrigatório" : null,
              ),
              
              const SizedBox(height: 24),
              
              // Seção Endereço
              const Text(
                "Endereço Completo",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF42585c),
                ),
              ),
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _clientAddressController,
                decoration: _buildInputDecoration("Logradouro *"),
                validator: (value) => value!.isEmpty ? "Campo obrigatório" : null,
              ),
              
              const SizedBox(height: 12),
              
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      controller: _clientNumberController,
                      decoration: _buildInputDecoration("Número *"),
                      keyboardType: TextInputType.number,
                      validator: (value) => value!.isEmpty ? "Campo obrigatório" : null,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                      controller: _clientComplementController,
                      decoration: _buildInputDecoration("Complemento"),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 12),
              
              TextFormField(
                controller: _clientNeighborhoodController,
                decoration: _buildInputDecoration("Bairro *"),
                validator: (value) => value!.isEmpty ? "Campo obrigatório" : null,
              ),
              
              const SizedBox(height: 12),
              
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                      controller: _clientCityController,
                      decoration: _buildInputDecoration("Cidade *"),
                      validator: (value) => value!.isEmpty ? "Campo obrigatório" : null,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      controller: _clientStateController,
                      decoration: _buildInputDecoration("UF *"),
                      maxLength: 2,
                      validator: (value) => value!.isEmpty ? "Campo obrigatório" : null,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      controller: _clientZipCodeController,
                      decoration: _buildInputDecoration("CEP *"),
                      keyboardType: TextInputType.number,
                      validator: (value) => value!.isEmpty ? "Campo obrigatório" : null,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 24),
              
              // Seção Tipo de Serviço - Lista suspensa múltipla escolha
              const Text(
                "Tipo de Serviço *",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF42585c),
                ),
              ),
              const SizedBox(height: 12),
              
              Column(
                children: _serviceTypes.asMap().entries.map((entry) {
                  final index = entry.key;
                  final service = entry.value;
                  return CheckboxListTile(
                    title: Text(service['label']),
                    value: service['selected'] as bool,
                    onChanged: (value) => _toggleServiceSelection(index),
                    activeColor: const Color(0xFF9c8158),
                  );
                }).toList(),
              ),
              
              // Campo "Outros" para serviços
              if (_showOtherServiceField) ...[
                const SizedBox(height: 12),
                TextFormField(
                  controller: _otherServiceController,
                  decoration: _buildInputDecoration("Especifique o outro serviço *"),
                  validator: (value) => value!.isEmpty ? "Campo obrigatório" : null,
                ),
              ],
              
              const SizedBox(height: 24),
              
              // Seção Tipo de Estofado - Lista suspensa múltipla escolha com quantidades
              const Text(
                "Tipos de Estofado *",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF42585c),
                ),
              ),
              const SizedBox(height: 12),
              
              Column(
                children: _furnitureTypes.asMap().entries.map((entry) {
                  final index = entry.key;
                  final furniture = entry.value;
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          CheckboxListTile(
                            title: Text(furniture['label']),
                            value: furniture['selected'] as bool,
                            onChanged: (value) => _toggleFurnitureSelection(index),
                            activeColor: const Color(0xFF9c8158),
                          ),
                          
                          if (furniture['selected'] as bool) ...[
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Quantidade:"),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.remove),
                                      onPressed: () => _updateFurnitureQuantity(index, (furniture['quantity'] as int) - 1),
                                    ),
                                    Text(
                                      furniture['quantity'].toString(),
                                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.add),
                                      onPressed: () => _updateFurnitureQuantity(index, (furniture['quantity'] as int) + 1),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              
              // Campo "Outros" para estofados
              if (_showOtherFurnitureField) ...[
                const SizedBox(height: 12),
                TextFormField(
                  controller: _otherFurnitureController,
                  decoration: _buildInputDecoration("Especifique o outro estofado *"),
                  validator: (value) => value!.isEmpty ? "Campo obrigatório" : null,
                ),
              ],
              
              const SizedBox(height: 24),
              
              // Seção Descrição do Serviço
              const Text(
                "Descrição do Serviço",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF42585c),
                ),
              ),
              const SizedBox(height: 12),
              
              TextFormField(
                controller: _serviceDescriptionController,
                maxLines: 3,
                decoration: _buildInputDecoration("Descreva detalhadamente o serviço necessário..."),
              ),
              
              const SizedBox(height: 24),
              
              // Seção Fotos (placeholder para futura implementação)
              const Text(
                "Fotos do Estofado",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF42585c),
                ),
              ),
              const SizedBox(height: 12),
              
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF9c8158)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Column(
                  children: [
                    Icon(Icons.camera_alt, size: 48, color: Color(0xFF9c8158)),
                    SizedBox(height: 8),
                    Text(
                      "Upload de fotos será implementado na próxima fase",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xFF42585c)),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Botão Enviar
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF9c8158),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Solicitar Orçamento",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF9c8158)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF9c8158), width: 2),
      ),
    );
  }
}
