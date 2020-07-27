import 'dart:convert';

class Persona {
  String clave;
  String nombre;
  String direccion;
  String telefono;

  Persona({this.clave, this.nombre, this.direccion, this.telefono});

  factory Persona.fromJson(Map<String, dynamic> map) {
    return Persona(
        clave: map["clave"], nombre: map["nombre"], direccion: map["direccion"], telefono: map["telefono"]);
  }

  Map<String, dynamic> toJson() {
    return {"clave": clave, "nombre": nombre, "direccion": direccion, "telefono": telefono};
  }

  @override
  String toString() {
    return 'Persona{id: $clave, nombre: $nombre, direccion: $direccion, telefono: $telefono}';
  }

}

List<Persona> profileFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<Persona>.from(data.map((item) => Persona.fromJson(item)));
}

String profileToJson(Persona data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}
