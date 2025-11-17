import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class GraficoCustoPage extends StatelessWidget {
  const GraficoCustoPage({super.key});

  Future<Map<int, double>> carregarCustosPorMes() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final db = FirebaseFirestore.instance
        .collection("usuarios")
        .doc(uid)
        .collection("veiculos");

    // Pega todos os veículos
    final veiculosSnapshot = await db.get();

    Map<int, double> custosMensais = {
      for (int i = 1; i <= 12; i++) i: 0.0,
    };

    for (var veiculo in veiculosSnapshot.docs) {
      final abastecimentos = await db
          .doc(veiculo.id)
          .collection("abastecimentos")
          .get();

      for (var doc in abastecimentos.docs) {
        final dados = doc.data();

        DateTime data = DateTime.parse(dados['data']);
        double valor = (dados['valorPago'] * 1.0);

        custosMensais[data.month] =
            (custosMensais[data.month] ?? 0) + valor;
      }
    }

    return custosMensais;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: const Text("Gráfico de Custos"),
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder<Map<int, double>>(
        future: carregarCustosPorMes(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final dados = snapshot.data!;

          final barras = dados.entries
              .map((e) => BarChartGroupData(
                    x: e.key,
                    barRods: [
                      BarChartRodData(
                        toY: e.value,
                        width: 14,
                      ),
                    ],
                  ))
              .toList();

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: BarChart(
              BarChartData(
                borderData: FlBorderData(show: false),
                gridData: const FlGridData(show: false),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      reservedSize: 45,
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          "R\$${value.toInt()}",
                          style: const TextStyle(color: Colors.white),
                        );
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        if (value < 1 || value > 12) return const SizedBox();
                        return Text(
                          ["", "Jan","Fev","Mar","Abr","Mai","Jun","Jul","Ago","Set","Out","Nov","Dez"][value.toInt()],
                          style: const TextStyle(color: Colors.white),
                        );
                      },
                    ),
                  ),
                ),
                barGroups: barras,
              ),
            ),
          );
        },
      ),
    );
  }
}
