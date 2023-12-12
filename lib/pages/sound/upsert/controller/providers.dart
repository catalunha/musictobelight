import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/functional_program/either.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../models/sound_model.dart';
import '../../../../models/profile_model.dart';
import '../../../../repositories/providers.dart';
import '../../../album/list/controller/providers.dart';
import '../../../utils/state_status.dart';
import '../../list/controller/providers.dart';
import 'states.dart';

part 'providers.g.dart';

@riverpod
FutureOr<SoundModel?> soundRead(SoundReadRef ref, {required String? id}) async {
  if (id != null) {
    final result = await ref.read(soundRepositoryProvider).read(id);

    switch (result) {
      case Failure(:final exception):
        return throw AsyncError(exception.message, StackTrace.current);
      case Success(:final value):
        ref.watch(soundUpsertControllerProvider.notifier).setModel(value);
        ref
            .read(profileSelectedProvider.notifier)
            .add(ProfileListModel.fromJson(value.author.toJson()));
        return value;
    }
  }
  return null;
}

@riverpod
class SoundUpsertController extends _$SoundUpsertController {
  @override
  SoundUpsertState build() {
    return SoundUpsertState();
  }

  void setModel(SoundModel? model) {
    state = state.copyWith(model: model);
  }

  Future<void> submitForm({
    required String name,
    String? description,
  }) async {
    state = state.copyWith(status: SoundUpsertStatus.loading);
    Either either;
    // final profile = ref.watch(meProfileProvider)!;
    final album = ref.watch(albumSelectedProvider);

    final profileSelected = ref.watch(profileSelectedProvider);
    if (profileSelected.author == null) {
      state = state.copyWith(
          status: SoundUpsertStatus.error, error: 'Defina um autor.');
      return;
    }
    final audio = ref.watch(getAudioProvider);
    if (audio == null && state.model == null) {
      state = state.copyWith(
          status: SoundUpsertStatus.error, error: 'Defina um audio.');
      return;
    }
    try {
      FormData data = FormData.fromMap({
        "name": name,
        "description": description,
        "author": profileSelected.author!.id,
        "album": album!.id,
      });
      final xFile = ref.read(xFileAvatarProvider);
      if (xFile != null) {
        // final fileExtension = xFile.name.split('.').last;
        final fileName = xFile.name.replaceAll(RegExp(r'[^A-Za-z0-9.-]'), '_');
        data.files.add(MapEntry(
          "image",
          MultipartFile.fromBytes(
            await xFile.readAsBytes(),
            filename: fileName,
            // contentType: MediaType("image", fileExtension), //important
          ),
        ));
      }
      if (audio != null) {
        data.files.add(MapEntry(
          "audio",
          MultipartFile.fromBytes(
            audio.files.first.bytes!,
            filename: audio.files.first.name,
            // contentType: MediaType("image", fileExtension), //important
          ),
        ));
      }
      if (state.model != null) {
        either = await ref
            .read(soundRepositoryProvider)
            .update(state.model!.id, data);
      } else {
        either = await ref.read(soundRepositoryProvider).create(data);
      }
      switch (either) {
        case Failure():
          state = state.copyWith(
              status: SoundUpsertStatus.error, error: 'Erro em editar regiao');
        case Success():
          ref.invalidate(soundListProvider);
          state = state.copyWith(status: SoundUpsertStatus.success);
      }
    } catch (e, st) {
      log('$e');
      log('$st');
      state = state.copyWith(
          status: SoundUpsertStatus.error, error: 'Erro em editar cargo');
    }
  }

  Future<void> delete() async {
    state = state.copyWith(status: SoundUpsertStatus.loading);
    try {
      final either =
          await ref.read(soundRepositoryProvider).delete(state.model!.id);
      switch (either) {
        case Failure():
          state = state.copyWith(
              status: SoundUpsertStatus.error, error: 'Erro em apagar regiao');
        case Success():
          ref.invalidate(soundListProvider);
          state = state.copyWith(status: SoundUpsertStatus.success);
      }
    } catch (e, st) {
      log('$e');
      log('$st');
      state = state.copyWith(
          status: SoundUpsertStatus.error, error: 'Erro em editar cargo');
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

@riverpod
class GetAudio extends _$GetAudio {
  @override
  FilePickerResult? build() {
    return null;
  }

  void set(FilePickerResult? value) {
    state = value;
  }
}

@riverpod
class ProfileSelected extends _$ProfileSelected {
  @override
  ProfileSelectState build() {
    return ProfileSelectState();
  }

  Future<void> getByEmail(String email) async {
    state = state.copyWith(status: StateStatus.loading);
    final either = await ref.read(profileRepositoryProvider).getByEmail(email);
    switch (either) {
      case Failure():
        state = state.copyWith(
          status: StateStatus.error,
          message: 'Não foi encontrado nenhum usuário com este email.',
        );
        break;
      case Success(:final value):
        add(value);
        state = state.copyWith(
          status: StateStatus.update,
          message: 'Usuário encontrado e adicionado como autor.',
        );
        break;
    }
  }

  void add(ProfileListModel model) {
    state = state.copyWith(author: model);
  }
}
