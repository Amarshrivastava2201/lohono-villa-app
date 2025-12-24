import 'package:flutter/material.dart';

import '../models/villa.dart';

import '../services/villa_api_service.dart';
import 'villa_quote_screen.dart';
import 'edit_search_screen.dart';

class VillaListScreen extends StatefulWidget {
  const VillaListScreen({super.key});

  @override
  State<VillaListScreen> createState() => _VillaListScreenState();
}

class _VillaListScreenState extends State<VillaListScreen> {
  //  Search state
  String destination = 'Goa';
  DateTime? checkIn;
  DateTime? checkOut;
  int guests = 2;

  late Future<List<Villa>> villasFuture;

  @override
  void initState() {
    super.initState();
    final today = DateTime.now();

    villasFuture = VillaApiService.fetchAvailableVillas(
      location: destination,
      checkIn: today.add(const Duration(days: 1)),
      checkOut: today.add(const Duration(days: 4)),
    );
  }

  // =========================
  //  UI HELPERS
  // =========================

  Widget _searchSummary() {
    final dateText = (checkIn == null || checkOut == null)
        ? 'Add Date'
        : '${checkIn!.day}/${checkIn!.month} - ${checkOut!.day}/${checkOut!.month}';

    return InkWell(
      onTap: _openEditSearch,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        color: Colors.white,
        child: Text(
          '$destination · $dateText · $guests Guests',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  void _openEditSearch() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EditSearchScreen(
          destination: destination,
          checkIn: checkIn,
          checkOut: checkOut,
          guests: guests,
        ),
      ),
    );

    if (result != null) {
      setState(() {
        destination = result['destination'];
        checkIn = result['checkIn'];
        checkOut = result['checkOut'];
        guests = result['guests'];
        final today = DateTime.now();

        villasFuture = VillaApiService.fetchAvailableVillas(
          location: destination,
          checkIn: today.add(const Duration(days: 1)),
          checkOut: today.add(const Duration(days: 4)),
        );
      });
    }
  }

  void _openFilters() {
    showModalBottomSheet(
      context: context,
      builder: (_) => const Padding(
        padding: EdgeInsets.all(24),
        child: Text('Filters UI will go here'),
      ),
    );
  }

  void _openSort() {
    showModalBottomSheet(
      context: context,
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          ListTile(title: Text('Popularity')),
          ListTile(title: Text('Price: Low to High')),
          ListTile(title: Text('Price: High to Low')),
        ],
      ),
    );
  }

  // =========================
  //  BUILD
  // =========================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lohono Villas'), centerTitle: true),

      body: Column(
        children: [
          //  Sticky Search Summary
          _searchSummary(),

          //  Main Content
          Expanded(
            child: FutureBuilder<List<Villa>>(
              future: villasFuture,
              builder: (context, snapshot) {
                // =========================
                // 🔄 LOADING STATE
                // =========================
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return ListView.builder(
                    itemCount: 4,
                    itemBuilder: (_, _) => Container(
                      margin: const EdgeInsets.all(16),
                      height: 120,
                      color: Colors.grey[200],
                    ),
                  );
                }

                // =========================
                // ERROR STATE
                // =========================
                if (snapshot.hasError) {
                  return const Center(child: Text('Something went wrong'));
                }

                final villas = snapshot.data ?? [];

                // =========================
                //  EMPTY STATE
                // =========================
                if (villas.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('No villas available for these dates'),
                        const SizedBox(height: 8),
                        TextButton(
                          onPressed: _openEditSearch,
                          child: const Text('Edit dates'),
                        ),
                      ],
                    ),
                  );
                }

                // =========================
                //  SUCCESS STATE
                // =========================
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //  Filters + Sort Row
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton.icon(
                            onPressed: _openFilters,
                            icon: const Icon(Icons.filter_list),
                            label: const Text('Filters'),
                          ),
                          TextButton.icon(
                            onPressed: _openSort,
                            icon: const Icon(Icons.sort),
                            label: const Text('Sort'),
                          ),
                        ],
                      ),
                    ),

                    //  Results Header
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Luxury villas in $destination',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text('${villas.length} properties found'),
                        ],
                      ),
                    ),

                    //  Villa Cards
                    Expanded(
                      child: ListView.builder(
                        itemCount: villas.length,
                        itemBuilder: (context, index) {
                          final villa = villas[index];

                          return Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            margin: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => VillaQuoteScreen(
                                      villaId: villa.id,
                                      checkIn: checkIn!,
                                      checkOut: checkOut!,
                                    ),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  children: [
                                    // Left
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            '${villa.nights} nights',
                                            style: const TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    // Right
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
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
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
