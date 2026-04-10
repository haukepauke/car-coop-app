import 'package:json_annotation/json_annotation.dart';
import 'user_ref.dart';

part 'expense.g.dart';

@JsonSerializable()
class Expense {
  const Expense({
    required this.id,
    this.car,
    this.user,
    required this.amount,
    required this.category,
    required this.date,
    this.name,
    this.description,
  });

  final int id;
  final String? car;

  @UserRefConverter()
  final UserRef? user;

  final double amount;

  @JsonKey(name: 'type')
  final String category;

  final DateTime date;

  final String? name;

  @JsonKey(name: 'comment')
  final String? description;

  factory Expense.fromJson(Map<String, dynamic> json) => _$ExpenseFromJson(json);
  Map<String, dynamic> toJson() => _$ExpenseToJson(this);
}
