import 'package:flutter/material.dart';
import '../services/villa_api_service.dart';


class EditSearchScreen extends StatefulWidget {
  final String destination;
  final DateTime? checkIn;
  final DateTime? checkOut;
  final int guests;

  const EditSearchScreen({
    super.key,
    required this.destination,
    this.checkIn,
    this.checkOut,
    required this.guests,
  });


  @override
  State<EditSearchScreen> createState() => _EditSearchScreenState();
}

class _EditSearchScreenState extends State<EditSearchScreen> {
  late String destination;
  DateTime? checkIn;
  DateTime? checkOut;
  late int guests;


  @override
void initState() {
  super.initState();
  checkIn = widget.checkIn;
  checkOut = widget.checkOut;
  guests = widget.guests;
  destination = widget.destination;
}


  Future<void> _pickDate(bool isCheckIn) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null) {
      setState(() {
        if (isCheckIn) {
          checkIn = picked;
        } else {
          checkOut = picked;
        }
      });
    }
  }

  void _applySearch() {
  Navigator.pop(context, {
    'destination': destination,
    'checkIn': checkIn,
    'checkOut': checkOut,
    'guests': guests,
  });
}


  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Edit Search'),
    ),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // =========================
          //  DESTINATION
          // =========================
          const Text(
            'Destination',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          FutureBuilder<List<String>>(
            future: VillaApiService.fetchLocations(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LinearProgressIndicator();
              }

              if (snapshot.hasError || !snapshot.hasData) {
                return const Text('Failed to load locations');
              }

              final locations = snapshot.data!;

              return DropdownButtonFormField<String>(
                value: locations.contains(destination)
                    ? destination
                    : locations.first,
                items: locations
                    .map(
                      (loc) => DropdownMenuItem<String>(
                        value: loc,
                        child: Text(loc),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    destination = value!;
                  });
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              );
            },
          ),

          const SizedBox(height: 24),

          // =========================
          //  DATES
          // =========================
          const Text(
            'Dates',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => _pickDate(true),
                  child: Text(
                    checkIn == null
                        ? 'Check-in'
                        : '${checkIn!.day}/${checkIn!.month}/${checkIn!.year}',
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton(
                  onPressed: () => _pickDate(false),
                  child: Text(
                    checkOut == null
                        ? 'Check-out'
                        : '${checkOut!.day}/${checkOut!.month}/${checkOut!.year}',
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // =========================
          //  GUESTS
          // =========================
          const Text(
            'Guests',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          Row(
            children: [
              IconButton(
                onPressed: guests > 1
                    ? () => setState(() => guests--)
                    : null,
                icon: const Icon(Icons.remove),
              ),
              Text(
                '$guests',
                style: const TextStyle(fontSize: 16),
              ),
              IconButton(
                onPressed: () => setState(() => guests++),
                icon: const Icon(Icons.add),
              ),
            ],
          ),

          const Spacer(),

          // =========================
          //  APPLY BUTTON
          // =========================
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _applySearch,
              child: const Text('Apply'),
            ),
          ),
        ],
      ),
    ),
  );
}

}
