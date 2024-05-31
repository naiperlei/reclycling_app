import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Color? home_color = Colors.purple[300];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: home_color,
        title: const Text(
            'Recycle Me',
        ),
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
                  color: home_color,
                ),
              child: const Text(
                'Menu',
                style: TextStyle(fontSize: 17.0, color: Colors.white),
              ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                color: Colors.blue[200],
              ),
              title: const Text(
                'Home',
                style: TextStyle(fontSize: 17.0, color: Colors.blueAccent),
              ),
              onTap: () {
              Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.camera_alt,
              ),
              title: const Text(
                'Camera',
                style: TextStyle(fontSize: 17.0, color: Colors.grey),
              ),
              onTap: () {
                // Update the state of the app
                Navigator.pushNamed(context, '/camera');
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.location_on,
              ),
              title: const Text(
                'Map',
                style: TextStyle(fontSize: 17.0, color: Colors.grey),
              ),
              onTap: () {
                // Update the state of the app
                Navigator.pushNamed(context, '/loading');
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.help_rounded,
              ),
              title: const Text(
                'Help',
                style: TextStyle(fontSize: 17.0, color: Colors.grey),
              ),
              onTap: () {
                // Update the state of the app
                Navigator.pushNamed(context, '/help');
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.settings,
              ),
              title: const Text(
                'Settings',
                style: TextStyle(fontSize: 17.0, color: Colors.grey),
              ),
              onTap: () {
                // Update the state of the app
                Navigator.pushNamed(context, '/settings');
              },
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(height: 5.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(width: 5.0),
              TextButton(
                onPressed: (){
                  // Update the state of the app
                  Navigator.pushNamed(context, '/camera');
                },
                child: Icon(
                  size: 100.0,
                  Icons.camera_alt,
                  color: home_color,
                ),),
              const SizedBox(width: 5.0),
              TextButton(
                  onPressed: (){
                    // Update the state of the app
                    Navigator.pushNamed(context, '/loading');
                  },
                  child: Icon(
                    size: 100.0,
                    Icons.location_on,
                    color: home_color,
                  )),
              const SizedBox(width: 5.0),
            ],
          ),
          //SizedBox(height: 1.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //SizedBox(width: 5.0),
              TextButton(
                  onPressed: (){
                    // Update the state of the app
                    Navigator.pushNamed(context, '/help');
                  },
                  child: Icon(
                    size: 100.0,
                    Icons.help_rounded,
                    color: home_color,
                  )),
              //SizedBox(width: 5.0),
              TextButton(
                  onPressed: (){
                    // Update the state of the app
                    Navigator.pushNamed(context, '/settings');
                  },
                  child: Icon(
                    size:100.0,
                    Icons.settings,
                    color: home_color,
                  )),
              //SizedBox(width: 5.0),
            ],
          ),
          const SizedBox(height:5.0),
        ],
      ),
    );
  }
}

