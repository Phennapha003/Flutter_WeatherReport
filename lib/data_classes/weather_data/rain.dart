import 'dart:convert';

class Rain {
  double? onehour;

  Rain({this.onehour});

  @override
  String toString() => 'Rain(onehour: $onehour)';

  factory Rain.fromMap(Map<String, dynamic> data) => Rain(
        onehour: (data['onehour'] as num?)?.toDouble(),
      );

  Map<String, dynamic> toMap() => {
        'onehour': onehour,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Rain].
  factory Rain.fromJson(String data) {
    return Rain.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Rain] to a JSON string.
  String toJson() => json.encode(toMap());
}
