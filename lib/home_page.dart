import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
                  Icons.fastfood_rounded,
                  color: Colors.green,
                  size: 50.0,
                ),
                label: Text(
                  'EAT',
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
                  Icons.book_rounded,
                  color: Colors.green,
                  size: 50.0,
                ),
                label: Text(
                  'STUDY',
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




