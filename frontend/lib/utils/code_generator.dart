// Arquivo: lib/utils/code_generator.dart
class CodeGenerator {
  static Map<String, int> _sequentials = {};
  
  static String generateCode(String prefix) {
    final now = DateTime.now();
    final month = now.month.toString().padLeft(2, '0');
    final year = now.year.toString().substring(2);
    
    _sequentials[prefix] = (_sequentials[prefix] ?? 0) + 1;
    final sequential = _sequentials[prefix]!.toString().padLeft(4, '0');
    
    return '$prefix$sequential$month$year';
  }
  
  static String updateCodeStatus(String currentCode, String newStatus) {
    return newStatus + currentCode.substring(2);
  }
  
  static String generateContractCode(String osCode) {
    return 'C$osCode';
  }
}
