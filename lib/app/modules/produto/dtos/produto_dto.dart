import 'package:beach_service/app/modules/produto/dtos/categoria_dto.dart';
import 'package:beach_service/app/shared/dtos/base_dto.dart';
import 'package:beach_service/app/shared/dtos/base_dto_interface.dart';

class ProdutoDto implements IBaseDto {
  @override
  BaseDto base;

  String nome;
  CategoriaDto categoriaDto;

  ProdutoDto(this.base, this.nome, this.categoriaDto);
}