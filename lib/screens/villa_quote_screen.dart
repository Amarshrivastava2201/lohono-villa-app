import 'package:flutter/material.dart';
import '../models/villa_quote.dart';
import '../services/villa_api_service.dart';

class VillaQuoteScreen extends StatelessWidget {
  final String villaId;

  const VillaQuoteScreen({super.key, required this.villaId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Villa Quote')),
      body: FutureBuilder<VillaQuote>(
        future: VillaApiService.fetchVillaQuote(villaId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Failed to load quote'));
          }

          final quote = snapshot.data!;

          if (!quote.isAvailable) {
            return const Center(child: Text('Villa not available'));
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Price Summary',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),

                _priceRow('Nights', '${quote.nights}'),
                _priceRow('Subtotal', '₹${quote.subtotal}'),
                _priceRow('GST (18%)', '₹${quote.gst}'),

                const Divider(height: 32),

                _priceRow('Total', '₹${quote.total}', isBold: true),
              ],
            ),
          );
        },
      ),
    );
  }
  Widget _priceRow(String label, String value, {bool isBold = false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        Text(
          value,
          style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    ),
  );
}

}
