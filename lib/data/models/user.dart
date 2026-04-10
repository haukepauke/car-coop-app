import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  const User({
    required this.id,
    required this.email,
    required this.name,
    this.color,
    this.profilePicturePath,
    this.locale,
    this.roles = const [],
  });

  final int id;
  final String email;
  final String name;
  final String? color;
  final String? profilePicturePath;
  final String? locale;
  final List<String> roles;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  String profilePictureUrl(String apiUrl) =>
      profilePicturePath != null ? '$apiUrl/$profilePicturePath' : '';
}
