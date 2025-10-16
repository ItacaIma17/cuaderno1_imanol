import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:imanollapizondoc1/models/User.dart';
import 'package:imanollapizondoc1/config/utils/CustomButton.dart';
import 'package:imanollapizondoc1/screens/Profile.dart';
import 'Login_screen.dart';

class PantallaPrincipal extends StatelessWidget {
  final User usuario;
  const PantallaPrincipal({super.key, required this.usuario});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Bienvenido ${usuario.nombre}")),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(usuario.nombre),
              accountEmail: Text(usuario.nombre + "@email.com"),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Pantalla de inicio de sesión"),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );
              },
            ),
           ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Perfil"),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => Profile(usuario: usuario),
                  ),
                );
              },
            ),

            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Salir"),
              onTap: (){
                SystemNavigator.pop();
                exit(0);
              })
          ],
        ),
      ),
      body: Center(
        child: ElevatedButton(
          style: Custombutton.botonPorDefecto,
          child: const Text("Pantalla Login"),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const LoginScreen()),
            );
          },
        ),
      ),
    );
  }
}
