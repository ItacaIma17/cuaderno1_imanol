import 'dart:io' show File;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:imanollapizondoc1/models/User.dart';
import 'package:imanollapizondoc1/screens/PantallaPrincipal.dart';

class Profile extends StatelessWidget {
  final User usuario;
  const Profile({super.key, required this.usuario});

  @override
  Widget build(BuildContext context) {
    ImageProvider? imageProvider;

    if (usuario.imagenBytes != null) {
      imageProvider = MemoryImage(usuario.imagenBytes!);
    } else if (usuario.imagenPath != null && !kIsWeb) {
      imageProvider = FileImage(File(usuario.imagenPath!));
    }

    return Scaffold(
    appBar: AppBar(
  title: const Text("Perfil del usuario"),
  backgroundColor: Colors.blueAccent,
  centerTitle: true,
  leading: IconButton(
    icon: const Icon(Icons.arrow_back),
    onPressed: () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => PantallaPrincipal(usuario: usuario),
        ),
      );
    },
  ),
),
      body: Center(
        child: Container(
          width: 380,
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 25),
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // FOTO DE PERFIL
              CircleAvatar(
                radius: 60,
                backgroundColor: Colors.blueAccent.shade100,
                backgroundImage: imageProvider,
                child: imageProvider == null
                    ? const Icon(Icons.person, size: 70, color: Colors.white)
                    : null,
              ),

              const SizedBox(height: 25),

              // NOMBRE
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.person, color: Colors.blueAccent),
                  const SizedBox(width: 8),
                  Text(
                    usuario.nombre,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              // EDAD
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Edad:",style: const TextStyle(fontSize: 18),),

                    const SizedBox(width: 8),
                    Text(
                      usuario.edad != null
                          ? "${usuario.edad} años"
                          : "Edad no especificada",
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),


              const SizedBox(height: 15),

              // CIUDAD
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   
                    const SizedBox(width: 8),
                    Text(
                      (usuario.ciudad?.isNotEmpty ?? false)
                          ? usuario.ciudad!
                          : "Ciudad no especificada",
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),

              const SizedBox(height: 30),

              
            ],
          ),
        ),
      ),
      backgroundColor: Colors.grey[100],
    );
  }
}
