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
  bool _esNuevo = false; // Determina si es nuevo registro

  @override
  void initState() {
    super.initState();
    // Verifica si es nuevo o existente
    _esNuevo = widget.guerrero.id.isEmpty;
    // Configura los controladores y estado inicial
    if (!_esNuevo) {
      nombreController.text = widget.guerrero.nombre;
      nivelPoderController.text = widget.guerrero.nivelPoder.toString();
      estado = widget.guerrero.estado;
      fechaRegistro = widget.guerrero.fechaRegistro;
    }
  }

  Future<void> _guardarGuerrero() async {
    try {
      if (_esNuevo) {
        // Si es nuevo, crea un nuevo guerrero
        await guerreroService.crearGuerrero(Guerrero(
          nombre: nombreController.text,
          nivelPoder: int.parse(nivelPoderController.text),
          estado: estado,
          fechaRegistro: fechaRegistro, id: '',
        ));
      } else {
        // Si no es nuevo, actualiza el guerrero existente
        await guerreroService.actualizarGuerrero(
          widget.guerrero.id,
          nombreController.text,
          int.parse(nivelPoderController.text),
          estado,
          fechaRegistro,
        );
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Guerrero ${_esNuevo ? 'creado' : 'actualizado'}')),
      );
    } catch (e) {
      print('Error al ${_esNuevo ? 'crear' : 'actualizar'} guerrero: $e');
    }
  }

  Future<void> _eliminarGuerrero() async {
    try {
      await guerreroService.eliminarGuerrero(widget.guerrero.id);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Guerrero eliminado')),
      );
      Navigator.pop(context, true); // Regresa a la pantalla anterior con éxito
    } catch (e) {
      print('Error al eliminar guerrero: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_esNuevo ? 'Crear Guerrero' : 'Editar Guerrero'),
        actions: [
          if (!_esNuevo)
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Eliminar Guerrero'),
                    content: Text('¿Estás seguro de eliminar este guerrero?'),
                    actions: [
                      TextButton(
                        child: Text('Cancelar'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text('Eliminar'),
                        onPressed: () {
                          Navigator.of(context).pop();
                          _eliminarGuerrero();
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              _guardarGuerrero();
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
            Text('Fecha de Registro: ${DateFormat('dd/MM/yyyy').format(fechaRegistro)}'),
          ],
        ),
      ),
    );
  }
}
