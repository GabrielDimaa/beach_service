import 'package:beach_service/app/modules/login/dtos/login_dto.dart';
import 'package:beach_service/app/shared/repositories/base_repository_interface.dart';
import 'package:sqflite/sqflite.dart';

abstract class ILoginRepository implements IBaseRepository<LoginDto> {
  Future<LoginDto> auth(LoginDto dto);
  Future<void> create(Batch batch);
  String tableName();
}