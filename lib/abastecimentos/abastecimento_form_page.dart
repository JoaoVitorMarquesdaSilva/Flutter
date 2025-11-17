import 'package:flutter/material.dart';
import 'abastecimento_model.dart';
import 'abastecimento_service.dart';

class AbastecimentoFormPage extends StatefulWidget {
  final Abastecimento? abastecimento;
  final String veiculoId;

  AbastecimentoFormPage({this.abastecimento, required this.veiculoId});

  @override
  _AbastecimentoFormPageState createState() => _AbastecimentoFormPageState();
}

class _AbastecimentoFormPageState extends State<AbastecimentoFormPage> {
  final _formKey = GlobalKey<FormState>();
  final service = AbastecimentoService();

  late TextEditingController quantidade;
  late TextEditingController valor;
  late TextEditingController km;
  late TextEditingController tipoCombustivel;
  late TextEditingController observacao;
  DateTime dataSelecionada = DateTime.now();

  @override
  void initState() {
    super.initState();

    final a = widget.abastecimento;

    quantidade = TextEditingController(
        text: a != null ? a.quantidadeLitros.toString() : "");
    valor = TextEditingController(
        text: a != null ? a.valorPago.toString() : "");
    km = TextEditingController(
        text: a != null ? a.quilometragem.toString() : "");
    tipoCombustivel =
        TextEditingController(text: a?.tipoCombustivel ?? "");
    observacao = TextEditingController(text: a?.observacao ?? "");

    if (a != null) dataSelecionada = a.data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.abastecimento == null ? "Novo Abastecimento" : "Editar Abastecimento"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextButton(
                child: Text(
                  "Data: ${dataSelecionada.day}/${dataSelecionada.month}/${dataSelecionada.year}",
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () async {
                  DateTime? novaData = await showDatePicker(
                    context: context,
                    initialDate: dataSelecionada,
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2100),
                  );

                  if (novaData != null) {
                    setState(() => dataSelecionada = novaData);
                  }
                },
              ),

              TextFormField(
                controller: quantidade,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Qtd. Litros"),
                validator: (v) => v!.isEmpty ? "Informe a quantidade" : null,
              ),

              TextFormField(
                controller: valor,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Valor Pago"),
              ),

              TextFormField(
                controller: km,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Quilometragem"),
              ),

              TextFormField(
                controller: tipoCombustivel,
                decoration: InputDecoration(labelText: "Tipo Combustível"),
              ),

              TextFormField(
                controller: observacao,
                decoration: InputDecoration(labelText: "Observação"),
              ),

              SizedBox(height: 20),

              ElevatedButton(
                child: Text(widget.abastecimento == null ? "Salvar" : "Atualizar"),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    double litros = double.parse(quantidade.text);
                    int quilometros = int.parse(km.text);
                    double consumo = quilometros / litros;

                    if (widget.abastecimento == null) {
                      await service.create(
                        Abastecimento(
                          id: "",
                          data: dataSelecionada,
                          quantidadeLitros: litros,
                          valorPago: double.parse(valor.text),
                          quilometragem: quilometros,
                          tipoCombustivel: tipoCombustivel.text,
                          veiculoId: widget.veiculoId,
                          consumo: consumo,
                          observacao: observacao.text,
                        ),
                      );
                    } else {
                      await service.update(
                        Abastecimento(
                          id: widget.abastecimento!.id,
                          data: dataSelecionada,
                          quantidadeLitros: litros,
                          valorPago: double.parse(valor.text),
                          quilometragem: quilometros,
                          tipoCombustivel: tipoCombustivel.text,
                          veiculoId: widget.veiculoId,
                          consumo: consumo,
                          observacao: observacao.text,
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