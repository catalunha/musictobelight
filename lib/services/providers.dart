import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../repositories/providers.dart';
import 'user/user_service.dart';
import 'user/user_service_impl.dart';

part 'providers.g.dart';

@Riverpod(keepAlive: true)
UserService userService(UserServiceRef ref) {
  return UserServiceImpl(userRepository: ref.read(userRepositoryProvider));
}

@riverpod
FutureOr<void> logout(LogoutRef ref) {
  final userService = ref.read(userServiceProvider);
  userService.logout();
}
