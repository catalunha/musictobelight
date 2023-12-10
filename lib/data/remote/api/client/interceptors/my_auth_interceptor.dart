import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:musictobeligth/routes_root.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/navigation_global_key.dart';

class MyAuthInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final RequestOptions(:headers, :extra) = options;
    headers.remove('Authorization');
    if (extra case {'authorized_request': true}) {
      final sharedPreferences = await SharedPreferences.getInstance();
      final token = sharedPreferences.getString('token_access');
      headers.addAll({'Authorization': 'Bearer $token'});
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final DioException(requestOptions: RequestOptions(:extra), :response) = err;
    log('----------------------------');
    log('PASSEI PELO MyAuthInterceptor onError ');
    log('----------------------------');
    log(err.toString());
    log(extra.toString());
    log(response.toString());
    if (extra case {'authorized_request': true}) {
      if (response != null &&
          (response.statusCode == HttpStatus.forbidden ||
              response.statusCode == HttpStatus.unauthorized)) {
        Navigator.of(NavigationGlobalKey.instance.navigationKey.currentContext!)
            .pushNamedAndRemoveUntil(RoutesRoot.login, (route) => false);
      }
    }
    handler.reject(err);
  }
}
