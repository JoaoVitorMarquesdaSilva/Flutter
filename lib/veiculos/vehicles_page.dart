import 'package:flutter/material.dart';
import 'vehicle_service.dart';
import 'vehicle_model.dart';
import 'vehicle_form_page.dart';

class VehiclesPage extends StatelessWidget {
  final VehicleService service = VehicleService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Meus Veículos")),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => VehicleFormPage()),
          );
        },
      ),
      body: StreamBuilder<List<Vehicle>>(
        stream: service.list(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

          var vehicles = snapshot.data!;

          if (vehicles.isEmpty) {
            return Center(child: Text("Nenhum veículo cadastrado"));
          }

          return ListView.builder(
            itemCount: vehicles.length,
            itemBuilder: (context, index) {
              final v = vehicles[index];

              return ListTile(
                title: Text("${v.modelo} - ${v.placa}"),
                subtitle: Text("${v.marca} | ${v.tipoCombustivel}"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => VehicleFormPage(vehicle: v),
                    ),
                  );
                },
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () => service.delete(v.id),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
