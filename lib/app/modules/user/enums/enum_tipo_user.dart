enum EnumTipoUser {
  Consumidor,
  Vendedor
}

class EnumTipoUserHelper {
  static const Map<EnumTipoUser, int> _values = {
    EnumTipoUser.Consumidor: 0,
    EnumTipoUser.Vendedor: 1,
  };

  static const Map<EnumTipoUser, String> _descriptions = {
    EnumTipoUser.Consumidor: "Consumidor",
    EnumTipoUser.Vendedor: "Vendedor",
  };

  static String description(EnumTipoUser tipoUser) => _descriptions[tipoUser];

  static int getValue(EnumTipoUser tipoUser) => _values[tipoUser];

  static EnumTipoUser get(int value) => _values.keys.firstWhere((tipoUser) => getValue(tipoUser) == value, orElse: () => null);
}