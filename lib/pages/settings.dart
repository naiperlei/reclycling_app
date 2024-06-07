import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:recycle_me_this/blocs/blocs.dart';
import 'package:permission_handler/permission_handler.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _LocationPermission();
}
bool storage_perm = false;
bool location_perm = false;
bool camera_perm = false;

Future<void> askGpsAccess() async {
  final status = await Permission.location.request();

  switch(status){
    case PermissionStatus.granted:
      location_perm=true;
      break;
    case PermissionStatus.denied:
    case PermissionStatus.limited:
    case PermissionStatus.restricted:
    case PermissionStatus.permanentlyDenied:
    case PermissionStatus.provisional:
      location_perm=false;
  }
}
Future<void> askCamAccess() async {
  final status = await Permission.camera.request();

  switch(status){
    case PermissionStatus.granted:
      camera_perm=true;
      break;
    case PermissionStatus.denied:
    case PermissionStatus.limited:
    case PermissionStatus.restricted:
    case PermissionStatus.permanentlyDenied:
    case PermissionStatus.provisional:
      camera_perm=false;
  }
}
Future<void> askStorageAccess() async {
  final status = await Permission.camera.request();

  switch(status){
    case PermissionStatus.granted:
      storage_perm=true;
      break;
    case PermissionStatus.denied:
    case PermissionStatus.limited:
    case PermissionStatus.restricted:
    case PermissionStatus.permanentlyDenied:
    case PermissionStatus.provisional:
      storage_perm=false;
  }
}
Future<bool> _isPermissionGranted() async{
  final isGranted = await Permission.location.isGranted;
  return isGranted;
}
class _LocationPermission extends State<Settings>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: BlocBuilder<GpsBloc, GpsState>(
              builder: (context, state) {
                location_perm = state.isGpsPermissionGranted;
                //askStorageAccess();
                //saskCamAccess();
                return SettingState();
              },
            )
          //_AccessButton(),
        ),
      ),
    );
  }
}
class SettingState extends StatefulWidget {
  const SettingState({super.key});

  @override
  State<SettingState> createState() => _SettingState();
}

class _SettingState extends State<SettingState> {
  Color? settings_color = Colors.grey[500];

  // Method to change location permission status
  Future<void> changeLocationPermissionStatus(bool value) async {
    if (value) {
      // If the switch is being turned on, request location permission
      final gpsBloc = BlocProvider.of<GpsBloc>(context);
      gpsBloc.askGpsAccess();
    } else {
      // If the switch is being turned off, open app settings
      openAppSettings();
      setState(() {
        askGpsAccess();
      });
    }
  }

  Future<void> changeCameraPermissionStatus(bool value) async {
    if (value) {
      // If the switch is being turned on, request location permission
      final status = await Permission.camera.request();
      setState(() {
        camera_perm = status == PermissionStatus.granted;
      });
    } else {
      // If the switch is being turned off, open app settings
      openAppSettings();
      setState(() {
        askCamAccess();
      });
    }
  }
  Future<void> changeStoragePermissionStatus(bool value) async {
    if (value) {
      // If the switch is being turned on, request location permission
      final status = await Permission.photos.request();
      setState(() {
        storage_perm = status == PermissionStatus.granted;
      });
    } else {
      // If the switch is being turned off, open app settings
      openAppSettings();
      setState(() {
        askStorageAccess();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //askGpsAccess();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: settings_color,
        title: Text('Settings'),
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
                  color: settings_color,
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
              leading: Icon(Icons.location_on),
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
              leading: Icon(
                Icons.settings,
                color: Colors.blue[200],
              ),
              title: const Text(
                'Settings',
                style: TextStyle(fontSize: 17.0, color: Colors.blueAccent),
              ),
              onTap: () {
                // Update the state of the app
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Location'),
              Switch(value: location_perm,
                onChanged: (bool value) {
                  changeLocationPermissionStatus(value);
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Camera'),
              Switch(value: camera_perm,
                onChanged: (bool value) {
                  // This is called when the user toggles the switch.
                  changeCameraPermissionStatus(value);
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Storage'),
              Switch(value: storage_perm,
                onChanged: (bool value) {
                  changeStoragePermissionStatus(value);
                },
              ),
            ],
          ),
        ],
      )
    );
  }
}
