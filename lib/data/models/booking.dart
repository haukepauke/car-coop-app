import 'package:json_annotation/json_annotation.dart';
import 'user_ref.dart';

part 'booking.g.dart';

@JsonSerializable()
class Booking {
  const Booking({
    required this.id,
    this.car,
    this.user,
    required this.startTime,
    required this.endTime,
    this.purpose,
    this.status,
  });

  static const statuses = ['fixed', 'maybe'];

  final int id;
  final String? car;

  @UserRefConverter()
  final UserRef? user;

  @JsonKey(name: 'startDate')
  final DateTime startTime;

  @JsonKey(name: 'endDate')
  final DateTime endTime;

  @JsonKey(name: 'title')
  final String? purpose;

  final String? status;

  factory Booking.fromJson(Map<String, dynamic> json) => _$BookingFromJson(json);
  Map<String, dynamic> toJson() => _$BookingToJson(this);
}
