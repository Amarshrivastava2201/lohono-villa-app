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
      appBar: AppBar(title: const Text('Goa Villas')),
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
                margin: const EdgeInsets.all(12),
                child: ListTile(
                  title: Text(villa.name),
                  subtitle: Text(villa.location),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '₹${villa.avgPricePerNight}/night',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('${villa.nights} nights'),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => VillaQuoteScreen(villaId: villa.id),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
