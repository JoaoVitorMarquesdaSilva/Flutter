import 'package:flutter/material.dart';
import '../relatorios/grafico_custo_page.dart';

class HistoricoAbastecimentoPage extends StatelessWidget {
  const HistoricoAbastecimentoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(title: const Text("Histórico de Abastecimentos")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton.icon(
              icon: const Icon(Icons.bar_chart),
              label: const Text("Ver Gráfico de Custos"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const GraficoCustoPage(),
                  ),
                );
              },
            ),
          ),

          const Divider(color: Colors.white24),

          
        ],
      ),
    );
  }
}
