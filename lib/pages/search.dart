import 'package:flutter/material.dart';
import 'package:recycle_me_this/services/recycledObject.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  Color? search_color = Colors.lightGreen[300];
  List<recycledObject> objectImages = [
    recycledObject(name: 'paper', image: 'paper.png'),
    recycledObject(name: 'cardboard', image: 'cardboard.png'),
    recycledObject(name: 'glass', image: 'glass.png'),
    recycledObject(name: 'plastic', image: 'plastic.png'),
    recycledObject(name: 'trash', image: 'trash.png'),
    recycledObject(name: 'metal', image: 'metal.png')
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: search_color,
        title: Text('Help'),
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
                  color: search_color,
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
              leading: Icon(Icons.camera_alt,),
              title: const Text(
                'Camera',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 17.0,
                ),
              ),
              onTap: () {
                // Update the state of the app
                Navigator.pushNamed(context, '/camera');
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
                Navigator.pushNamed(context, '/loading');
              },
            ),
            ListTile(
              leading: Icon(
                Icons.help_rounded,
                color: Colors.blue[200],
              ),
              title: const Text(
                'Help',
                style: TextStyle(fontSize: 17.0, color: Colors.blueAccent),
              ),
              onTap: () {
                // Update the state of the app
                Navigator.pop(context);
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
                Navigator.pushNamed(context, '/settings');
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Flexible(
              child: SearchAnchor(
                  builder: (BuildContext context, SearchController controller) {
                    return SearchBar(
                      controller: controller,
                      padding: const MaterialStatePropertyAll<EdgeInsets>(
                          EdgeInsets.symmetric(horizontal: 16.0)),
                      onTap: () {
                        controller.openView();
                      },
                      onChanged: (_) {
                        controller.openView();
                      },
                      leading: const Icon(Icons.search),
                      // trailing: <Widget>[
                      //   Tooltip(
                      //     message: 'Change brightness mode',
                      //     child: IconButton(
                      //       isSelected: isDark,
                      //       onPressed: () {
                      //         setState(() {
                      //           isDark = !isDark;
                      //         });
                      //       },
                      //       icon: const Icon(Icons.wb_sunny_outlined),
                      //       selectedIcon: const Icon(Icons.brightness_2_outlined),
                      //     ),
                      //   )
                      // ],
                    );
                  },
                  suggestionsBuilder: (BuildContext context, SearchController controller) {
                    return List<ListTile>.generate(6, (int index) {
                      final recycledObject item = objectImages[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage(
                              'images/${item.image}'),
                        ),
                        title: Text(item.name),
                        onTap: () {
                          setState(() {
                            controller.closeView(item.name);
                          });
                        },
                      );
                    });
              }),
            ),
            Flexible(
              child: ListView.builder(
                itemCount: objectImages.length.clamp(0, 6),
                // prototypeItem: ListTile(
                //   title: Text(objectImages.first.name),
                // ),
                itemBuilder: (context,index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      onTap: (){
                        Navigator.pushReplacementNamed(context, '/help');
                      },
                      title: Text(objectImages[index].name),
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(
                            'images/${objectImages[index].image}'),
                      ),
                    ),
                  );
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
