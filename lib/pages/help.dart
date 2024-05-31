import "dart:io";
import 'package:flutter/material.dart';

class Helper extends StatefulWidget {
  const Helper({super.key});

  @override
  State<Helper> createState() => _HelperState();
}

class _HelperState extends State<Helper> {
  Color? search_color = Colors.lightGreen[300];
  int? clase=0;
  // Map of category names to their corresponding values
  List<String> categoryItems = ['Plastic', 'Paper', 'Glass', 'Organic', 'Trash'];
  List<String> plastic_info = ['Plastic bottles', 'Cans', 'Plastic and metal lids', 'Aluminum trays',
    'Plastic wrap and foil', 'Sprays', 'Deodorant bottles', 'Plastic bags', 'Yoghourt tarrines and covers',
    'Tetrabriks', 'Styrofoam trays', 'Toothpaste recipient', 'Wooden boxes from fruits,vegetables, wine, etc.',
    'Ceramic recipients'];
  List<String> plastic_icons = ['icono-botella-amarillo.png','latas.png','tapas.png','bandeja_al.png',
    'papel_al.png','aerosol.png','desodorante.png','bolsas-plastico.png','tarrina-yogur.png','brik.png',
    'icono-corcho-blanco.png','icono-tubo-pasta.png','Ilustracion_icon_ecoembes_caja_frutas.png','ceramica.png'];
  List<String> paper_info = ['Paper', 'Cardboard boxes', 'Shoe boxes', 'Frozen food boxes', 'Wrapping paper'];
  List<String> paper_icons = ['icono-papel.png','caja-carton.png','caja-zapato.png','caja-congelados.jpg','papel-envolver.png'];
  List<String> glass_info = ['Glass bottle', 'Perfume bottles', 'Jars'];
  List<String> glass_icons = ['botella-vidrio.png','botella-perfume.jpg','tarro-mermelada.png'];
  List<String> organic_info = ['Fruit peels', 'Fishbone', 'Plants', 'Eggshells', 'Napkins'];
  List<String> organic_icons = ['piel-naranja.jpg','espina.png','planta.png','huevo.png','servilletas.png'];
  List<String> trash_info = ['Toys', 'Baby bottles and pacifiers', 'Wooden cooking utensils', 'Diapers', 'Cigarrettes'];
  List<String> trash_icons = ['juguete.png','biberon-y-chupete.png','cuchara-madera.png','pañal.png','cigarrillo.jpg'];
  @override
  Widget build(BuildContext context) {
    Widget bodyWidget=Container();

    switch (clase) {
      case 0:
        bodyWidget = Container(
          // Your widget content for option1 goes here
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 20),
                Image.asset(
                  'images/plastic-bin.png',
                  height: 150,
                ),
                SizedBox(height: 20),
                Text(
                    'The yellow container is for plastic waste. In the following list you can see what to recycle in this bin.',
                    textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: 340,
                  child: ListView.builder(
                    itemCount: plastic_info.length,
                    itemBuilder:(BuildContext context, int index) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage(
                            'images/${plastic_icons[index]}'
                          ),
                        ),
                        title: Text(plastic_info[index]),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
        break;
      case 1:
        bodyWidget = Container(
          // Your widget content for option2 goes here
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 20),
                Image.asset(
                  'images/download.png',
                  height: 150,
                ),
                SizedBox(height: 20),
                Text('Paper'),
                SizedBox(height: 20),
                SizedBox(
                  height: 340,
                  child: ListView.builder(
                    itemCount: paper_info.length,
                    itemBuilder:(BuildContext context, int index) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey[100],
                          backgroundImage: AssetImage(
                              'images/${paper_icons[index]}'
                          ),
                        ),
                        title: Text(paper_info[index]),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
        break;
      case 2:
        bodyWidget = Container(
          // Your widget content for option5 goes here
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 20),
                Image.asset(
                  'images/glass-bin.png',
                  height: 150,
                ),
                SizedBox(height: 20),
                Text('Glass'),
                SizedBox(height: 20),
                SizedBox(
                  height: 340,
                  child: ListView.builder(
                    itemCount: glass_info.length,
                    itemBuilder:(BuildContext context, int index) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey[100],
                          backgroundImage: AssetImage(
                              'images/${glass_icons[index]}'
                          ),
                        ),
                        title: Text(glass_info[index]),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
        break;
      case 3:
        bodyWidget = Container(
          // Your widget content for option2 goes here
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 20),
                Image.asset(
                  'images/download.png',
                  height: 150,
                ),
                SizedBox(height: 20),
                Text('Organic'),
                SizedBox(height: 20),
                SizedBox(
                  height: 340,
                  child: ListView.builder(
                    itemCount: organic_info.length,
                    itemBuilder:(BuildContext context, int index) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey[100],
                          backgroundImage: AssetImage(
                              'images/${organic_icons[index]}'
                          ),
                        ),
                        title: Text(organic_info[index]),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
        break;
      case 4:
        bodyWidget = Container(
          // Your widget content for option6 goes here
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 20),
                Image.asset(
                  'images/trash-bin.png',
                  height: 150,
                ),
                SizedBox(height: 20),
                Text('Trash'),
                SizedBox(height: 20),
                SizedBox(
                  height: 340,
                  child: ListView.builder(
                    itemCount: trash_info.length,
                    itemBuilder:(BuildContext context, int index) {
                      if(index!=trash_info.length-1) {
                        return ListTile(
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.grey[100],
                            child: Image.asset(
                              scale:0.5,
                              'images/${trash_icons[index]}',
                            ),
                          ),
                          title: Text(trash_info[index]),
                        );
                      }
                      else{
                        return ListTile(
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.grey[100],
                            foregroundImage: AssetImage(
                              'images/${trash_icons[index]}',
                            ),
                          ),
                          title: Text(trash_info[index]),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        );
        break;
    }
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
              leading: Icon(Icons.help_rounded,),
              title: const Text(
                'Help',
                style: TextStyle(fontSize: 17.0, color: Colors.grey),
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
          bodyWidget,
        ],
      ),
    );
  }
}
