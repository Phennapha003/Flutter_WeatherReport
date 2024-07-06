import 'dart:convert';

class Sys {
  int? type;
  int? id;
  String? country;
  int? sunrise;
  int? sunset;

  Sys({this.type, this.id, this.country, this.sunrise, this.sunset});

  @override
  String toString() {
    return 'Sys(type: $type, id: $id, country: $country, sunrise: $sunrise, sunset: $sunset)';
  }

  factory Sys.fromMap(Map<String, dynamic> data) => Sys(
        type: data['type'] as int?,
        id: data['id'] as int?,
        country: data['country'] as String?,
        sunrise: data['sunrise'] as int?,
        sunset: data['sunset'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'type': type,
        'id': id,
        'country': country,
        'sunrise': sunrise,
        'sunset': sunset,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Sys].
  factory Sys.fromJson(String data) {
    return Sys.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Sys] to a JSON string.
  String toJson() => json.encode(toMap());
}
