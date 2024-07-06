import 'dart:convert';

class Clouds {
  int? all;

  Clouds({this.all});

  @override
  String toString() => 'Clouds(all: $all)';

  factory Clouds.fromMap(Map<String, dynamic> data) => Clouds(
        all: data['all'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'all': all,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Clouds].
  factory Clouds.fromJson(String data) {
    return Clouds.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Clouds] to a JSON string.
  String toJson() => json.encode(toMap());
}
