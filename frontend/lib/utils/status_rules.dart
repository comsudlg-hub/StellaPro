// Arquivo: lib/utils/status_rules.dart

class StatusRules {
  // ✅ DEFINIÇÃO DOS STATUS E SUAS TRANSIÇÕES PERMITIDAS (SEM DOWNGRADE)
  static const Map<String, List<String>> allowedTransitions = {
    'PO': ['NO', 'canceled'],    // Pedido Orçamento → Novo Orçamento ou Cancelado
    'NO': ['OA', 'canceled'],    // Novo Orçamento → Orçamento Aprovado ou Cancelado  
    'OA': ['VT', 'OS', 'canceled'], // Aprovado → Visita Técnica ou OS direto ou Cancelado
    'VT': ['OS', 'canceled'],    // Visita Técnica → Ordem Serviço ou Cancelado
    'OS': ['COS', 'completed'],  // Ordem Serviço → Contrato ou Concluído
    'COS': ['completed'],        // Contrato → Concluído (final)
    'completed': [],             // Status final - nenhuma transição
    'canceled': [],              // Status final - nenhuma transição
  };

  // ✅ VERIFICAR SE TRANSIÇÃO É PERMITIDA (BLOQUEIA DOWNGRADE)
  static bool isTransitionAllowed(String currentStatus, String newStatus) {
    final allowed = allowedTransitions[currentStatus] ?? [];
    return allowed.contains(newStatus);
  }

  // ✅ OBTER PRÓXIMOS STATUS POSSÍVEIS (PARA UI)
  static List<String> getNextPossibleStatuses(String currentStatus) {
    return allowedTransitions[currentStatus] ?? [];
  }

  // ✅ VALIDAR SE É DOWNGRADE (PROIBIDO)
  static bool isDowngrade(String currentStatus, String newStatus) {
    final statusHierarchy = ['PO', 'NO', 'OA', 'VT', 'OS', 'COS', 'completed'];
    final currentIndex = statusHierarchy.indexOf(currentStatus);
    final newIndex = statusHierarchy.indexOf(newStatus);
    
    return newIndex < currentIndex && newIndex != -1;
  }
}
