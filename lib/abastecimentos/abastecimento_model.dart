class Abastecimento {
  String id;
  DateTime data;
  double quantidadeLitros;
  double valorPago;
  int quilometragem;
  String tipoCombustivel;
  String veiculoId;
  double consumo;
  String observacao;

  Abastecimento({
    required this.id,
    required this.data,
    required this.quantidadeLitros,
    required this.valorPago,
    required this.quilometragem,
    required this.tipoCombustivel,
    required this.veiculoId,
    required this.consumo,
    required this.observacao,
  });

  Map<String, dynamic> toMap() {
    return {
      'data': data.toIso8601String(),
      'quantidadeLitros': quantidadeLitros,
      'valorPago': valorPago,
      'quilometragem': quilometragem,
      'tipoCombustivel': tipoCombustivel,
      'veiculoId': veiculoId,
      'consumo': consumo,
      'observacao': observacao,
    };
  }

  factory Abastecimento.fromMap(String id, Map<String, dynamic> data) {
    return Abastecimento(
      id: id,
      data: DateTime.parse(data['data']),
      quantidadeLitros: data['quantidadeLitros'] * 1.0,
      valorPago: data['valorPago'] * 1.0,
      quilometragem: data['quilometragem'],
      tipoCombustivel: data['tipoCombustivel'],
      veiculoId: data['veiculoId'],
      consumo: data['consumo'] * 1.0,
      observacao: data['observacao'],
    );
  }
}
