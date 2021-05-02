import 'package:beach_service/app/modules/user/dtos/user_dto.dart';
import 'package:beach_service/app/shared/repositories/base_repository_interface.dart';
import 'package:sqflite/sqflite.dart';

abstract class IUserRepository implements IBaseRepository<UserDto> {
  Future<void> create(Batch batch);
  Future<void> getInDb();
  String tableName();
}