import .package:cloud_firestore/cloud_firestore.dart.;
import .status_rules.dart.;

class CodeGenerator {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  static Future<String> getNextCode(String status) async {
    try {
      // Buscar ou criar contador para este status
      final counterDoc = await _firestore.collection('counters').doc(status).get();
      int nextSequential = 1;
      
      if (counterDoc.exists) {
        nextSequential = (counterDoc.data()!['value'] ?? 0) + 1;
      }
      
      // Atualizar contador no Firestore
      await _firestore.collection('counters').doc(status).set({
        'value': nextSequential,
        'lastUpdated': FieldValue.serverTimestamp()
      });
      
      // Gerar código com sequencial, mês e ano
      final now = DateTime.now();
      final month = now.month.toString().padLeft(2, '0');
      final year = now.year.toString().substring(2);
      
      return '$status${nextSequential.toString().padLeft(4, '0')}$month$year';
      
    } catch (e) {
      // Fallback para caso Firestore não esteja disponível
      final now = DateTime.now();
      final month = now.month.toString().padLeft(2, '0');
      final year = now.year.toString().substring(2);
      return '${status}0001$month$year';
    }
  }
  
  static String updateCodeStatus(String currentCode, String newStatus) {
    // Mantém sequencial, mês e ano, muda apenas o prefixo
    return newStatus + currentCode.substring(2);
  }
  
  static String generateContractCode(String osCode) {
    // Contrato mantém mesma sequência da OS, com prefixo 'C'
    return 'C' + osCode;
  }
}


