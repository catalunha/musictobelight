import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'remote/api/client/dio_client.dart'
    if (dart.library.io) 'remote/api/client/dio_client_android.dart'
    if (dart.library.js) 'remote/api/client/dio_client_web.dart';

part 'providers.g.dart';

@Riverpod(keepAlive: true)
DioClient dioClient(DioClientRef ref) {
  return DioClient();
}
