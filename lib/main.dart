import 'package:flutter/material.dart';
import 'package:nus_spots/blocs/application_bloc.dart';
import 'package:nus_spots/models/user.dart';
import 'package:nus_spots/services/auth_service.dart';
import 'package:nus_spots/wrapper.dart';
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
      child: StreamProvider<NUSer>.value(
        catchError: (_,__) => null,
        initialData: null,
        value: AuthService().user,
        child: MaterialApp(
          initialRoute: '/wrapper',
          routes: {
            '/wrapper': (context) => Wrapper(),
            '/home': (context) => Home(),
            '/map': (context) => Map(),//change this to preview
            '/options': (context) => Browse(),
            '/details': (context) => Details(),
          },
        ),
      ),
    );
  }
}

