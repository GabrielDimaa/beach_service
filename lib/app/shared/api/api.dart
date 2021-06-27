import 'package:beach_service/app/shared/api/interceptors_api.dart';
import 'package:dio/native_imp.dart';

abstract class BaseURL {
  static String baseURL = "http://1d3172a82bb3.ngrok.io";
}

class Api extends DioForNative {
  Api() {
    interceptors.add(InterceptorsApi());
  }
}