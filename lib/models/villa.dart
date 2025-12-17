class Villa {
  final String id;
  final String name;
  final String location;
  final int nights;
  final int subtotal;
  final int avgPricePerNight;

  Villa({
    required this.id,
    required this.name,
    required this.location,
    required this.nights,
    required this.subtotal,
    required this.avgPricePerNight,
  });

  factory Villa.fromJson(Map<String, dynamic> json) {
    return Villa(
      id: json['id'],
      name: json['name'],
      location: json['location'],
      nights: json['nights'],
      subtotal: json['subtotal'],
      avgPricePerNight: json['avg_price_per_night'],
    );
  }
}
