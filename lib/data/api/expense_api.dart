import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/api_collection.dart';
import '../models/expense.dart';
import 'api_client.dart';

part 'expense_api.g.dart';

@riverpod
ExpenseApi expenseApi(ExpenseApiRef ref) => ExpenseApi(ref.watch(dioProvider));

class ExpenseApi {
  ExpenseApi(this._dio);

  final Dio _dio;

  Future<ApiCollection<Expense>> getExpenses({
    required String carIri,
    int page = 1,
  }) async {
    final response = await _dio.get<dynamic>(
      '/api/expenses',
      queryParameters: {'car': carIri, 'page': page},
    );
    return ApiCollection.fromJson(response.data!, Expense.fromJson);
  }

  Future<Expense> getExpense(int id) async {
    final response = await _dio.get<Map<String, dynamic>>('/api/expenses/$id');
    return Expense.fromJson(response.data!);
  }

  Future<Expense> createExpense(Map<String, dynamic> data) async {
    final response = await _dio.post<Map<String, dynamic>>('/api/expenses', data: data);
    return Expense.fromJson(response.data!);
  }

  Future<Expense> updateExpense(int id, Map<String, dynamic> data) async {
    final response =
        await _dio.put<Map<String, dynamic>>('/api/expenses/$id', data: data);
    return Expense.fromJson(response.data!);
  }

  Future<void> deleteExpense(int id) async {
    await _dio.delete<void>('/api/expenses/$id');
  }
}
