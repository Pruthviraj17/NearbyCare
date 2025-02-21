// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Nearbyhospitals {
  String? icon;
  String? name;
  bool? openNow;
  double? rating;
  String? vicinity;

  Nearbyhospitals({
    this.icon,
    this.name,
    this.openNow,
    this.rating,
    this.vicinity,
  });

  factory Nearbyhospitals.fromJson(Map<String, dynamic> map) {
    return Nearbyhospitals(
      icon: map['icon'] != null ? map['icon'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
     openNow: (map['opening_hours'] != null && map['opening_hours']['open_now'] != null)
    ? map['opening_hours']['open_now'] as bool
    : null,
      rating:
          (map['rating'] != null) ? (map['rating'] as num).toDouble() : null,
      vicinity: map['vicinity'] != null ? map['vicinity'] as String : null,
    );
  }
}
