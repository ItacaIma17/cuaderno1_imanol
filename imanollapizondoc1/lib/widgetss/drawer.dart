import 'dart:io';
import 'package:flutter/material.dart';
import 'package:imanollapizondoc1/screens/Login_screen.dart';
import 'package:imanollapizondoc1/models/User.dart';

class CustomDrawer extends StatelessWidget {
  final User usuario;

  const CustomDrawer({super.key, required this.usuario});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Encabezado del Drawer
          UserAccountsDrawerHeader(
            accountName: Text(usuario.nombre),
            accountEmail: Text("${usuario.nombre}@email.com"),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 40, color: Colors.blueAccent),
            ),
            decoration: const BoxDecoration(
              color: Colors.lightBlueAccent,
            ),
          ),

          // Opción: Volver al login
          ListTile(
            leading: const Icon(Icons.home, color: Colors.blueAccent),
            title: const Text("Pantalla de inicio de sesión"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              );
            },
          ),

          // Opción: Mi perfil
          ListTile(
            leading: const Icon(Icons.person, color: Colors.blueAccent),
            title: const Text("Mi perfil"),
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text("Perfil del usuario"),
                  content: Text(
                    "Nombre: ${usuario.nombre}\n"
                    "Edad: ${usuario.edad ?? 'No especificada'}\n"
                    "Ciudad: ${usuario.ciudad ?? 'No especificada'}",
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Cerrar"),
                    ),
                  ],
                ),
              );
            },
          ),

          // Opción: Salir
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.redAccent),
            title: const Text("Salir"),
            onTap: () => exit(0),
          ),
        ],
      ),
    );
  }
}
