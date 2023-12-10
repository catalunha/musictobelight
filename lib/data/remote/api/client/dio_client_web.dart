import 'dart:developer';

import 'package:dio/browser.dart';
import 'package:dio/dio.dart';

import '../base_urls.dart';
import 'interceptors/my_auth_interceptor.dart';

final class DioClient extends DioForBrowser {
  DioClient()
      : super(
          BaseOptions(
            baseUrl: ApiV1EndPoints.baseurl,
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 60),
          ),
        ) {
    log('usando DioForBrowser');
    interceptors.addAll(
      [
        // LogInterceptor(
        //   requestBody: true,
        //   responseBody: true,
        // ),
        MyAuthInterceptor(),
      ],
    );
  }

  DioClient get auth {
    options.extra['authorized_request'] = true;
    return this;
  }

  DioClient get unauth {
    options.extra['authorized_request'] = false;
    return this;
  }
}
