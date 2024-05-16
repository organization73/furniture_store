import 'dart:convert';

class Notifications {
  String? title;
  String? subtitle;

  Notifications({this.title, this.subtitle});

  factory Notifications.fromMap(Map<String, dynamic> data) => Notifications(
        title: data['title'] as String?,
        subtitle: data['subtitle'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'title': title,
        'subtitle': subtitle,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Notifications].
  factory Notifications.fromJson(String data) {
    return Notifications.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Notifications] to a JSON string.
  String toJson() => json.encode(toMap());

  Notifications copyWith({
    String? title,
    String? subtitle,
  }) {
    return Notifications(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
    );
  }
}
