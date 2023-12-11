import 'package:dio/dio.dart';
import 'package:musictobeligth/models/album_model.dart';
import 'package:retrofit/retrofit.dart';
import '../../client/dio_client.dart'
    if (dart.library.io) '../../client/dio_client_android.dart'
    if (dart.library.js) '../../client/dio_client_web.dart';

part 'album_rest.g.dart';

@RestApi()
abstract class AlbumRest {
  factory AlbumRest(DioClient dio) = _AlbumRest;

  @POST('/api/musics/album/')
  Future<String> create(@Body() FormData data);

  @GET('/api/musics/album/')
  Future<List<AlbumModelList>> list();

  @GET('/api/musics/album/{id}/')
  Future<AlbumModel> read(@Path() String id);

  @PATCH('/api/musics/album/{id}/')
  Future<void> update(@Path() String id, @Body() FormData data);

  @DELETE('/api/musics/album/{id}/')
  Future<HttpResponse> delete(@Path() String id);
}
