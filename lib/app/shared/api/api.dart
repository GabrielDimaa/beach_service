import 'package:beach_service/app/shared/api/interceptors_api.dart';
import 'package:dio/native_imp.dart';

abstract class BaseURL {
  static String baseURL = "http://10.0.2.2:3333";
}

class Api extends DioForNative {
  Api() {
    interceptors.add(InterceptorsApi());
  }
}