import 'package:beach_service/app/shared/api/interceptors_api.dart';
import 'package:dio/native_imp.dart';

abstract class BaseURL {
  static String baseURL = "http://c288c4fc8050.ngrok.io";
}

class Api extends DioForNative {
  Api() {
    interceptors.add(InterceptorsApi());
  }
}