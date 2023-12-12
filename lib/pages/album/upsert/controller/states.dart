import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../models/album_model.dart';
import '../../../../models/profile_model.dart';
import '../../../utils/state_status.dart';

part 'states.freezed.dart';

enum AlbumUpsertStatus { initial, loading, update, success, error }

@freezed
abstract class AlbumUpsertState with _$AlbumUpsertState {
  factory AlbumUpsertState({
    @Default(AlbumUpsertStatus.initial) AlbumUpsertStatus status,
    @Default('') String error,
    AlbumModel? model,
  }) = _AlbumUpsertState;
}

@freezed
abstract class ProfileSelectState with _$ProfileSelectState {
  factory ProfileSelectState({
    @Default(StateStatus.initial) StateStatus status,
    @Default('') String message,
    @Default([]) List<ProfileListModel> list,
  }) = _ProfileSelectState;
}
