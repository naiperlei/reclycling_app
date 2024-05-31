import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            'The waste is made from plastic',
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
                'images/plastic-bin.png',
                height:50,
              ),
              SizedBox(
                width: 25,
              ),
              Text(
                  'Yellow container',
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                ),
              ),
            ],
          ),
          SizedBox(height: 70),
          SizedBox(
            height: 350,
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}

