import 'package:musictobeligth/pages/home/controller/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../core/functional_program/either.dart';
import '../../../../../models/sound_model.dart';
import '../../../../repositories/providers.dart';

part 'providers.g.dart';

@riverpod
FutureOr<List<SoundModelList>> soundList(SoundListRef ref) async {
  final album = ref.watch(albumSelectedProvider);
  final result = await ref.read(soundRepositoryProvider).list(album);

  return switch (result) {
    Failure(:final exception) =>
      throw AsyncError(exception.message, StackTrace.current),
    Success(:final value) => value
  };
}

@riverpod
class SoundIdSelected extends _$SoundIdSelected {
  @override
  String build() {
    return '';
  }

  void set(String value) {
    state = value;
  }
}
