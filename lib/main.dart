

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:recycle_me_this/blocs/blocs.dart';
import 'package:recycle_me_this/pages/pages.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workmanager/workmanager.dart';

void callbackDispatcher(){
  print("in");
  Workmanager().executeTask((taskName, inputData) {
    switch(taskName){
      case "taskOne":
        for(int i = 0; i<10; i++){

        }
    }

    return Future.value(true);
  });
}

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(callbackDispatcher);
  bool modoOscuro = false;
  runApp(MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GpsBloc())
      ],
      child: MaterialApp(
        theme: modoOscuro ? ThemeData.dark() : ThemeData.light(),
        initialRoute: '/',
        routes: {
          '/': (context) => Home(),
          '/loading': (context) => Loading(),
          '/camera': (context) => Camera(),
          '/scanning-result': (context) => ScanningResult(),
          '/map': (context) => MapBin(),
          '/search': (context) => Search(),
          '/settings': (context) => Settings(),
          '/location-permissions': (context) => LocationPermissionPage(),
          '/help': (context) => Helper(),
        },
      )
  ));
}

