import 'package:beach_service/app/shared/api/interceptors_api.dart';
import 'package:dio/native_imp.dart';

abstract class BaseURL {
  static String baseURL = "http://8d0481424947.ngrok.io";
}

class Api extends DioForNative {
  Api() {
    interceptors.add(InterceptorsApi());
  }
}