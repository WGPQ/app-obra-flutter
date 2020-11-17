import 'dart:ui' as ui;
import 'package:app_obra_flutter/model/obra.dart';
import 'package:app_obra_flutter/view/detallePage.dart';
import 'package:app_obra_flutter/view/homePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../services/FirebaseService.dart';

class MapaPage extends StatefulWidget {
  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  LocationData _currentPosition;
  var lng, lat, loading;
  bool sitiosToggle = false;
  _getLocation() async {
    var location = new Location();
    try {
      _currentPosition = await location.getLocation();
      setState(() {
        lat = _currentPosition.latitude;
        lng = _currentPosition.longitude;
        loading = true;
        print(_currentPosition);
      }); //rebuild the widget after getting the current location of the user
    } on Exception {
      _currentPosition = null;
    }
  }

  List<Obra> listobra = [];
  final _servicio = ObraService();
  GoogleMapController controller;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  BitmapDescriptor colormarker(Obra obra) {
    if (obra.marcador == 'azul.svg') {
      return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);
    } else if (obra.marcador == 'amarilla.svg') {
      return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow);
    } else if (obra.marcador == 'roja.svg') {
      return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
    } else if (obra.marcador == 'verde.svg') {
      return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
    }
  }

  void initMarker(Obra obra, String id) async {
    var markerIdVal = id;
    final MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker = Marker(
      markerId: markerId,
      icon: colormarker(obra),
      position: LatLng(obra.lat, obra.lon),
      infoWindow: InfoWindow(title: obra.nombre, snippet: obra.descripcion),
      onTap: () {
        Navigator.of(context)
            .push(new MaterialPageRoute<Null>(builder: (BuildContext context) {
          return Detalle(obra);
        }));
      },
    );
    setState(() {
      markers[markerId] = marker;
    });
  }

  @override
  void initState() {
    loading = false;
    getMarkerData();
    _getLocation();
    super.initState();
  }

  getMarkerData() async {
    final Firestore _db = Firestore.instance;
    final snapshot = await _db.collection('tblObra').getDocuments();
    listobra = snapshot.documents.map((item) => Obra.formMap(item)).toList();
    if (listobra.isNotEmpty) {
      for (int i = 0; i < listobra.length; i++) {
        initMarker(listobra[i], 'mark$i');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: loading
            ? GoogleMap(
                markers: Set<Marker>.of(markers.values),
                mapType: MapType.normal,
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                zoomGesturesEnabled: true,
                compassEnabled: true,
                scrollGesturesEnabled: true,
                rotateGesturesEnabled: true,
                tiltGesturesEnabled: true,
                initialCameraPosition:
                    CameraPosition(target: LatLng(lat, lng), zoom: 10.0),
                onMapCreated: (GoogleMapController controller) {
                  controller = controller;
                })
            : Container(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Cargando datos....",
                        style: TextStyle(fontSize: 20.0),
                      ),
                      CircularProgressIndicator(
                        backgroundColor: Colors.black,
                      ),
                    ],
                  ),
                ),
              ));
  }
}
