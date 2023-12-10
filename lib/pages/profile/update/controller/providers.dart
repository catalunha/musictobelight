import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/functional_program/either.dart';
import '../../../../repositories/providers.dart';

import 'states.dart';

part 'providers.g.dart';

@riverpod
class ProfileUpdateController extends _$ProfileUpdateController {
  @override
  ProfileUpdateState build() {
    return ProfileUpdateState();
  }

  Future<void> submitForm({
    String? name,
    String? description,
  }) async {
    state = state.copyWith(status: ProfileUpdateStatus.loading);

    FormData data = FormData.fromMap({
      "name": name,
      "description":
          description == null || description.isEmpty ? null : description,
    });

    final xFile = ref.read(xFileAvatarProvider);
    if (xFile != null) {
      // final fileExtension = xFile.name.split('.').last;
      final fileName = xFile.name.replaceAll(RegExp(r'[^A-Za-z0-9.-]'), '_');
      data.files.add(MapEntry(
        "photo",
        MultipartFile.fromBytes(
          await xFile.readAsBytes(),
          filename: fileName,
          // contentType: MediaType("image", fileExtension), //important
        ),
      ));
    }
    final profile = ref.read(meProfileProvider)!;
    final result =
        await ref.read(profileRepositoryProvider).update(profile.id, data);
    switch (result) {
      case Failure(:final exception):
        state = state.copyWith(
            status: ProfileUpdateStatus.error, error: exception.message);
      case Success():
        final resultGetProfile =
            await ref.read(meProfileProvider.notifier).getProfile();
        switch (resultGetProfile) {
          case Failure(:final exception):
            state = state.copyWith(
                status: ProfileUpdateStatus.error, error: exception.message);
          case Success():
            state = state.copyWith(status: ProfileUpdateStatus.success);
        }
    }
  }
}

@riverpod
class XFileAvatar extends _$XFileAvatar {
  @override
  XFile? build() {
    return null;
  }

  void set(XFile? value) {
    state = value;
  }
}
