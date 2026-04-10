import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../core/extensions/string_extensions.dart';
import '../data/api/message_api.dart';
import '../data/models/api_collection.dart';
import '../data/models/message.dart';

part 'message_provider.g.dart';

@riverpod
Future<ApiCollection<Message>> messages(MessagesRef ref, int carId) async {
  return ref.watch(messageApiProvider).getMessages(carIri: toIri('cars', carId));
}
