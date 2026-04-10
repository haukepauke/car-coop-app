import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/api_collection.dart';
import '../models/message.dart';
import 'api_client.dart';

part 'message_api.g.dart';

@riverpod
MessageApi messageApi(MessageApiRef ref) => MessageApi(ref.watch(dioProvider));

class MessageApi {
  MessageApi(this._dio);

  final Dio _dio;

  Future<ApiCollection<Message>> getMessages({
    required String carIri,
    int page = 1,
    int itemsPerPage = 10,
  }) async {
    final response = await _dio.get<dynamic>(
      '/api/messages',
      queryParameters: {'car': carIri, 'page': page, 'itemsPerPage': itemsPerPage},
    );
    return ApiCollection.fromJson(response.data!, Message.fromJson);
  }

  /// Posts a message with optional photo attachments (multipart/form-data).
  /// [carId] is an integer (not an IRI) per the custom controller contract.
  Future<Message> createMessage({
    required int carId,
    required String content,
    List<String> photoPaths = const [],
  }) async {
    final formData = FormData.fromMap({
      'car': carId.toString(),
      'content': content,
      if (photoPaths.isNotEmpty)
        'photos': await Future.wait(
          photoPaths.map((p) => MultipartFile.fromFile(p)),
        ),
    });

    final response = await _dio.post<Map<String, dynamic>>(
      '/api/messages',
      data: formData,
    );
    return Message.fromJson(response.data!);
  }

  Future<void> deleteMessage(int id) async {
    await _dio.delete<void>('/api/messages/$id');
  }
}
