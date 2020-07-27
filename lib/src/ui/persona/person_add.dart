import 'package:empresauv/src/model/person.dart';
import 'package:empresauv/src/service/person_service.dart';
import 'package:flutter/material.dart';

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class PersonAddScreen extends StatefulWidget {
  Persona persona;

  PersonAddScreen({this.persona});

  @override
  _PersonAddScreenState createState() => _PersonAddScreenState();
}

class _PersonAddScreenState extends State<PersonAddScreen> {
  bool _isLoading = false;
  PersonaService _personService = PersonaService();
  bool _isFieldClaveValid;
  bool _isFieldNombreValid;
  bool _isFieldDireccionValid;
  bool _isFieldTelefonoValid;
  TextEditingController _controllerClave = TextEditingController();
  TextEditingController _controllerNombre = TextEditingController();
  TextEditingController _controllerDireccion = TextEditingController();
  TextEditingController _controllerTelefono = TextEditingController();

  @override
  void initState() {
    if (widget.persona != null) {
      _isFieldClaveValid = true;
      _controllerClave.text = widget.persona.clave;
      _isFieldNombreValid = true;
      _controllerNombre.text = widget.persona.nombre;
      _isFieldDireccionValid = true;
      _controllerDireccion.text = widget.persona.direccion;
      _isFieldTelefonoValid = true;
      _controllerTelefono.text = widget.persona.telefono;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          widget.persona == null ? "Agregar persona" : "Actualizar datos",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildTextFieldClave(),
                _buildTextFieldNombre(),
                _buildTextFieldDireccion(),
                _buildTextFieldTelefono(),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: RaisedButton(
                    child: Text(
                      widget.persona == null
                          ? "Guardar".toUpperCase()
                          : "Actualizar".toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      if (_isFieldNombreValid == null ||
                          _isFieldDireccionValid == null ||
                          _isFieldTelefonoValid == null ||
                          !_isFieldNombreValid ||
                          !_isFieldDireccionValid ||
                          !_isFieldTelefonoValid) {
                        _scaffoldState.currentState.showSnackBar(
                          SnackBar(
                            content: Text("Por favor rellene todos lo campos"),
                          ),
                        );
                        return;
                      }
                      setState(() => _isLoading = true);
                      String clave = _controllerClave.text.toString();
                      String nombre = _controllerNombre.text.toString();
                      String direccion = _controllerDireccion.text.toString();
                      String telefono = _controllerTelefono.text.toString();
                      Persona persona = Persona(
                          clave: clave,
                          nombre: nombre,
                          direccion: direccion,
                          telefono: telefono);
                      if (widget.persona == null) {
                        _personService.createPerson(persona).then((isSuccess) {
                          setState(() => _isLoading = false);
                          if (isSuccess) {
                            Navigator.pop(_scaffoldState.currentState.context);
                          } else {
                            _scaffoldState.currentState.showSnackBar(SnackBar(
                              content: Text("Error al guardar"),
                            ));
                          }
                        });
                      } else {
                        persona.clave = widget.persona.clave;
                        _personService.updatePersona(persona).then((isSuccess) {
                          setState(() => _isLoading = false);
                          if (isSuccess) {
                            Navigator.pop(_scaffoldState.currentState.context);
                          } else {
                            _scaffoldState.currentState.showSnackBar(SnackBar(
                              content: Text("Error al actulizar!"),
                            ));
                          }
                        });
                      }
                    },
                    color: Colors.green,
                  ),
                )
              ],
            ),
          ),
          _isLoading
              ? Stack(
                  children: <Widget>[
                    Opacity(
                      opacity: 0.3,
                      child: ModalBarrier(
                        dismissible: false,
                        color: Colors.grey,
                      ),
                    ),
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }

  Widget _buildTextFieldClave() {
    return TextField(
      controller: _controllerClave,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Clave",
        errorText: _isFieldClaveValid == null || _isFieldClaveValid
            ? null
            : "Clave es requerida",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldClaveValid) {
          setState(() => _isFieldClaveValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldNombre() {
    return TextField(
      controller: _controllerNombre,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Nombre",
        errorText: _isFieldNombreValid == null || _isFieldNombreValid
            ? null
            : "Nombre es requerido",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldNombreValid) {
          setState(() => _isFieldNombreValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldDireccion() {
    return TextField(
      controller: _controllerDireccion,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Direccion",
        errorText: _isFieldDireccionValid == null || _isFieldDireccionValid
            ? null
            : "Direccion es requerida",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldDireccionValid) {
          setState(() => _isFieldDireccionValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldTelefono() {
    return TextField(
      controller: _controllerTelefono,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Telefono",
        errorText: _isFieldTelefonoValid == null || _isFieldTelefonoValid
            ? null
            : "Telefono es requerido",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldTelefonoValid) {
          setState(() => _isFieldTelefonoValid = isFieldValid);
        }
      },
    );
  }
}
