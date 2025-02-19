import 'package:flutter/material.dart';

class ColumnWidget extends StatelessWidget {
  const ColumnWidget({
    super.key,
    required this.status,
    required this.statusColor,
  });

  final String status;
  final Color statusColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          status,
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: statusColor),
        ),
        const SizedBox(height: 10),
       
      ],
    );
  }
}
