import 'package:abastecimento_app/abastecimentos/historico_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import 'login_page.dart';
import '../veiculos/vehicles_page.dart';
import '../abastecimentos/select_vehicle_page.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      
      appBar: AppBar(
        title: const Text("Página Inicial"),
        backgroundColor: Colors.blue,
      ),

      // ----------------------- DRAWER LATERAL -----------------------
      drawer: Drawer(
        backgroundColor: Colors.blue,
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: const Center(
                child: Text(
                  "Menu",
                  style: TextStyle(fontSize: 22, color: Colors.white),
                ),
              ),
            ),

            
            ListTile(
              leading: const Icon(Icons.directions_car, color: Colors.white),
              title: const Text("Meus Veículos", style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => VehiclesPage()),
                );
              },
            ),

            
            ListTile(
              leading: const Icon(Icons.local_gas_station, color: Colors.white),
              title: const Text("Registrar Abastecimento",
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => SelectVehiclePage()),
                );
              },
            ),

          
            ListTile(
              leading: const Icon(Icons.history, color: Colors.white),
              title: const Text("Histórico de Abastecimentos",
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => HistoricoAbastecimentoPage()),
                );
              },
            ),

            const Divider(color: Colors.white24),

            
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.white),
              title: const Text("Sair",
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                auth.logout();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                );
              },
            ),
          ],
        ),
      ),

      
      body: const Center(
        child: Text(
          "Bem-vindo!",
          style: TextStyle(fontSize: 22, color: Colors.white),
        ),
      ),
    );
  }
}
