import 'package:flutter/material.dart';
import 'package:nus_spots/blocs/application_bloc.dart';
import 'home_page.dart';
import 'map_page.dart';
import 'browse_page.dart';
import 'details_page.dart';
import 'blocs/application_bloc.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(NUSpots());
}


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
          '/options': (context) => Details(),//can change this to preview, change back to browse after
        },
      ),
    );
  }
}

