import 'package:beach_service/app/modules/produto/dtos/produto_dto.dart';
import 'package:beach_service/app/shared/dtos/base_dto.dart';
import 'package:beach_service/app/shared/dtos/base_dto_interface.dart';

class UserProdDto implements IBaseDto {
  @override
  BaseDto base;

  String nome;
  String email;
  String telefone;
  String empresa;

  double lat;
  double lng;
  double distance;

  List<ProdutoDto> produtos;

  UserProdDto({
    this.base,
    this.nome,
    this.email,
    this.telefone,
    this.empresa,
    this.lat,
    this.lng,
    this.distance,
    this.produtos,
  });
}
