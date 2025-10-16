import 'package:imanollapizondoc1/models/User.dart';

class Logicausuarios {
  static final List<User> _listaUsuarios = [
    User(nombre: "admin", contrasena: "admin"),
  ];

  // Añadir usuario
  static void anadirUsuarios(User usuario) {
    final nombreNormalizado = usuario.nombre.trim().toLowerCase();
    if (_listaUsuarios.any((u) => u.nombre.trim().toLowerCase() == nombreNormalizado)) {
      throw Exception('El nombre de usuario ya está en uso');
    }
    _listaUsuarios.add(usuario);
  }

  // Obtener lista
  static List<User> getListaUsuarios() {
    return _listaUsuarios;
  }

  // Comprobar existencia
  static bool existeUsuario(String nombre) {
    final nombreNormalizado = nombre.trim().toLowerCase();
    return _listaUsuarios.any(
      (u) => u.nombre.trim().toLowerCase() == nombreNormalizado,
    );
  }

  // Verificar login
  static User? login(String nombre, String contrasena) {
    final nombreNormalizado = nombre.trim().toLowerCase();
    try {
      return _listaUsuarios.firstWhere(
        (u) =>
            u.nombre.trim().toLowerCase() == nombreNormalizado &&
            u.contrasena == contrasena,
      );
    } catch (e) {
      return null;
    }
  }
}
