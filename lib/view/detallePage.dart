import 'package:app_obra_flutter/model/obra.dart';
import 'package:app_obra_flutter/view/witget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Detalle extends StatelessWidget {
  final Obra obra;
  Detalle(this.obra);
  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(
            brightness: Brightness.light, primarySwatch: Colors.blueGrey),
        child: Scaffold(
          drawer: MainDrawer(),
          body: CustomScrollView(
            slivers: [
              FlexibleAppBar(obra.nombre, obra.marcador),
              SliverList(
                  delegate: SliverChildListDelegate(<_ContactCategory>[
                _buildCategory(Icons.location_on, null, <String>[
                  "Coordenadas \n" + "Lat: ${obra.lat.toString()}",
                  "Lng: ${obra.lon.toString()}"
                ]),
                _buildCategory(Icons.list, null,
                    <String>["Descripción: \n ${obra.descripcion.toString()}"]),
                _buildCategory(Icons.date_range, null, <String>[
                  "Fecha \n" + "Inicio: ${obra.fecha_ini.toString()}",
                  "Fin: ${obra.fecha_fin.toString()}"
                ]),
                _buildCategory(Icons.description, null,
                    <String>["Otros Datos:\n ${obra.otroDato}"]),
              ]))
            ],
          ),
        ));
  }
}

_ContactCategory _buildCategory(
    IconData categoryIcon, IconData categoryItemIcon, List<String> lines) {
  return new _ContactCategory(
      icon: categoryIcon,
      children: <_ContactCategoryItem>[
        new _ContactCategoryItem(icon: categoryItemIcon, lines: lines)
      ]);
}

///
/// CONTACT CATEGORY
///
class _ContactCategory extends StatelessWidget {
  final IconData icon;
  final List<_ContactCategoryItem> children;

  _ContactCategory({Key key, this.icon, this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return new Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        decoration: new BoxDecoration(
            border: new Border(
                bottom: new BorderSide(color: themeData.dividerColor))),
        child: new Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Container(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  width: 72.0,
                  child: new Icon(icon, color: themeData.primaryColor)),
              new Flexible(child: new Column(children: children)),
            ]));
  }
}

///
/// CONTACT CATEGORY ITEM
///

class _ContactCategoryItem extends StatelessWidget {
  final IconData icon;
  final List<String> lines;

  _ContactCategoryItem({Key key, @required this.icon, @required this.lines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _buildRow(context)));
  }

  List<Widget> _buildRow(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final List<Widget> firstColumn =
        lines.map((line) => new Text(line)).toList();

    return <Widget>[
      new Flexible(
          child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: firstColumn)),
      new SizedBox(
          width: 72.0,
          child: new IconButton(
              icon: new Icon(icon),
              color: themeData.primaryColor,
              onPressed: () => {}))
    ];
  }
}
