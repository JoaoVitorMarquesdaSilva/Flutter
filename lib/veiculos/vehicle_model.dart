class Vehicle {
  String id;
  String modelo;
  String marca;
  String placa;
  String ano;
  String tipoCombustivel;

  Vehicle({
    required this.id,
    required this.modelo,
    required this.marca,
    required this.placa,
    required this.ano,
    required this.tipoCombustivel,
  });

  Map<String, dynamic> toMap() {
    return {
      'modelo': modelo,
      'marca': marca,
      'placa': placa,
      'ano': ano,
      'tipoCombustivel': tipoCombustivel,
    };
  }

  factory Vehicle.fromMap(String id, Map<String, dynamic> data) {
    return Vehicle(
      id: id,
      modelo: data['modelo'],
      marca: data['marca'],
      placa: data['placa'],
      ano: data['ano'],
      tipoCombustivel: data['tipoCombustivel'],
    );
  }
}
