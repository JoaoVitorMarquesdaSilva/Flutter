import 'package:flutter/material.dart';
import 'abastecimento_service.dart';
import 'abastecimento_model.dart';
import 'abastecimento_form_page.dart';

class AbastecimentosPage extends StatelessWidget {
  final String veiculoId;

  AbastecimentosPage({required this.veiculoId});

  final service = AbastecimentoService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Abastecimentos")),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AbastecimentoFormPage(veiculoId: veiculoId),
            ),
          );
        },
      ),
      body: StreamBuilder<List<Abastecimento>>(
        stream: service.list(veiculoId),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());

          var lista = snapshot.data!;

          if (lista.isEmpty) {
            return Center(
              child: Text("Nenhum abastecimento cadastrado."),
            );
          }

          return ListView.builder(
            itemCount: lista.length,
            itemBuilder: (context, index) {
              final a = lista[index];

              return ListTile(
                title: Text(
                    "${a.quantidadeLitros} L - R\$ ${a.valorPago.toStringAsFixed(2)}"),
                subtitle: Text(
                    "${a.data.day}/${a.data.month}/${a.data.year} | Km: ${a.quilometragem}"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AbastecimentoFormPage(
                        veiculoId: veiculoId,
                        abastecimento: a,
                      ),
                    ),
                  );
                },
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () => service.delete(veiculoId, a.id),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
