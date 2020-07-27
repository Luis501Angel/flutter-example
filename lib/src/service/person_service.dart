import 'package:empresauv/src/model/person.dart';
import 'package:http/http.dart' show Client;

class PersonaService {
  final String baseUrl = "http://52.184.149.120:8095";
  Client client = Client();

  Future<List<Persona>> getPersons() async {
    final response = await client.get("$baseUrl/api/personas/");
    if (response.statusCode == 200) {
      return profileFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<bool> createPerson(Persona data) async {
    final response = await client.post(
      "$baseUrl/api/personas/",
      headers: {"content-type": "application/json"},
      body: profileToJson(data),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updatePersona(Persona data) async {
    final response = await client.put(
      "$baseUrl/api/personas/",
      headers: {"content-type": "application/json"},
      body: profileToJson(data),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deletePersona(String id) async {
    final response = await client.delete(
      "$baseUrl/api/personas/$id",
      headers: {"content-type": "application/json"},
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
