import 'package:json_annotation/json_annotation.dart';
import 'user_ref.dart';

part 'car.g.dart';

@JsonSerializable()
class Car {
  const Car({
    required this.id,
    required this.name,
    required this.licensePlate,
    this.color,
    this.mileage,
    this.milageUnit,
    this.currency,
    this.profilePicturePath,
    this.members = const [],
  });

  final int id;
  final String name;
  final String licensePlate;
  final String? color;
  final int? mileage;
  final String? milageUnit;
  final String? currency;
  final String? profilePicturePath;
  final List<UserRef> members;

  factory Car.fromJson(Map<String, dynamic> json) => _$CarFromJson(json);
  Map<String, dynamic> toJson() => _$CarToJson(this);

  String get iri => '/api/cars/$id';
}
