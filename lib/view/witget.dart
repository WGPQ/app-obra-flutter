import 'package:app_obra_flutter/model/obra.dart';
import 'package:app_obra_flutter/view/detallePage.dart';
import 'package:app_obra_flutter/view/homePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FlexibleAppBar extends SliverAppBar {
  static const double height = 256.0;

  FlexibleAppBar(String title, String image)
      : super(
            pinned: true,
            expandedHeight: height,
            flexibleSpace: FlexibleSpaceBar(
                title: Text(title), background: _buildBackground(image)));

  static Widget _buildBackground(String image) {
    return Stack(fit: StackFit.expand, children: <Widget>[
      //Image.network(imageUrl, fit: BoxFit.cover, height: height),
      SvgPicture.asset(
        "assets/images/$image",
        height: height,
        fit: BoxFit.cover,
      ),
      DecoratedBox(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: FractionalOffset(0.5, 0.6),
                  end: FractionalOffset(0.5, 1.0),
                  colors: <Color>[Color(0x00000000), Color(0x70000000)])))
    ]);
  }
}

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final drawerItems = ListView(
      children: <Widget>[
        Divider(
          height: 25.0,
        ),
        ListTile(
          title: Text(
            "INICIO",
            style: TextStyle(fontSize: 25.0),
          ),
          // selected: (0 == _selectPage),
          selected: (true),
          leading: Icon(
            Icons.home,
            size: 35.0,
          ),
          onTap: () {
            //_pasr._selectPage2.value = 0;
            Navigator.of(context).pop();
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (cont) => HomePage()));
          },
        ),
      ],
    );

    return Drawer(
      child: drawerItems,
    );
  }
}
