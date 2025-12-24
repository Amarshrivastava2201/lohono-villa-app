import 'package:flutter/material.dart';
import '../models/villa_quote.dart';
import '../services/villa_api_service.dart';

class VillaQuoteScreen extends StatefulWidget {
  final String villaId;
  final DateTime checkIn;
  final DateTime checkOut;

  const VillaQuoteScreen({
    super.key,
    required this.villaId,
    required this.checkIn,
    required this.checkOut,
  });

  @override
  State<VillaQuoteScreen> createState() => _VillaQuoteScreenState();
}

class _VillaQuoteScreenState extends State<VillaQuoteScreen> {
  late Future<VillaQuote> _future;

  @override
  void initState() {
    super.initState();

    _future = VillaApiService.fetchVillaQuote(
      villaId: widget.villaId,
      checkIn: widget.checkIn,
      checkOut: widget.checkOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quote')),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<VillaQuote>(
              future: _future,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (!snapshot.hasData || snapshot.data == null) {
                  return const Center(child: Text('No quote data available'));
                }

                final quote = snapshot.data!;

                if (!quote.isAvailable) {
                  return const Center(
                    child: Text('Villa not available for selected dates'),
                  );
                }

                return ListView(
                  padding: const EdgeInsets.all(16),
                  children: [const Text(
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
                );
              },
            ),
          ),
        ],
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
