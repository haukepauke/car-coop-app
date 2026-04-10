import 'package:json_annotation/json_annotation.dart';
import 'user_ref.dart';

part 'payment.g.dart';

@JsonSerializable()
class Payment {
  const Payment({
    required this.id,
    this.car,
    this.paidBy,
    this.paidTo,
    required this.amount,
    required this.date,
    this.type,
    this.note,
  });

  static const types = ['cash', 'paypal', 'banktransfer', 'other'];

  final int id;
  final String? car;

  @JsonKey(name: 'fromUser')
  @UserRefConverter()
  final UserRef? paidBy;

  @JsonKey(name: 'toUser')
  @UserRefConverter()
  final UserRef? paidTo;

  final double amount;
  final DateTime date;
  final String? type;

  @JsonKey(name: 'comment')
  final String? note;

  factory Payment.fromJson(Map<String, dynamic> json) => _$PaymentFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentToJson(this);
}
