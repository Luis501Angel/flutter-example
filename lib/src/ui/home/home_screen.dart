import 'package:empresauv/src/service/person_service.dart';
import 'package:empresauv/src/ui/persona/person_add.dart';
import 'package:flutter/material.dart';
import 'package:empresauv/src/model/person.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BuildContext context;
  PersonaService personaService;

  @override
  void initState() {
    super.initState();
    personaService = PersonaService();
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return SafeArea(
      child: FutureBuilder(
        future: personaService.getPersons(),
        builder: (BuildContext context, AsyncSnapshot<List<Persona>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Ha ocurrido un error: ${snapshot.error.toString()}"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            List<Persona> personas = snapshot.data;
            return _buildListView(personas);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _buildListView(List<Persona> personas) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListView.builder(
        itemBuilder: (context, index) {
          Persona persona = personas[index];
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      persona.nombre,
                      style: Theme.of(context).textTheme.title,
                    ),
                    Text('Direccion: ' + persona.direccion),
                    Text('Telefono: ' + persona.telefono),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        FlatButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Alerta"),
                                    content: Text(
                                        "¿Está seguro de borrar: ${persona.nombre}?"),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text("Sí"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          personaService
                                              .deletePersona((persona.clave))
                                              .then((isSuccess) {
                                            if (isSuccess) {
                                              setState(() {});
                                              Scaffold.of(this.context)
                                                  .showSnackBar(SnackBar(
                                                      content: Text(
                                                          "Borrado con éxito")));
                                            } else {
                                              Scaffold.of(this.context)
                                                  .showSnackBar(SnackBar(
                                                      content: Text(
                                                          "Error al borrar")));
                                            }
                                          });
                                        },
                                      ),
                                      FlatButton(
                                        child: Text("No"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  );
                                });
                          },
                          child: Text(
                            "Elimnar",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        FlatButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return PersonAddScreen(persona: persona);
                            }));
                          },
                          child: Text(
                            "Editar",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: personas.length,
      ),
    );
  }
}
