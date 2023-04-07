import 'package:flutter/material.dart';

enum TransactionStatus {
  waiting(label: 'Ожидание', color: Color(0xffdb7312), icon: Icons.accessible_rounded),
  fail(label: 'Не удлось выполнить', color: Color(0xffb34b4c), icon: Icons.safety_check),
  complete(label: 'Завершено', color: Color(0xff6cd9b2), icon: Icons.golf_course_rounded);

  final String label;

  final Color color;

  final IconData icon;

  const TransactionStatus({required this.label, required this.color, required this.icon});
}
