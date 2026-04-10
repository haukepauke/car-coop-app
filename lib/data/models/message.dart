import 'package:json_annotation/json_annotation.dart';
import 'user_ref.dart';

part 'message.g.dart';

@JsonSerializable()
class Message {
  const Message({
    required this.id,
    this.car,
    this.author,
    required this.content,
    required this.createdAt,
    this.isSticky = false,
    this.photos = const [],
  });

  final int id;
  final String? car;
  @UserRefConverter()
  final UserRef? author;
  final String content;
  final DateTime createdAt;
  final bool isSticky;
  final List<String> photos;

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);
  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
