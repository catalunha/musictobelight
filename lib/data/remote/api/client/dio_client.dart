// Fonte:
// https://instituto.academiadoflutter.com.br/area/produto/item/684017
import 'package:dio/dio.dart';

class DioClient with DioMixin implements Dio {
  DioClient get auth {
    options.extra['authorized_request'] = true;
    return this;
  }

  DioClient get unauth {
    options.extra['authorized_request'] = false;
    return this;
  }
}
