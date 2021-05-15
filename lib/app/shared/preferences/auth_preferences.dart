import 'package:beach_service/app/modules/login/dtos/login_dto.dart';
import 'package:beach_service/app/shared/constants/shared_preferences.dart';
import 'package:beach_service/app/shared/dtos/base_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class IAuthPreferences {
  Future<void> save(LoginDto dto);
  Future<LoginDto> get();
  Future<void> delete();
}

class AuthPreferences implements IAuthPreferences {
  Future<SharedPreferences> _getPref() async => await SharedPreferences.getInstance();

  @override
  Future<void> save(LoginDto dto) async {
    var prefs = await _getPref();

    prefs.setInt(UID, dto.base.id);
    prefs.setString(TOKEN, dto.token);
    prefs.setString(EMAIL, dto.email);
    prefs.setString(PASSWORD, dto.password);
  }

  @override
  Future<LoginDto> get() async {
    var prefs = await _getPref();

    return LoginDto(
      base: BaseDto(prefs.getInt(UID)),
      token: prefs.getString(TOKEN),
      email: prefs.getString(EMAIL),
      password: prefs.getString(PASSWORD),
    );
  }

  @override
  Future<void> delete() async {
    var prefs = await _getPref();

    prefs.remove(UID);
    prefs.remove(TOKEN);
    prefs.remove(EMAIL);
    prefs.remove(PASSWORD);
  }
}