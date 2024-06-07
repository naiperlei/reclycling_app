import 'dart:convert';
import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';

class Mapa_Prueba extends StatefulWidget {
  const Mapa_Prueba({super.key});

  @override
  State<Mapa_Prueba> createState() => _Mapa_PruebaState();
}

class _Mapa_PruebaState extends State<Mapa_Prueba> {
  Color? map_color = Colors.orangeAccent[100];

  List _items = [];
  List _vidrio = [];
  var plasticMarkers = <Marker>[];
  var paperMarkers = <Marker>[];
  var glassMarkers = <Marker>[];
  var trashMarkers = <Marker>[];
  var marker = <Marker>[];
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
            case "Organico":
              color = Colors.brown;
              marker.add(Marker(
                  point: LatLng(
                      actual["geo_point_2d"]["lat"], actual["geo_point_2d"]["lon"]),
                  builder: (context) => Icon(Icons.location_on, color: color)));
              break;
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
  int? clase=0;
  // Map of category names to their corresponding values
  List<String> categoryItems = ['Plastic', 'Paper', 'Glass','Organic', 'Trash'];
  @override
  void initState() {
    readJson();
    readJsonVidrio();
  }

  @override
  Widget build(BuildContext context) {
    List<Marker> getMarkersForCategory() {
      switch (clase) {
        case 0:
          return plasticMarkers;
        case 1:
          return paperMarkers;
        case 2:
          return glassMarkers;
        case 3:
          return marker;
        case 4:
          return trashMarkers;
        default:
          return [];
      }
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: map_color,
        title: Text('Map of Bins'),
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
                  color: map_color,
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
                color: Colors.blue[200],
              ),
              title: const Text(
                'Map',
                style: TextStyle(fontSize: 17.0, color: Colors.blueAccent),
              ),
              onTap: () {
                // Update the state of the app
                Navigator.pop(context);
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
            DropdownButton<int>(
              value: clase,
              onChanged: (int? newValue) {
                if (newValue != null) {
                  setState(() {
                    clase = newValue;
                  });
                }
              },
              items: List.generate(
                categoryItems.length,
                    (index) => DropdownMenuItem<int>(
                  value: index,
                  child: Text(categoryItems[index]),
                ),
              ),
            ),
            SizedBox(
              height: 650,
              child: FlutterMap(
                options: MapOptions(
                center: LatLng(39.4820, -0.3490),
                zoom: 18,
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
