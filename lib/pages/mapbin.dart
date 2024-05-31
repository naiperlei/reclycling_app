import 'dart:convert';
import 'dart:io' as io;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';

class MapBin extends StatefulWidget {
  const MapBin({super.key});

  @override
  State<MapBin> createState() => _MapBinState();
}

class CONTENEDOR {
  int? objectid;
  String? empresa;
  int? codvia;
  int? numportal;
  String? ubicacion;
  String? tipo_resid;
  String? tipo_carga;
  String? modelo;
  String? productor;
  String? fecha_carga_sistema;
  Map? geo_shape;
  Map? geo_point_2d;

  //{ } - implies named arguments
  CONTENEDOR(
      {this.objectid,
      this.empresa,
      this.codvia,
      this.numportal,
      this.ubicacion,
      this.tipo_resid,
      this.tipo_carga,
      this.modelo,
      this.productor,
      this.fecha_carga_sistema,
      this.geo_shape,
      this.geo_point_2d});

  @override
  String toString() {
    return "{objectid:$objectid,empresa:$empresa,codvia:$codvia,numportal:$numportal,ubicacion:$ubicacion,tipo_resid:$tipo_resid,tipo_carga:$tipo_carga,modelo:$modelo,productor:$productor,fecha_carga_sistema:$fecha_carga_sistema,geo_shape:$geo_shape,geo_point_2d:$geo_point_2d}";
  }
}

class _MapBinState extends State<MapBin> {
  // GeoJsonParser myGeoJson = GeoJsonParser(
  //     defaultMarkerColor: Colors.red,
  //     defaultPolygonBorderColor: Colors.red,
  //     defaultPolygonFillColor: Colors.red.withOpacity(0.1));
  // bool loadingData = false;

  // bool myFilterFunction(Map<String, dynamic> properties) {
  //   if (properties['section'].toString().contains('Point M-4')) {
  //     return false;
  //   } else {
  //     return true;
  //   }
  // }

  // this is callback that gets executed when user taps the marker
  // void onTapMarkerFunction(Map<String, dynamic> map) {
  //   // ignore: avoid_print
  //   print('onTapMarkerFunction: $map');
  // }

  // Future<void> processData() async {
  //   // parse a small test geoJson
  //   // normally one would use http to access geojson on web and this is
  //   // the reason why this funcyion is async.
  //   final data = await rootBundle.loadString('/json/contenidors-residus-solids-contenidores-residuos-solidos.geojson');
  //   myGeoJson.parseGeoJsonAsString(data);
  // }

  @override
  void initState() {
    // var dir = Directory.current.path;
    // //String FILEPATH = "D:/Documentos/NAIARA\\ESTUDIO\\TFG\\Recycle_Me_This\\json\\";
    // JsonDecoder decoder = JsonDecoder();
    // // if (dir.endsWith('/json')) {
    // //   dir = dir.replaceAll('/json', '');
    // //}
    // List<CONTENEDOR>? conten;
    // var jsonString = io.File('json/contenidors-residus-solids-contenidores-residuos-solidos.json').readAsStringSync();
    // final Map<String, dynamic> jsonmap = decoder.convert(jsonString);
    // var value = jsonmap["contenedores"];
    // if (value != null) {
    //   conten = <CONTENEDOR>[];
    //   //Each item in value is of type::: _InternalLinkedHashMap<String, dynamic>
    //   value.forEach((item) => conten?.add(new CONTENEDOR(objectid:item["objectid"],empresa:item["empresa"],codvia:item["codvia"],numportal:item["numportal"],ubicacion:item["ubicacion"],tipo_resid:item["tipo_resid"],tipo_carga:item["tipo_carga"],modelo:item["modelo"],productor:item["productor"],fecha_carga_sistema:item["fecha_carga_sistema"],geo_shape:item["geo_shape"],geo_point_2d:item["geo_point_2d"] )));
    // }
    // conten?.forEach((element) => print(element));
    // myGeoJson.setDefaultMarkerTapCallback(onTapMarkerFunction);
    // myGeoJson.filterFunction = myFilterFunction;
    // loadingData = true;
    // Stopwatch stopwatch2 = Stopwatch()..start();
    // processData().then((_) {
    //   setState(() {
    //     loadingData = false;
    //   });
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text('GeoJson Processing time: ${stopwatch2.elapsed}'),
    //       duration: const Duration(milliseconds: 5000),
    //       behavior: SnackBarBehavior.floating,
    //       backgroundColor: Colors.green,
    //     ),
    //   );
    // });
  }

  List _items = [];
  var marker = <Marker>[];
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
        switch(actual["tipo_resid"]){
          case "Organico":
            color = Colors.brown;
            break;
          case "Papel / Carton":
            color = Colors.indigo[900];
            break;
          case "Envases Ligeros":
            color = Colors.yellow[400];
            break;
          case "VIDRIO":
            color = Colors.green[900];
            break;
          default:
            color = Colors.grey[800];
        }
        //print(actual["geo_point_2d"]["lat"]);
        if (actual["geo_point_2d"] != null) {
          marker.add(Marker(
              point: latLng.LatLng(
                  actual["geo_point_2d"]["lat"], actual["geo_point_2d"]["lon"]),
              builder: (context) => Icon(Icons.location_on, color: color)));
        }
      }
    });
  }

  latLng.LatLng? _currentPosition;
  bool _isLoading = true;
  getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    double lat = position.latitude;
    double long = position.longitude;

    latLng.LatLng location = latLng.LatLng(lat, long);

    setState(() {
      _currentPosition = location;
      _isLoading = false;
    });
  }

  Color? map_color = Colors.orangeAccent;
  // Map data = {};
  // var markerprob = <Marker>[
  //   Marker(
  //     point: latLng.LatLng(39.466667, -0.375000),
  //     builder: (context) => Icon(
  //       Icons.location_on,
  //       color: Colors.green,
  //     ),
  //   ),
  //   Marker(
  //     point: latLng.LatLng(39.47472, -0.350702),
  //     builder: (context) => Icon(
  //       Icons.location_on,
  //       color: Colors.blue,
  //     ),
  //   ),
  //   Marker(
  //     point: latLng.LatLng(39.4734, -0.3765),
  //     builder: (context) => Icon(
  //       Icons.location_on,
  //       color: Colors.red,
  //     ),
  //   )
  // ];

  // var marker = <Marker>[];
  // Future<Position> getPos() async {
  //   Position position = await Geolocator.getCurrentPosition();
  //   return position;
  // }

  // var  marker = <Marker>[
  //   Marker(
  //   point: latLng.LatLng(39.466667, -0.375000),
  //   builder: (context) => Icon(Icons.location_on, color: Colors.green,),
  //   ),
  //   Marker(
  //     point: latLng.LatLng(39.47472, -0.350702),
  //     builder: (context) => Icon(Icons.location_on, color: Colors.blue,),
  //   ),
  //   Marker(
  //     point: latLng.LatLng(39.4734, -0.3765),
  //     builder: (context) => Icon(Icons.location_on, color: Colors.red,),
  //   )
  // ];

  //late GoogleMapController mapController;

  //final latLng.LatLng _center = const latLng.LatLng(45.521563, -122.677433);
  //
  // void _onMapCreated(GoogleMapController controller) {
  //   mapController = controller;
  // }
  @override
  Widget build(BuildContext context) {
    // if (ModalRoute.of(context)?.settings.arguments != null) {
    //   data = data.isNotEmpty
    //       ? data
    //       : ModalRoute.of(context)?.settings.arguments as Map;
    // }
    // if (data.isNotEmpty) {
    //   List<Marker> marker = data['markers'];
    // }
    //readJson();
    // getLocation();
    // print(_currentPosition);
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
              leading: Icon(Icons.search),
              title: const Text(
                'Search Items',
                style: TextStyle(fontSize: 17.0, color: Colors.grey),
              ),
              onTap: () {
                // Update the state of the app
                Navigator.pushReplacementNamed(context, '/search');
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
      body: FlutterMap(
        options: MapOptions(
          center: latLng.LatLng(51.509364, -0.128928),
          zoom: 20,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.recycle_me_this',
          ),
          // CurrentLocationLayer(
          //   followOnLocationUpdate: FollowOnLocationUpdate.always,
          // ),

          // //userAgentPackageName: 'dev.fleaflet.flutter_map.example',
          // loadingData
          //     ? const Center(child: CircularProgressIndicator())
          //     : MarkerLayer(markers: myGeoJson.markers),
          // if (!loadingData) PolylineLayer(polylines: myGeoJson.polylines),
          // if (!loadingData) PolygonLayer(
          //   polygons: myGeoJson.polygons,
          // ),
          //MarkerLayer(
          //  markers: marker, //marker para los contenedores
          //),
        ],
      ),
    );
  }
}
