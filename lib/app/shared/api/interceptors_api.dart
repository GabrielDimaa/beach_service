import 'package:beach_service/app/modules/login/dtos/login_dto.dart';
import 'package:beach_service/app/shared/preferences/auth_preferences.dart';
import 'package:beach_service/app/shared/extensions/string_extension.dart';
import 'package:dio/dio.dart';

class InterceptorsApi extends InterceptorsWrapper {
  @override
  Future <void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    LoginDto dto = await AuthPreferences().get();

    if (dto!= null && dto.token.notIsNullOrEmpty()) {
      options.headers['Authorization'] = 'Bearer ${dto.token}';
    }

    return super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    return handler.next(err);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return handler.next(response);
  }
}