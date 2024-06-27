import 'package:flutter/material.dart';
import 'editar_guerrero_screen.dart'; // Importa la pantalla de edición
import '../models/guerrero.dart'; // Importa el modelo de guerrero
import '../services/guerrero_service.dart'; // Importa el servicio de guerrero

class GuerrerosScreen extends StatefulWidget {
  @override
  _GuerrerosScreenState createState() => _GuerrerosScreenState();
}

class _GuerrerosScreenState extends State<GuerrerosScreen> {
  List<Guerrero> guerreros = [];
  GuerreroService guerreroService = GuerreroService();

  @override
  void initState() {
    super.initState();
    _cargarGuerreros();
  }

  Future<void> _cargarGuerreros() async {
    try {
      List<Guerrero> listaGuerreros = await guerreroService.getGuerreros();
      setState(() {
        guerreros = listaGuerreros;
      });
    } catch (e) {
      print('Error al cargar guerreros: $e');
    }
  }

  void _agregarGuerrero() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditarGuerreroScreen(guerrero: Guerrero(id: '', nombre: '', nivelPoder: 0, estado: false, fechaRegistro: DateTime.now())),
      ),
    ).then((value) {
      if (value != null && value) {
        _cargarGuerreros();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Guerreros'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: guerreros.length,
              itemBuilder: (context, index) {
                Guerrero guerrero = guerreros[index];
                return ListTile(
                  title: Text(guerrero.nombre),
                  subtitle: Text('Nivel de Poder: ${guerrero.nivelPoder.toString()}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditarGuerreroScreen(guerrero: guerrero),
                      ),
                    ).then((value) {
                      if (value != null && value) {
                        _cargarGuerreros();
                      }
                    });
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                _agregarGuerrero();
              },
              child: Text('Agregar Guerrero'),
            ),
          ),
        ],
      ),
    );
  }
}
