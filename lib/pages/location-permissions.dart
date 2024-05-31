import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'dart:convert';

import 'package:recycle_me_this/blocs/blocs.dart';

class LocationPermissionPage extends StatefulWidget {
  const LocationPermissionPage({super.key});

  @override
  State<LocationPermissionPage> createState() => _LocationPermissionState();
}

class _LocationPermissionState extends State<LocationPermissionPage> {

  String? _currentAddress;
  Position? _currentPosition;
  PermissionStatus? _status;

  void initState(){
    super.initState();
    //PermissionHandler().checkPermissionStatus(PermissionGroup.locationWhenInUse);
  }
  var  marker = <Marker>[
    Marker(
      point: latLng.LatLng(39.466667, -0.375000),
      builder: (context) => Icon(Icons.location_on, color: Colors.green,),
    ),
    Marker(
      point: latLng.LatLng(39.47472, -0.350702),
      builder: (context) => Icon(Icons.location_on, color: Colors.blue,),
    ),
    Marker(
      point: latLng.LatLng(39.4734, -0.3765),
      builder: (context) => Icon(Icons.location_on, color: Colors.red,),
    )
  ];
  List _items = [];
  Future<void> readJson() async{
    final String response = await rootBundle.loadString('json/contenidors-residus-solids-contenidores-residuos-solidos.json');
    final data = await json.decode(response);
    setState(() {
      _items = data["contenedores"];
      print('..number of containers${_items.length} and ${_items[23]["geo_point_2d"]["lat"]}');
      for(int i = 0; i<_items.length; i++){
        var actual = _items[i];
        Color? color = Colors.grey[800];
        // switch(actual["tipo_resid"]){
        //   case "Organico":
        //     color = Colors.brown;
        //   case "Papel / Carton":
        //     color = Colors.indigo[900];
        //   case "Envases Ligeros":
        //     color = Colors.yellow[400];
        //   case "VIDRIO":
        //     color = Colors.green[900];
        //   default:
        //     color = Colors.grey[800];
        // }
        //print(actual["geo_point_2d"]["lat"]);
        if(actual["geo_point_2d"] != null) {
          marker.add(Marker(
              point: latLng.LatLng(
                  actual["geo_point_2d"]["lat"], actual["geo_point_2d"]["lon"]),
              builder: (context) => Icon(Icons.location_on, color: color)));
        }
      }
      Navigator.pushReplacementNamed(context, '/map',arguments: {
        "markers": marker
      });
    });
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> requestPermission() async{
    final permission = Permission.location;

    if(await permission.isDenied){
      await permission.request();
    }
  }

  Future<bool> checkPermissionStatus() async {
    final permission = Permission.location;

    return await permission.status.isGranted;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Location Page")),
      body: SafeArea(
        child: Center(
          child: BlocBuilder<GpsBloc, GpsState>(
            builder: (context, state) {
              return !state.isGpsEnabled
              ? const _EnableGpsMessage()
              : const _AccessButton();
            },
          )
          //_AccessButton(),
        ),
      ),
    );
  }
}

class _AccessButton extends StatelessWidget{
  const _AccessButton({
    Key? key,
  }): super(key: key);

  @override
  Widget build(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Es necesario acceso al GPS'),
        MaterialButton(
          child: const Text('Solicitar Acceso', style: TextStyle(color: Colors.white),),
          color: Colors.black,
          shape: const StadiumBorder(),
          elevation: 0,
          splashColor: Colors.transparent,
          onPressed: (){
            final gpsBloc = BlocProvider.of<GpsBloc>(context);
            gpsBloc.askGpsAccess();
          },
        ),
      ],
    );
  }
}

class _EnableGpsMessage extends StatelessWidget{
  const _EnableGpsMessage({
    Key? key,
  }): super(key: key);

  @override
  Widget build(BuildContext context){
    return const Text(
      'Debe habilitar la ubicación',
      style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
    );
  }
}

// Column(
//   mainAxisAlignment: MainAxisAlignment.center,
//   children: [
//     Text('$_status'),
//     Text('LAT: ${_currentPosition?.latitude ?? ""}'),
//     Text('LNG: ${_currentPosition?.longitude ?? ""}'),
//     Text('ADDRESS: ${_currentAddress ?? ""}'),
//     const SizedBox(height: 32),
//     ElevatedButton(
//       onPressed: _getCurrentPosition,
//       child: const Text("Get Current Location"),
//     ),
//     ElevatedButton(
//       onPressed: readJson,
//       child: Center(
//       child: Text("Load Json"),
//       ),
//     ),
//   ],
// )
