import 'package:json_annotation/json_annotation.dart';
import 'user_ref.dart';

part 'parking_location.g.dart';

@JsonSerializable()
class ParkingLocation {
  const ParkingLocation({
    required this.id,
    this.car,
    required this.latitude,
    required this.longitude,
    required this.parkedAt,
    this.parkedBy,
  });

  final int id;
  final String? car;
  final double latitude;
  final double longitude;

  @JsonKey(name: 'createdAt')
  final DateTime parkedAt;

  @JsonKey(name: 'user')
  @UserRefConverter()
  final UserRef? parkedBy;

  factory ParkingLocation.fromJson(Map<String, dynamic> json) =>
      _$ParkingLocationFromJson(json);
  Map<String, dynamic> toJson() => _$ParkingLocationToJson(this);
}
