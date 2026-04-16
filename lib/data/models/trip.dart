import 'package:json_annotation/json_annotation.dart';
import 'user_ref.dart';

part 'trip.g.dart';

@JsonSerializable()
class Trip {
  const Trip({
    required this.id,
    this.car,
    required this.startTime,
    this.endTime,
    this.startMileage,
    this.endMileage,
    this.purpose,
    this.type,
    this.costs,
    this.users = const [],
  });

  static const types = [
    'vacation',
    'transport',
    'other',
    'service_free',
    'other_free',
    'placeholder_free',
  ];

  final int id;
  final String? car;

  @JsonKey(name: 'startDate')
  final DateTime startTime;

  @JsonKey(name: 'endDate')
  final DateTime? endTime;

  final int? startMileage;
  final int? endMileage;

  @JsonKey(name: 'comment')
  final String? purpose;

  final String? type;
  final double? costs;

  @UserRefListConverter()
  final List<UserRef> users;

  double get distanceKm =>
      (startMileage != null && endMileage != null && endMileage! > startMileage!)
          ? (endMileage! - startMileage!).toDouble()
          : 0.0;

  factory Trip.fromJson(Map<String, dynamic> json) => _$TripFromJson(json);
  Map<String, dynamic> toJson() => _$TripToJson(this);
}
