import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../core/exceptions/repository_exception.dart';
import '../core/functional_program/either.dart';
import '../data/providers.dart';
import '../models/profile_model.dart';
import '../models/user_model.dart';
import 'profile/profile_repository.dart';
import 'profile/profile_repository_impl.dart';
import 'user/user_repository.dart';
import 'user/user_repository_impl.dart';

part 'providers.g.dart';

@Riverpod(keepAlive: true)
UserRepository userRepository(UserRepositoryRef ref) {
  return UserRepositoryImpl(dioClient: ref.read(dioClientProvider));
}

@Riverpod(keepAlive: true)
ProfileRepository profileRepository(ProfileRepositoryRef ref) {
  return ProfileRepositoryImpl(dioClient: ref.read(dioClientProvider));
}

@Riverpod(keepAlive: true)
class MeUser extends _$MeUser {
  @override
  UserModel? build() {
    return null;
  }

  Future<Either<RepositoryException, Nil>> getUser() async {
    final result = await ref.read(userRepositoryProvider).me();
    switch (result) {
      case Success(:final value):
        state = value;
        return Success(Nil());
      case Failure(:final exception):
        return Failure(exception);
    }
  }
}

@Riverpod(keepAlive: true)
class MeProfile extends _$MeProfile {
  @override
  ProfileModel? build() {
    return null;
  }

  Future<Either<RepositoryException, Nil>> getProfile() async {
    final meUser = await ref.read(meUserProvider.notifier).getUser();
    switch (meUser) {
      case Failure(:final exception):
        return Failure(exception);
      case Success():
        final result = await ref
            .read(profileRepositoryProvider)
            .me(ref.read(meUserProvider)!);
        switch (result) {
          case Failure(:final exception):
            return Failure(exception);
          case Success(:final value):
            state = value;
            return Success(Nil());
        }
    }
  }
}
