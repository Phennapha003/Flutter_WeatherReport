import 'dart:convert';

class Coord {
  double? lon;
  double? lat;

  Coord({this.lon, this.lat});

  @override
  String toString() => 'Coord(lon: $lon, lat: $lat)';

  factory Coord.fromMap(Map<String, dynamic> data) => Coord(
        lon: (data['lon'] as num?)?.toDouble(),
        lat: (data['lat'] as num?)?.toDouble(),
      );

  Map<String, dynamic> toMap() => {
        'lon': lon,
        'lat': lat,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Coord].
  factory Coord.fromJson(String data) {
    return Coord.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Coord] to a JSON string.
  String toJson() => json.encode(toMap());
}
