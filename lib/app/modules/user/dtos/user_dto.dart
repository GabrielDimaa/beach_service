class UserDto {
  int id;

  String nome;
  String email;
  String password;

  bool isVendedor;

  UserDto(this.id, this.nome, this.email, this.password, this.isVendedor);
}