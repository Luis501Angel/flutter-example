import 'package:flutter/material.dart';
import 'package:empresauv/src/ui/persona/person_add.dart';
import 'package:empresauv/src/ui/home/home_screen.dart';

GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.blue,
          accentColor: Colors.green,
          canvasColor: Colors.white),
      home: Scaffold(
        key: _scaffoldState,
        appBar: AppBar(
          title: Center(
            child: Text(
              "Formulario",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          actions: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.push(
                  _scaffoldState.currentContext,
                  MaterialPageRoute(builder: (BuildContext context) {
                    return PersonAddScreen();
                  }),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        body: HomeScreen(),
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          child: Container(
            height: 50.0,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.push(
            _scaffoldState.currentContext,
            MaterialPageRoute(builder: (BuildContext context) {
              return PersonAddScreen();
            }),
          ),
          tooltip: 'Agregar persona',
          child: Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
