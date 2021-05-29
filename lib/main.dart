import 'package:flutter/material.dart';
import 'package:nus_spots/blocs/application_bloc.dart';
import 'home_page.dart';
import 'map_page.dart';
import 'browse.dart';
import 'blocs/application_bloc.dart';
import 'package:provider/provider.dart';

void main() => runApp(NUSpots());

class NUSpots extends StatelessWidget {
  const NUSpots({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ApplicationBloc(),
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => Home(),
          '/map': (context) => Map(),//change this to preview
          '/options': (context) => Browse(),
        },
      ),
    );
  }
}

