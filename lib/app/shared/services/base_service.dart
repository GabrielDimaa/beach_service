import 'package:beach_service/app/shared/dtos/base_dto_interface.dart';
import 'package:beach_service/app/shared/repositories/base_repository_interface.dart';
import 'package:beach_service/app/shared/services/base_service_interface.dart';

class BaseService<T extends IBaseDto, Y extends IBaseRepository<T>> implements IBaseService<T> {
  final Y baseRepository;

  BaseService(this.baseRepository);

  @override
  Future<List<T>> getAll({dynamic params}) async => await baseRepository.getAll(params: params);

  @override
  Future<T> getById(int id) async => await baseRepository.getById(id);

  @override
  Future<T> getFirst() async => await baseRepository.getFirst();

  @override
  Future<T> saveOrUpdate(T dto) async {
    if (dto.base.id == null) {
      dto = await baseRepository.save(dto);
    } else {
      dto = await baseRepository.update(dto);
    }
    return dto;
  }

  @override
  Future<bool> delete(int id) async => await baseRepository.delete(id);
}