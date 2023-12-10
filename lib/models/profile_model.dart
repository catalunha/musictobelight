import 'package:freezed_annotation/freezed_annotation.dart';

import 'image_model.dart';
import 'user_model.dart';

part 'profile_model.freezed.dart';
part 'profile_model.g.dart';

@freezed
abstract class ProfileModel with _$ProfileModel {
  @JsonSerializable(includeIfNull: false)
  factory ProfileModel({
    required String id,
    required UserModel user,
    String? name,
    String? description,
    @JsonKey(name: 'is_coordinator') @Default(false) bool isCoordinator,
    ImageModel? photo,
  }) = _ProfileModel;
  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);
}
