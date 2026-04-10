import 'package:json_annotation/json_annotation.dart';

part 'user_ref.g.dart';

/// Handles user fields that the API returns as a full object, a string IRI, or null.
class UserRefConverter implements JsonConverter<UserRef?, Object?> {
  const UserRefConverter();

  @override
  UserRef? fromJson(Object? json) {
    if (json == null) return null;
    if (json is Map<String, dynamic>) return UserRef.fromJson(json);
    if (json is String) {
      final id = int.tryParse(json.split('/').last) ?? 0;
      return UserRef(id: id, name: '');
    }
    return null;
  }

  @override
  Object? toJson(UserRef? user) => user?.iri ?? user?.toJson();
}

/// Converts a JSON list of IRI strings or user objects to List<UserRef>.
class UserRefListConverter implements JsonConverter<List<UserRef>, List<dynamic>> {
  const UserRefListConverter();

  @override
  List<UserRef> fromJson(List<dynamic> json) =>
      json.map((e) => const UserRefConverter().fromJson(e) ?? const UserRef(id: 0, name: '')).toList();

  @override
  List<dynamic> toJson(List<UserRef> users) =>
      users.map((u) => u.iri ?? '/api/users/${u.id}').toList();
}

/// Lightweight user reference embedded in other resources.
@JsonSerializable()
class UserRef {
  const UserRef({
    required this.id,
    required this.name,
    this.color,
    this.iri,
    this.profilePicturePath,
  });

  final int id;
  final String name;
  final String? color;
  @JsonKey(name: '@id')
  final String? iri;
  final String? profilePicturePath;

  factory UserRef.fromJson(Map<String, dynamic> json) => _$UserRefFromJson(json);
  Map<String, dynamic> toJson() => _$UserRefToJson(this);
}
