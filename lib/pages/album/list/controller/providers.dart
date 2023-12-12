import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/functional_program/either.dart';
import '../../../../models/album_model.dart';
import '../../../../repositories/providers.dart';

part 'providers.g.dart';

@riverpod
FutureOr<List<AlbumModelList>> albumList(AlbumListRef ref) async {
  final result = await ref.read(albumRepositoryProvider).list();

  return switch (result) {
    Failure(:final exception) =>
      throw AsyncError(exception.message, StackTrace.current),
    Success(:final value) => value
  };
}

@riverpod
class AlbumSelected extends _$AlbumSelected {
  @override
  AlbumModelList? build() {
    return null;
  }

  void set(AlbumModelList value) {
    state = value;
  }
}
