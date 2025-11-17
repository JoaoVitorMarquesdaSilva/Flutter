import 'package:flutter/material.dart';
import 'vehicle_model.dart';
import 'vehicle_service.dart';

class VehicleFormPage extends StatefulWidget {
  final Vehicle? vehicle;

  VehicleFormPage({this.vehicle});

  @override
  _VehicleFormPageState createState() => _VehicleFormPageState();
}

class _VehicleFormPageState extends State<VehicleFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _service = VehicleService();

  late TextEditingController modelo;
  late TextEditingController marca;
  late TextEditingController placa;
  late TextEditingController ano;
  late TextEditingController tipoCombustivel;

  @override
  void initState() {
    super.initState();
    modelo = TextEditingController(text: widget.vehicle?.modelo ?? "");
    marca = TextEditingController(text: widget.vehicle?.marca ?? "");
    placa = TextEditingController(text: widget.vehicle?.placa ?? "");
    ano = TextEditingController(text: widget.vehicle?.ano ?? "");
    tipoCombustivel = TextEditingController(text: widget.vehicle?.tipoCombustivel ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.vehicle == null ? "Adicionar Veículo" : "Editar Veículo"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: modelo,
                decoration: InputDecoration(labelText: "Modelo"),
                validator: (v) => v!.isEmpty ? "Informe o modelo" : null,
              ),
              TextFormField(
                controller: marca,
                decoration: InputDecoration(labelText: "Marca"),
              ),
              TextFormField(
                controller: placa,
                decoration: InputDecoration(labelText: "Placa"),
              ),
              TextFormField(
                controller: ano,
                decoration: InputDecoration(labelText: "Ano"),
              ),
              TextFormField(
                controller: tipoCombustivel,
                decoration: InputDecoration(labelText: "Tipo de Combustível"),
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                child: Text(widget.vehicle == null ? "Salvar" : "Atualizar"),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {

                    if (widget.vehicle == null) {
                      
                      await _service.create(
                        Vehicle(
                          id: "", 
                          modelo: modelo.text,
                          marca: marca.text,
                          placa: placa.text,
                          ano: ano.text,
                          tipoCombustivel: tipoCombustivel.text,
                        ),
                      );
                    } else {
                     
                      await _service.update(
                        Vehicle(
                          id: widget.vehicle!.id,
                          modelo: modelo.text,
                          marca: marca.text,
                          placa: placa.text,
                          ano: ano.text,
                          tipoCombustivel: tipoCombustivel.text,
                        ),
                      );
                    }

                    
                    Navigator.pop(context);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
