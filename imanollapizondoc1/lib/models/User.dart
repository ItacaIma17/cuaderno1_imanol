// lib/models/User.dart
import 'dart:typed_data';

class User {
  final String nombre;
  final String? contrasena;
  final int? edad;
  final String? ciudad;

  // Nuevos: ruta en el sistema (desktop/mobile) y bytes para web
  final String? imagenPath;
  final Uint8List? imagenBytes;

  User({
    required this.nombre,
    this.contrasena,
    this.edad,
    this.ciudad,
    this.imagenPath,
    this.imagenBytes,
  });

  @override
  String toString() {
    return 'User(nombre: $nombre, edad: $edad, ciudad: $ciudad, imagenPath: $imagenPath)';
  }
}
