import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../models/album_model.dart';
import '../../../../models/profile_model.dart';
import '../../../../models/sound_model.dart';
import '../../../utils/state_status.dart';

part 'states.freezed.dart';

enum SoundUpsertStatus { initial, loading, update, success, error }

@freezed
abstract class SoundUpsertState with _$SoundUpsertState {
  factory SoundUpsertState({
    @Default(SoundUpsertStatus.initial) SoundUpsertStatus status,
    @Default('') String error,
    SoundModel? model,
  }) = _SoundUpsertState;
}

@freezed
abstract class ProfileSelectState with _$ProfileSelectState {
  factory ProfileSelectState({
    @Default(StateStatus.initial) StateStatus status,
    @Default('') String message,
    ProfileListModel? author,
  }) = _ProfileSelectState;
}
