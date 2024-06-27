class Guerrero {
  final String id;
  final String nombre;
  final int nivelPoder;
  final bool estado;
  final DateTime fechaRegistro;

  Guerrero({
    required this.id,
    required this.nombre,
    required this.nivelPoder,
    required this.estado,
    required this.fechaRegistro,
  });

  factory Guerrero.fromJson(Map<String, dynamic> json) {
    return Guerrero(
      id: json['_id'], // Asegúrate de que el nombre del campo coincide con tu API
      nombre: json['nombre'],
      nivelPoder: json['nivelPoder'],
      estado: json['estado'],
      fechaRegistro: DateTime.parse(json['fechaRegistro']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'nivelPoder': nivelPoder,
      'estado': estado,
      'fechaRegistro': fechaRegistro.toIso8601String(),
    };
  }
}
