import 'package:flutter/material.dart';
import 'package:nus_spots/services/auth_service.dart';
import 'globals.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'NUSpots',
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
        ),
        backgroundColor: Colors.green,
        centerTitle: true,
        actions: <Widget>[
          TextButton.icon(
            icon: Icon(
              Icons.person,
              color: Colors.black,
            ),
            label: Text(
              'Log Out',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            onPressed: () async {
              await _auth.signOut();
            },
          )
        ],
      ),
      body: SafeArea(
        minimum: EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: TextButton.icon(
                onPressed: () {
                  currentLat = null;
                  currentLng = null;
                  Navigator.pushNamed(context, '/map');
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black12),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                ),
                icon: Icon(
                  Icons.map,
                  color: Colors.green,
                  size: 50.0,
                ),
                label: Text(
                  'MAP',
                  style: TextStyle(
                    fontSize: 40.0,
                    color: Colors.green,
                  ),
                ),
              ),
            ),
            SizedBox(height: 5.0,),
            Expanded(
              child: TextButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/custom');
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black12),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                ),
                icon: Icon(
                  Icons.book_rounded,
                  color: Colors.green,
                  size: 50.0,
                ),
                label: Text(
                  'CUSTOMIZE',
                  style: TextStyle(
                    fontSize: 40.0,
                    color: Colors.green,
                  ),
                ),
              ),
            ),
            SizedBox(height: 5.0,),
            Expanded(
              child: TextButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/options');
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black12),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                ),
                icon: Icon(
                  Icons.list_alt_rounded,
                  color: Colors.green,
                  size: 50.0,
                ),
                label: Text(
                  'ALL OPTIONS',
                  style: TextStyle(
                    fontSize: 40.0,
                    color: Colors.green,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}




