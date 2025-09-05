// Arquivo: lib/components/status_chip.dart
import "package:flutter/material.dart";

class StatusChip extends StatelessWidget {
  final String status;
  final String code;
  final VoidCallback onTap;

  const StatusChip({
    super.key,
    required this.status,
    required this.code,
    required this.onTap,
  });

  Color _getStatusColor() {
    switch (status) {
      case 'PO': return Colors.orange; // Aguardando
      case 'NO': return Colors.blue;   // Precificando  
      case 'OA': return Colors.green;  // Aprovado
      case 'VT': return Colors.purple; // Visita Agendada
      case 'OS': return Colors.teal;   // Em produção
      case 'COS': return Colors.indigo; // Contrato gerado
      default: return Colors.grey;
    }
  }

  String _getStatusLabel() {
    switch (status) {
      case 'PO': return 'Aguardando';
      case 'NO': return 'Precificando';
      case 'OA': return 'Aprovado'; 
      case 'VT': return 'Visita Agendada';
      case 'OS': return 'Em produção';
      case 'COS': return 'Contrato';
      default: return status;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: _getStatusColor().withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _getStatusColor()),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _getStatusLabel(),
              style: TextStyle(
                color: _getStatusColor(),
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
