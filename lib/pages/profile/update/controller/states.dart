import 'package:freezed_annotation/freezed_annotation.dart';

part 'states.freezed.dart';

enum ProfileUpdateStatus { initial, loading, updated, success, error }

@freezed
abstract class ProfileUpdateState with _$ProfileUpdateState {
  factory ProfileUpdateState({
    @Default(ProfileUpdateStatus.initial) ProfileUpdateStatus status,
    @Default('') String error,
  }) = _ProfileUpdateState;
}
