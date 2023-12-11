import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../models/album_model.dart';

part 'states.freezed.dart';

enum AlbumUpsertStatus { initial, loading, success, error }

@freezed
abstract class AlbumUpsertState with _$AlbumUpsertState {
  factory AlbumUpsertState({
    @Default(AlbumUpsertStatus.initial) AlbumUpsertStatus status,
    @Default('') String error,
    AlbumModel? model,
  }) = _AlbumUpsertState;
}
