import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:workmanager/workmanager.dart';
import 'package:http/http.dart' as http;

class Camera extends StatefulWidget {
  const Camera({super.key});

  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState  extends State<Camera> {
//   // Obtén una lista de las cámaras disponibles en el dispositivo.
//   final cameras = await availableCameras();
//
// // Obtén una cámara específica de la lista de cámaras disponibles
//   final firstCamera = cameras.first;
  File? _image;
  Future<void> _optionsDialogBox(){
    return showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    child: Text('Take picture'),
                    onTap: () {
                      _getImage(ImageSource.camera);
                      Navigator.pop(context);
                    },
                  ),
                  Padding(padding: EdgeInsets.all(8.0)),
                  GestureDetector(
                    child: Text('Choose from gallery'),
                    onTap: ()  {
                      _getImage(ImageSource.gallery);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

  Future _getImage(ImageSource source) async{
    final image = await ImagePicker().pickImage(
        source: source,
    );
    if(image == null) return ;
    final imageTemporary = File(image.path);

    setState(() {
      this._image = imageTemporary;
    });
  }

  Future<Map<String, dynamic>> _classifyImage(File image) async {
    final url = Uri.parse('http://10.0.2.2:8000/predict');
    final request = http.MultipartRequest('POST', url);
    request.files.add(
      http.MultipartFile(
        'file',
        image.readAsBytes().asStream(),
        image.lengthSync(),
        filename: image.path.split('/').last,
      ),
    );

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      final Map<String, dynamic> responseData = json.decode(response.body);
      return responseData;
    } catch (e) {
      throw Exception('Failed to classify image: $e');
    }
  }

  void _openCamera() async{
    var picture = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
  }

  Color? camera_color = Colors.blue[200];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: camera_color,
        title: Text('Camera'),
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
                color: Colors.blue[200],
              ),
              title: const Text(
                'Camera',
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 17.0,
                ),
              ),
              onTap: () {
                // Update the state of the app
                Navigator.pop(context);
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
      body: Center(
        child: Column(
          children: [
            _image != null ? Image.file(_image!, width: 413, height: 400, fit: BoxFit.cover,) : Image.asset('images/no-image.jpg'),
            SizedBox(height: 20.0,),
            ElevatedButton(
              onPressed: ()async {
                try {
                  if (_image == null) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Please select an image.'),
                    ));
                    return;
                  }
                  final responseData = await _classifyImage(_image!);
                  Navigator.pushReplacementNamed(
                    context,
                    '/scanning-result',
                    arguments: responseData,
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Error: $e'),
                  ));
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue[300]),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(33.0, 8.0, 33.0, 8.0),
                child: Text('Classify'),
              ),
            ),
            SizedBox(height: 20.0,),
            ElevatedButton(
              onPressed: _optionsDialogBox,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue[300]),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(3.0,8.0,3.0,8.0),
                child: Text('Choose new photo'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
