import 'package:flutter/material.dart';

class VillaCardSkeleton extends StatelessWidget {
  const VillaCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(height: 160, color: Colors.grey.shade300),
            const SizedBox(height: 12),
            Container(height: 16, width: 180, color: Colors.grey.shade300),
            const SizedBox(height: 8),
            Container(height: 14, width: 120, color: Colors.grey.shade300),
          ],
        ),
      ),
    );
  }
}
