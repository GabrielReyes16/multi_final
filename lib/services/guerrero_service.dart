import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/guerrero.dart'; // Importa el modelo de guerrero

class GuerreroService {
  static const String apiUrl = 'https://tu-api-url'; // URL de tu API

  // Método para obtener todos los guerreros
  Future<List<Guerrero>> getGuerreros() async {
    final response = await http.get(Uri.parse('$apiUrl/guerreros'));
    if (response.statusCode == 200) {
      Iterable lista = json.decode(response.body);
      return lista.map((model) => Guerrero.fromJson(model)).toList();
    } else {
      throw Exception('Error al cargar guerreros');
    }
  }

  // Método para crear un guerrero
  Future<void> crearGuerrero(Guerrero guerrero) async {
    final response = await http.post(
      Uri.parse('$apiUrl/guerreros'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(guerrero.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Error al crear guerrero');
    }
  }

  // Método para actualizar un guerrero
  Future<void> actualizarGuerrero(int id, String nombre, int nivelPoder, bool estado, DateTime fechaRegistro) async {
    final response = await http.put(
      Uri.parse('$apiUrl/guerreros/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'nombre': nombre,
        'nivelPoder': nivelPoder,
        'estado': estado,
        'fechaRegistro': fechaRegistro.toIso8601String(),
      }),
    );
    if (response.statusCode != 200) {
      throw Exception('Error al actualizar guerrero');
    }
  }

  // Método para eliminar un guerrero
  Future<void> eliminarGuerrero(int id) async {
    final response = await http.delete(Uri.parse('$apiUrl/guerreros/$id'));
    if (response.statusCode != 200) {
      throw Exception('Error al eliminar guerrero');
    }
  }
}