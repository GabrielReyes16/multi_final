import 'package:flutter/material.dart';
import 'screens/guerreros_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Guerreros',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GuerrerosScreen(), // Cambiado de GuerrerossScreen a GuerrerosScreen
    );
  }
}
