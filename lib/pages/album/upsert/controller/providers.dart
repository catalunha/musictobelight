import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/functional_program/either.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../models/album_model.dart';
import '../../../../repositories/providers.dart';
import '../../list/controller/providers.dart';
import 'states.dart';

part 'providers.g.dart';

@riverpod
FutureOr<AlbumModel?> albumRead(AlbumReadRef ref, {required String? id}) async {
  if (id != null) {
    final result = await ref.read(albumRepositoryProvider).read(id);

    switch (result) {
      case Failure(:final exception):
        return throw AsyncError(exception.message, StackTrace.current);
      case Success(:final value):
        ref.watch(albumUpsertControllerProvider.notifier).setModel(value);

        return value;
    }
  }
  return null;
}

@riverpod
class AlbumUpsertController extends _$AlbumUpsertController {
  @override
  AlbumUpsertState build() {
    return AlbumUpsertState();
  }

  void setModel(AlbumModel? model) {
    state = state.copyWith(model: model);
  }

  Future<void> submitForm({
    required String name,
    String? description,
  }) async {
    state = state.copyWith(status: AlbumUpsertStatus.loading);
    Either either;
    final profile = ref.watch(meProfileProvider)!;
    try {
      FormData data = FormData();
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
      if (state.model != null) {
        data.fields.add(MapEntry("name", name));
        if (description != null && description.isEmpty) {
          data.fields.add(MapEntry("description", description));
        }
        either = await ref
            .read(albumRepositoryProvider)
            .update(state.model!.id, data);
      } else {
        data.fields.add(MapEntry("name", name));
        data.fields.add(MapEntry("coordinator", profile.id));
        if (description != null && description.isEmpty) {
          data.fields.add(MapEntry("description", description));
        }
        either = await ref.read(albumRepositoryProvider).create(data);
      }
      switch (either) {
        case Failure():
          state = state.copyWith(
              status: AlbumUpsertStatus.error, error: 'Erro em editar regiao');
        case Success():
          ref.invalidate(albumListProvider);
          state = state.copyWith(status: AlbumUpsertStatus.success);
      }
    } catch (e, st) {
      log('$e');
      log('$st');
      state = state.copyWith(
          status: AlbumUpsertStatus.error, error: 'Erro em editar cargo');
    }
  }

  Future<void> delete() async {
    state = state.copyWith(status: AlbumUpsertStatus.loading);
    try {
      final either =
          await ref.read(albumRepositoryProvider).delete(state.model!.id);
      switch (either) {
        case Failure():
          state = state.copyWith(
              status: AlbumUpsertStatus.error, error: 'Erro em apagar regiao');
        case Success():
          ref.invalidate(albumListProvider);
          state = state.copyWith(status: AlbumUpsertStatus.success);
      }
    } catch (e, st) {
      log('$e');
      log('$st');
      state = state.copyWith(
          status: AlbumUpsertStatus.error, error: 'Erro em editar cargo');
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
