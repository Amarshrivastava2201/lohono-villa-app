import 'villa.dart';

class VillaQuote {
  final Villa villa;
  final DateTime? checkIn;
  final DateTime? checkOut;
  final int? nights;
  final bool isAvailable;
  final int? subtotal;
  final int? gst;
  final int? total;
  final List<NightlyRate> nightlyBreakdown;

  VillaQuote({
    required this.villa,
    this.checkIn,
    this.checkOut,
    this.nights,
    required this.isAvailable,
    this.subtotal,
    this.gst,
    this.total,
    required this.nightlyBreakdown,
  });

  factory VillaQuote.fromJson(Map<String, dynamic> json) {
    return VillaQuote(
      villa: Villa.fromJson(json['villa'] ?? {}),

      checkIn: json['check_in'] != null
          ? DateTime.tryParse(json['check_in'])
          : null,

      checkOut: json['check_out'] != null
          ? DateTime.tryParse(json['check_out'])
          : null,

      nights: json['nights'] is num ? (json['nights'] as num).toInt() : null,

      isAvailable: json['is_available'] == true,

      subtotal:
          json['subtotal'] is num ? (json['subtotal'] as num).toInt() : null,

      gst: json['gst'] is num ? (json['gst'] as num).toInt() : null,

      total:
          json['total'] is num ? (json['total'] as num).toInt() : null,

      nightlyBreakdown: (json['nightly_breakdown'] as List? ?? [])
          .map((e) => NightlyRate.fromJson(e))
          .toList(),
    );
  }
}

class NightlyRate {
  final String date;
  final int? rate;
  final bool isAvailable;

  NightlyRate({
    required this.date,
    this.rate,
    required this.isAvailable,
  });

  factory NightlyRate.fromJson(Map<String, dynamic> json) {
    return NightlyRate(
      date: json['date']?.toString() ?? '',
      rate: json['rate'] is num ? (json['rate'] as num).toInt() : null,
      isAvailable: json['is_available'] == true,
    );
  }
}
