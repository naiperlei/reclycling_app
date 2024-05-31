import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recycle_me_this/blocs/blocs.dart';
import 'package:recycle_me_this/pages/mapa_prueba.dart';
import 'package:recycle_me_this/pages/pages.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GpsBloc, GpsState>(
        builder: (context, state) {
          return state.isAllGranted
            ? const Mapa_Prueba()
            : const LocationPermissionPage();
        },
      ),
    );
  }
}
