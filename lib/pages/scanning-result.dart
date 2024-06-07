import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';

class ScanningResult extends StatefulWidget {
  const ScanningResult({super.key});

  @override
  State<ScanningResult> createState() => _ScanningResultState();
}

class _ScanningResultState extends State<ScanningResult> {
  Color? camera_color = Colors.blue[200];

  List _items = [];
  List _vidrio = [];
  var plasticMarkers = <Marker>[];
  var paperMarkers = <Marker>[];
  var glassMarkers = <Marker>[];
  var trashMarkers = <Marker>[];
  Future<void> readJsonVidrio() async {
    final String response = await rootBundle.loadString(
        'json/contenidors-vidre-contenedores-vidrio.json');
    final data = await json.decode(response);
    setState(() {
      _vidrio=data;
      for(int i = 0; i<_vidrio.length;i++){
        var actual = _vidrio[i];
        if(actual["geo_point_2d"] != null){
          glassMarkers.add(Marker(
              point: LatLng(
                  actual["geo_point_2d"]["lat"], actual["geo_point_2d"]["lon"]),
              builder: (context) =>
                  Icon(Icons.location_on, color: Colors.green[900])));
        }
      }
    });
  }
  Future<void> readJson() async {
    final String response = await rootBundle.loadString(
        'json/contenidors-residus-solids-contenidores-residuos-solidos.json');
    final data = await json.decode(response);
    setState(() {
      _items = data["contenedores"];
      // print(
      //     '..number of containers${_items.length} and ${_items[23]["geo_point_2d"]["lat"]}');
      for (int i = 0; i < _items.length; i++) {
        var actual = _items[i];
        Color? color = Colors.grey[800];
        if(actual["geo_point_2d"] != null){
          switch (actual["tipo_resid"]) {
            case "Papel / Carton":
              color = Colors.indigo[900];
              paperMarkers.add(Marker(
                  point: LatLng(
                      actual["geo_point_2d"]["lat"], actual["geo_point_2d"]["lon"]),
                  builder: (context) => Icon(Icons.location_on, color: color)));
              break;
            case "Envases Ligeros":
              color = Colors.yellow[400];
              plasticMarkers.add(Marker(
                  point: LatLng(
                      actual["geo_point_2d"]["lat"], actual["geo_point_2d"]["lon"]),
                  builder: (context) => Icon(Icons.location_on, color: color)));
              break;
            case "VIDRIO":
              color = Colors.green[900];
              glassMarkers.add(Marker(
                  point: LatLng(
                      actual["geo_point_2d"]["lat"], actual["geo_point_2d"]["lon"]),
                  builder: (context) => Icon(Icons.location_on, color: color)));
              break;
            default:
              color = Colors.grey[800];
              trashMarkers.add(Marker(
                  point: LatLng(
                      actual["geo_point_2d"]["lat"], actual["geo_point_2d"]["lon"]),
                  builder: (context) => Icon(Icons.location_on, color: color)));
          }
        }
      }
    });
  }
  @override
  void initState() {
    readJson();
    readJsonVidrio();
  }
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    print(args.values.first);

    var imagen_contenedores = ['plastic-bin','trash-bin','glass-bin','download'];
    var type_containers = ['Yellow','Gray','Green','Blue'];
    var waste_type = ['cardboard', 'glass', 'metal', 'paper', 'plastic', 'trash'];
    var tipo = waste_type[int.parse(args.values.first.toString().replaceAll(new RegExp(r'[^\w\s]+'),''))];
    var img_cont = imagen_contenedores[0];
    var type_cont = type_containers[0];
    switch(tipo){
      case 'paper':
      case 'cardboard':
        img_cont = imagen_contenedores[3];
        type_cont = type_containers[3];
        break;
      case 'glass':
        img_cont = imagen_contenedores[2];
        type_cont = type_containers[2];
        break;
      case 'plastic':
      case 'metal':
        break;
      case 'trash':
        img_cont = imagen_contenedores[1];
        type_cont = type_containers[1];
    }
    List<Marker> getMarkersForCategory() {
      switch (tipo) {
        case 'plastic':
        case 'metal':
          return plasticMarkers;
        case 'paper':
        case 'cardboard':
          return paperMarkers;
        case 'glass':
          return glassMarkers;
        case 'trash':
          return trashMarkers;
        default:
          return [];
      }
    }
    int n = 0;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: camera_color,
        title: Text('Classification'),
      ),
      backgroundColor: Colors.grey[100],
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 90.0,
              child: DrawerHeader(
                padding: EdgeInsets.symmetric(vertical: 17.0, horizontal: 12.0),
                decoration: BoxDecoration(
                  color: camera_color,
                ),
                child: Text(
                  'Menu',
                  style: TextStyle(fontSize: 17.0, color: Colors.white),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: const Text(
                'Home',
                style: TextStyle(fontSize: 17.0, color: Colors.grey),
              ),
              onTap: () {
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.camera_alt,
              ),
              title: const Text(
                'Camera',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 17.0,
                ),
              ),
              onTap: () {
                // Update the state of the app
                Navigator.pushReplacementNamed(context, '/camera');
              },
            ),
            ListTile(
              leading: Icon(
                Icons.location_on,
                color: Colors.grey,
              ),
              title: const Text(
                'Map',
                style: TextStyle(fontSize: 17.0, color: Colors.grey),
              ),
              onTap: () {
                // Update the state of the app
                Navigator.pushReplacementNamed(context, '/loading');
              },
            ),
            ListTile(
              leading: Icon(Icons.help_rounded),
              title: const Text(
                'Help',
                style: TextStyle(fontSize: 17.0, color: Colors.grey),
              ),
              onTap: () {
                // Update the state of the app
                Navigator.pushReplacementNamed(context, '/help');
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: const Text(
                'Settings',
                style: TextStyle(fontSize: 17.0, color: Colors.grey),
              ),
              onTap: () {
                // Update the state of the app
                Navigator.pushReplacementNamed(context, '/settings');
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 50),
          Text(
              'Result:',
              style: TextStyle(
                color: Colors.blue[200],
                fontSize: 28
              ),
          ),
          SizedBox(height:20),
          Text(
            'The waste is made from ${tipo}',
            style: TextStyle(
                color: Colors.grey,
                fontSize: 20
            ),
          ),
          SizedBox(height: 60),
          Text(
            'Container:',
            style: TextStyle(
                color: Colors.blue[200],
                fontSize: 28
            ),
          ),
          SizedBox(height:20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              Image.asset(
                'images/${img_cont}.png',
                height:50,
              ),
              SizedBox(
                width: 25,
              ),
              Text(
                  '${type_cont} container',
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                ),
              ),
            ],
          ),
          SizedBox(height: 70),
          SizedBox(
            height: 324,
            child: FlutterMap(
              options: MapOptions(
                center: const LatLng(51.509364, -0.128928),
                zoom: 16,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                ),
                CurrentLocationLayer(
                 followOnLocationUpdate: FollowOnLocationUpdate.always,
               ),
                MarkerLayer(
                  markers: getMarkersForCategory(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

