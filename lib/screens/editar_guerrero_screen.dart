import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Importa el formateador de fechas de intl
import '../models/guerrero.dart'; // Importa el modelo de guerrero
import '../services/guerrero_service.dart'; // Importa el servicio de guerrero

class EditarGuerreroScreen extends StatefulWidget {
  final Guerrero guerrero;

  EditarGuerreroScreen({Key? key, required this.guerrero}) : super(key: key);

  @override
  _EditarGuerreroScreenState createState() => _EditarGuerreroScreenState();
}

class _EditarGuerreroScreenState extends State<EditarGuerreroScreen> {
  TextEditingController nombreController = TextEditingController();
  TextEditingController nivelPoderController = TextEditingController();
  bool estado = true; // Estado por defecto
  DateTime fechaRegistro = DateTime.now(); // Fecha por defecto
  GuerreroService guerreroService = GuerreroService();

  @override
  void initState() {
    super.initState();
    nombreController.text = widget.guerrero.nombre;
    nivelPoderController.text = widget.guerrero.nivelPoder.toString();
    estado = widget.guerrero.estado;
    fechaRegistro = widget.guerrero.fechaRegistro;
  }

  Future<void> _actualizarGuerrero() async {
    try {
      await guerreroService.actualizarGuerrero(
        widget.guerrero.id,
        nombreController.text,
        int.parse(nivelPoderController.text),
        estado,
        fechaRegistro,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Guerrero actualizado')),
      );
    } catch (e) {
      print('Error al actualizar guerrero: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Guerrero'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              _actualizarGuerrero();
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nombreController,
              decoration: InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: nivelPoderController,
              decoration: InputDecoration(labelText: 'Nivel de Poder'),
              keyboardType: TextInputType.number,
            ),
            CheckboxListTile(
              title: Text('Estado'),
              value: estado,
              onChanged: (newValue) {
                setState(() {
                  estado = newValue!;
                });
              },
            ),
            Text('Fecha de Registro: ${DateFormat('dd/MM/yyyy').format(fechaRegistro)}'), // Uso correcto de DateFormat
          ],
        ),
      ),
    );
  }
}
