class EnumUtil {
  static T fromStringEnum<T>(List<T> values, String value) {
    return values.firstWhere(
      (type) => type.toString().split('.').last == value,
      orElse: () => throw ArgumentError(
          'The provided string does not match any enum value.'),
    );
  }
}

enum TextSizes { small, medium, large }

enum AccountType { regular, vendor }

