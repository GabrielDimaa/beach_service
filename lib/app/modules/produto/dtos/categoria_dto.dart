import 'package:beach_service/app/shared/dtos/base_dto.dart';
import 'package:beach_service/app/shared/dtos/base_dto_interface.dart';

class CategoriaDto implements IBaseDto {
  @override
  BaseDto base;

  String nome;

  CategoriaDto(this.base, this.nome);
}