import 'package:flutter/material.dart';
import '../models/villa.dart';
import '../services/villa_api_service.dart';
import 'villa_quote_screen.dart';

class VillaListScreen extends StatefulWidget {
  const VillaListScreen({super.key});

  @override
  State<VillaListScreen> createState() => _VillaListScreenState();
}

class _VillaListScreenState extends State<VillaListScreen> {
  late Future<List<Villa>> villasFuture;

  @override
  void initState() {
    super.initState();
    villasFuture = VillaApiService.fetchAvailableVillas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lohono Villas'), centerTitle: true),

      body: FutureBuilder<List<Villa>>(
        future: villasFuture,
        builder: (context, snapshot) {
          // Loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Error
          if (snapshot.hasError) {
            return const Center(child: Text('Failed to load villas'));
          }

          final villas = snapshot.data!;

          // Empty
          if (villas.isEmpty) {
            return const Center(child: Text('No villas available'));
          }

          // Success
          return ListView.builder(
            itemCount: villas.length,
            itemBuilder: (context, index) {
              final villa = villas[index];

              return Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => VillaQuoteScreen(villaId: villa.id),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        // Left content
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                villa.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                villa.location,
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${villa.nights} nights',
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),

                        // Right content
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '₹${villa.avgPricePerNight}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              '/night',
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
