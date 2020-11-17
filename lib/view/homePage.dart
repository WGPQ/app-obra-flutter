import 'package:app_obra_flutter/model/obra.dart';
import 'package:app_obra_flutter/view/witget.dart';
import 'package:flutter/material.dart';
import './mapaPage.dart' as mapa;
import './detallePage.dart' as detalle;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Mapa de Obras"),
      ),
      drawer: MainDrawer(),
      body: mapa.MapaPage(),
    );
  }
}
