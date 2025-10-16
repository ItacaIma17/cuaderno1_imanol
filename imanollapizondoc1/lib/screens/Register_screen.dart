import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imanollapizondoc1/models/User.dart';
import 'package:imanollapizondoc1/screens/Login_screen.dart';
import 'package:imanollapizondoc1/services/LogicaUsuario.dart';
import 'package:imanollapizondoc1/config/utils/CustomButton.dart';
import 'dart:io';

class Register_Screen extends StatefulWidget {
  const Register_Screen({super.key});

  @override
  State<Register_Screen> createState() => _Register_ScreenState();
}

class _Register_ScreenState extends State<Register_Screen> {
  final _formKey = GlobalKey<FormState>();
  bool terminos = false;
  bool sr = false;
  bool sra = false;

  // Controllers
  final _nombreController = TextEditingController();
  final _contrasenaController = TextEditingController();
  final _repetirContrasenaController = TextEditingController();
  final _edadController = TextEditingController();

  // Imagenes
  String? _photoPath;
  Uint8List? _webImage;

  // Ciudades
  String? _ciudadSeleccionada;
  final List<String> _ciudades = ['Zaragoza', 'Huesca', 'Teruel'];

  @override
  void dispose() {
    _nombreController.dispose();
    _contrasenaController.dispose();
    _repetirContrasenaController.dispose();
    _edadController.dispose();
    super.dispose();
  }

  void _mostrarOpcionesImagen(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.image),
            title: const Text('Seleccionar de galería'),
            onTap: () async {
              Navigator.pop(context);
              final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
              if (picked == null) return;
              if (kIsWeb) {
                final bytes = await picked.readAsBytes();
                setState(() {
                  _webImage = bytes;
                  _photoPath = null;
                });
              } else {
                setState(() {
                  _photoPath = picked.path;
                  _webImage = null;
                });
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text('Tomar foto'),
            onTap: () async {
              Navigator.pop(context);
              final picked = await ImagePicker().pickImage(source: ImageSource.camera);
              if (picked == null) return;
              if (kIsWeb) {
                final bytes = await picked.readAsBytes();
                setState(() {
                  _webImage = bytes;
                  _photoPath = null;
                });
              } else {
                setState(() {
                  _photoPath = picked.path;
                  _webImage = null;
                });
              }
            },
          ),
        ],
      ),
    );
  }

  void _Register() {
    final isFormValid = _formKey.currentState?.validate() ?? false;
    if (!isFormValid) return;

    if (!terminos) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Debe aceptar los términos y condiciones')),
      );
      return;
    }

    if (!sr && !sra) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Debe elegir su trato (Sr. o Sra.)')),
      );
      return;
    }

    if (_contrasenaController.text != _repetirContrasenaController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Las contraseñas no coinciden')),
      );
      return;
    }

    if (Logicausuarios.existeUsuario(_nombreController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('El nombre de usuario ya existe')),
      );
      return;
    }

    int? edad = int.tryParse(_edadController.text);

    try {
      final nuevo = User(
        nombre: _nombreController.text.trim(),
        contrasena: _contrasenaController.text,
        edad: edad,
        ciudad: _ciudadSeleccionada, // ✅ Guardamos la ciudad seleccionada
        imagenPath: _photoPath,
        imagenBytes: _webImage,
      );

      Logicausuarios.anadirUsuarios(nuevo);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text('Registro'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Trato
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Tratamiento: "),
                    const Text("Sr."),
                    Checkbox(
                      value: sr,
                      onChanged: (value) {
                        setState(() {
                          sr = value!;
                          sra = false;
                        });
                      },
                    ),
                    const Text("Sra."),
                    Checkbox(
                      value: sra,
                      onChanged: (value) {
                        setState(() {
                          sra = value!;
                          sr = false;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Nombre
                SizedBox(
                  width: 350,
                  child: TextFormField(
                    controller: _nombreController,
                    decoration: const InputDecoration(
                        labelText: 'Nombre', border: OutlineInputBorder()),
                    validator: (v) =>
                        (v == null || v.isEmpty) ? 'Ingrese un nombre' : null,
                  ),
                ),
                const SizedBox(height: 10),

                // Contraseña
                SizedBox(
                  width: 350,
                  child: TextFormField(
                    controller: _contrasenaController,
                    obscureText: true,
                    decoration: const InputDecoration(
                        labelText: 'Contraseña', border: OutlineInputBorder()),
                    validator: (v) =>
                        (v == null || v.length < 4) ? 'Contraseña corta' : null,
                  ),
                ),
                const SizedBox(height: 10),

                // Repetir contraseña
                SizedBox(
                  width: 350,
                  child: TextFormField(
                    controller: _repetirContrasenaController,
                    obscureText: true,
                    decoration: const InputDecoration(
                        labelText: 'Repetir contraseña', border: OutlineInputBorder()),
                    validator: (v) =>
                        (v == null || v.isEmpty) ? 'Repita la contraseña' : null,
                  ),
                ),
                const SizedBox(height: 15),

                // Imagen
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: kIsWeb
                          ? (_webImage != null ? MemoryImage(_webImage!) : null)
                          : (_photoPath != null
                                  ? FileImage(File(_photoPath!))
                                  : null)
                              as ImageProvider<Object>?,
                      child: (_photoPath == null && _webImage == null)
                          ? const Icon(Icons.person, size: 60)
                          : null,
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      style: Custombutton.botonPorDefecto,
                      onPressed: () => _mostrarOpcionesImagen(context),
                      child: const Text('Cargar imagen'),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Edad
                SizedBox(
                  width: 350,
                  child: TextFormField(
                    controller: _edadController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Edad',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ingrese su edad';
                      }
                      final edad = int.tryParse(value);
                      if (edad == null) return 'La edad debe ser un número';
                      if (edad < 18) return 'Debe ser mayor de 18 años';
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 10),

                // 🔽 Ciudad (desplegable)
                SizedBox(
                  width: 350,
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Ciudad de nacimiento',
                      border: OutlineInputBorder(),
                    ),
                    value: _ciudadSeleccionada,
                    items: _ciudades.map((ciudad) {
                      return DropdownMenuItem(
                        value: ciudad,
                        child: Text(ciudad),
                      );
                    }).toList(),
                    onChanged: (valor) {
                      setState(() {
                        _ciudadSeleccionada = valor;
                      });
                    },
                    validator: (valor) =>
                        valor == null ? 'Debe seleccionar una ciudad' : null,
                  ),
                ),

                const SizedBox(height: 20),

                
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Aceptar términos y condiciones."),
                    Checkbox(
                      value: terminos,
                      onChanged: (value) {
                        setState(() {
                          terminos = value!;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 15),

                ElevatedButton(
                  style: Custombutton.botonPorDefecto,
                  onPressed: _Register,
                  child: const Text('Registrar'),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
