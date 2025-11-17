import 'package:flutter/material.dart';
import '../veiculos/vehicle_service.dart';
import '../veiculos/vehicle_model.dart';
import 'abastecimentos_page.dart';

class SelectVehiclePage extends StatelessWidget {
  final service = VehicleService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Selecione um Veículo")),
      body: StreamBuilder<List<Vehicle>>(
        stream: service.list(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

          var lista = snapshot.data!;

          if (lista.isEmpty) {
            return Center(
              child: Text("Nenhum veículo cadastrado."),
            );
          }

          return ListView.builder(
            itemCount: lista.length,
            itemBuilder: (context, index) {
              final v = lista[index];
              return ListTile(
                title: Text("${v.modelo} - ${v.placa}"),
                subtitle: Text(v.marca),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AbastecimentosPage(veiculoId: v.id),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
