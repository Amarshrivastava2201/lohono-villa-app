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
                Text('Nights: ${quote.nights}'),
                const SizedBox(height: 8),
                Text('Subtotal: ₹${quote.subtotal}'),
                Text('GST (18%): ₹${quote.gst}'),
                const Divider(),
                Text(
                  'Total: ₹${quote.total}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
