import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../core/extensions/string_extensions.dart';
import '../data/api/expense_api.dart';
import '../data/models/api_collection.dart';
import '../data/models/expense.dart';
import 'auth_provider.dart';

part 'expense_provider.g.dart';

@riverpod
Future<ApiCollection<Expense>> expenses(ExpensesRef ref, int carId) async {
  // Ensure auth is fully settled before fetching expenses
  await ref.watch(authProvider.future);
  return ref.watch(expenseApiProvider).getExpenses(carIri: toIri('cars', carId));
}
