import 'package:flutter/material.dart';

class addinfo extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const addinfo({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      width: 100,
      child: Column(
        children: [
          Icon(
            icon,
            size: 40,
          ),
          const SizedBox(height: 8,),
          Text(label),
          const SizedBox(height: 8,),
          Text(value,
            style:
            const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            )
            ,)
        ],
      ),
    );
  }
}


