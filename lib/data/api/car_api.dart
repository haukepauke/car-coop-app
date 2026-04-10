import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/api_collection.dart';
import '../models/car.dart';
import 'api_client.dart';

part 'car_api.g.dart';

@riverpod
CarApi carApi(CarApiRef ref) => CarApi(ref.watch(dioProvider));

class CarApi {
  CarApi(this._dio);

  final Dio _dio;

  Future<ApiCollection<Car>> getCars({int page = 1}) async {
    final response = await _dio.get<dynamic>(
      '/api/cars',
      queryParameters: {'page': page},
    );
    return ApiCollection.fromJson(response.data!, Car.fromJson);
  }

  Future<Car> getCar(int id) async {
    final response = await _dio.get<Map<String, dynamic>>('/api/cars/$id');
    return Car.fromJson(response.data!);
  }
}
