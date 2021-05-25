import 'package:beach_service/app/modules/produto/dtos/categoria_dto.dart';
import 'package:beach_service/app/modules/produto/dtos/produto_dto.dart';
import 'package:diacritic/diacritic.dart';

abstract class ProdutosUtils {
  static List<CategoriaDto> getCategorias(List<ProdutoDto> produtos) {
    List<CategoriaDto> categorias = [];

    produtos.forEach((e) {
      if (!categorias.any((element) => element.base.id == e.categoriaDto.base.id)) categorias.add(e.categoriaDto);
    });

    categorias.sort((a, b) => removeDiacritics(a.descricao?.toLowerCase()).compareTo(b.descricao?.toLowerCase()));

    return categorias;
  }
}