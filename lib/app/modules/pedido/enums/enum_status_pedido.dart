enum EnumStatusPedido {
  Cancelado,
  EmAberto,
  Aceito,
  Finalizado
}

class EnumStatusPedidoHelper {
  static const Map<EnumStatusPedido, int> _values = {
    EnumStatusPedido.Cancelado: 0,
    EnumStatusPedido.EmAberto: 1,
    EnumStatusPedido.Aceito: 2,
    EnumStatusPedido.Finalizado: 3,
  };

  static const Map<EnumStatusPedido, String> _descriptions = {
    EnumStatusPedido.Cancelado: "Cancelado",
    EnumStatusPedido.EmAberto: "Em Aberto",
    EnumStatusPedido.Aceito: "Aceito",
    EnumStatusPedido.Finalizado: "Finalizado",
  };

  static String description(EnumStatusPedido status) => _descriptions[status];

  static int getValue(EnumStatusPedido status) => _values[status];

  static EnumStatusPedido get(int value) => _values.keys.firstWhere((status) => getValue(status) == value, orElse: () => null);
}