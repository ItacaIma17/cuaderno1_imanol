import 'package:flutter/material.dart';

class Custombutton {
  
  static final ButtonStyle blueButtton = ButtonStyle(
    backgroundColor: const MaterialStatePropertyAll(Colors.blueAccent),
    foregroundColor: const MaterialStatePropertyAll (Colors.white),
    minimumSize: const MaterialStatePropertyAll (Size(20,10)),
  );

  static const ButtonStyle botonPorDefecto = ButtonStyle(
    backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 255, 255, 255)),
    fixedSize: MaterialStatePropertyAll(Size(140,50)),
    textStyle: MaterialStatePropertyAll(TextStyle(color: Color.fromARGB(255, 255, 255, 255),fontSize: 13)),
    side: MaterialStatePropertyAll (BorderSide(width: 1,color: Color.fromARGB(255, 90, 162, 218))),
    shadowColor: MaterialStatePropertyAll(Color.fromARGB(255, 240, 234, 234)),
    overlayColor: MaterialStatePropertyAll(Color.fromARGB(255, 11, 144, 247))
  );
}