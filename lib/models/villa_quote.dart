class VillaQuote {
  final bool isAvailable;
  final int nights;
  final int subtotal;
  final int gst;
  final int total;
  final List<dynamic> nightlyBreakdown;

  VillaQuote({
    required this.isAvailable,
    required this.nights,
    required this.subtotal,
    required this.gst,
    required this.total,
    required this.nightlyBreakdown,
  });

  factory VillaQuote.fromJson(Map<String, dynamic> json) {
    return VillaQuote(
      isAvailable: json['is_available'],
      nights: json['nights'],
      subtotal: json['subtotal'],
      gst: json['gst'],
      total: json['total'],
      nightlyBreakdown: json['nightly_breakdown'],
    );
  }
}
