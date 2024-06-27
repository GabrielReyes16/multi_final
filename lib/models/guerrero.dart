class Guerrero {
  String id;
  String nombre;
  int nivelPoder;
  bool estado;
  DateTime fechaRegistro;

  Guerrero({
    required this.id,
    required this.nombre,
    required this.nivelPoder,
    required this.estado,
    required this.fechaRegistro,
  });

  factory Guerrero.fromJson(Map<String, dynamic> json) {
    return Guerrero(
      id: json['_id'],
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
