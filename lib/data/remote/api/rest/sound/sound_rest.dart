import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../../models/sound_model.dart';
import '../../client/dio_client.dart'
    if (dart.library.io) '../../client/dio_client_android.dart'
    if (dart.library.js) '../../client/dio_client_web.dart';
import 'dto/id_dto.dart';

part 'sound_rest.g.dart';

@RestApi()
abstract class SoundRest {
  factory SoundRest(DioClient dio) = _SoundRest;

  @POST('/api/musics/sound/')
  Future<String> create(@Body() FormData data);

  @GET('/api/musics/sound/')
  Future<List<SoundModelList>> list(@Queries() AlbumIdDto idDto);

  @GET('/api/musics/sound/{id}/')
  Future<SoundModel> read(@Path() String id);

  @PATCH('/api/musics/sound/{id}/')
  Future<void> update(@Path() String id, @Body() FormData data);

  @DELETE('/api/musics/sound/{id}/')
  Future<HttpResponse> delete(@Path() String id);
}
