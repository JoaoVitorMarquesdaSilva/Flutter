import 'package:flutter/material.dart';

class HistoricoAbastecimentoPage extends StatelessWidget {
  const HistoricoAbastecimentoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Histórico de Abastecimentos")),
      
      body: Column(
        children: [
          
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset(
              "assets/images/logo.png",
              height: 120,
            ),
          ),

          const Divider(),

          
          Expanded(
            child: ListView.builder(
              itemCount: 5, 
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.local_gas_station,
                      color: Colors.orangeAccent),
                  title: Text("Abastecimento ${index + 1}"),
                  subtitle: const Text("Litros: 40 • R\$ 240,00"),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
