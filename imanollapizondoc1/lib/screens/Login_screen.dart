import 'package:flutter/material.dart';
import 'package:imanollapizondoc1/services/LogicaUsuario.dart';
import 'PantallaPrincipal.dart';
import 'Register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _nombreController = TextEditingController();
  final _contrasenaController = TextEditingController();

  void _login() {

     if (_nombreController.text.trim().isEmpty ||
        _contrasenaController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Debe introducir usuario y contraseña')),
      );
      return;
    }

    final user = Logicausuarios.login(
      _nombreController.text.trim(),
      _contrasenaController.text.trim(),
    );

      
    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => PantallaPrincipal(usuario: user)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Usuario o contraseña incorrecta")),
      );
    }
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _contrasenaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Pantalla de inicio de sesion"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo grande
              Image.asset(
                'assets/images/Youtube.png',
                height: 120,
              ),
              const SizedBox(height: 40),

              
              Padding(padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5)),
              
              SizedBox(
                height: 40,
                
                child: Container(
                  width: 250,
                  child: TextField(
                    
                    controller: _nombreController,
                    decoration: InputDecoration(
                      labelText: "Usuario",
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: const BorderSide(color: Colors.blueAccent),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5)),
              
              SizedBox(
                height: 45,
                width: 250,
                child: Container(
                  child: TextField(
                    controller: _contrasenaController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Contraseña",
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: const BorderSide(color: Colors.blueAccent),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5)),
              SizedBox(

                height: 40,
                width:210,
                child: OutlinedButton(
                  onPressed: _login,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.lightBlueAccent),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.zero,
                  ),
                  child: const Text(
                    "Iniciar sesión",
                    style: TextStyle(color: Colors.lightBlueAccent, fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              Padding(padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5)),
              SizedBox(
                width: 210,
                height: 40,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const Register_Screen()),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.lightBlueAccent),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.zero,
                  ),
                  child: const Text(
                    "Registrarte",
                    style: TextStyle(color: Colors.lightBlueAccent, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
