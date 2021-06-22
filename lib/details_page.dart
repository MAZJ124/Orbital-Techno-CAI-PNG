import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  const Details({Key key}) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
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
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container( //name of location
                child: Text(
                  'Location name',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container( //picture of location
                child: Placeholder(fallbackHeight: 150)
              ),
              SizedBox(height : 20),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Tags/Categories',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Divider(
                height: 10,
                thickness: 2,
                color: Colors.black54,
              ),
              SizedBox(height:20),
              Container( //tags/categories
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: <Widget>[
                   Row( //1st row
                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     children: <Widget>[
                       Container(
                       padding: EdgeInsets.all(10.0),
                       decoration: BoxDecoration(
                         color: Colors.blue[100],
                         border: Border.all(
                           color: Colors.black12,
                         ),
                         borderRadius: BorderRadius.all(Radius.circular(20))
                       ),
                         child: Text(
                             'study',
                           style: TextStyle(
                             fontSize: 18.0,
                             fontWeight: FontWeight.bold,
                           ),
                         ),
                       ),
                       Container(
                         padding: EdgeInsets.all(10.0),
                         decoration: BoxDecoration(
                             color: Colors.blue[100],
                             border: Border.all(
                               color: Colors.black12,
                             ),
                             borderRadius: BorderRadius.all(Radius.circular(20))
                         ),
                         child: Text(
                           'aircon',
                           style: TextStyle(
                             fontSize: 18.0,
                             fontWeight: FontWeight.bold,
                           ),
                         ),
                       ),
                       Container(
                         padding: EdgeInsets.all(10.0),
                         decoration: BoxDecoration(
                             color: Colors.blue[100],
                             border: Border.all(
                               color: Colors.black12,
                             ),
                             borderRadius: BorderRadius.all(Radius.circular(20))
                         ),
                         child: Text(
                           'indoor',
                           style: TextStyle(
                             fontSize: 18.0,
                             fontWeight: FontWeight.bold,
                           ),
                         ),
                       ),
                     ],
                   ),
                   SizedBox(height: 20),
                   Row( //2nd row
                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     children: <Widget>[
                       Container(
                         padding: EdgeInsets.all(10.0),
                         decoration: BoxDecoration(
                             color: Colors.blue[100],
                             border: Border.all(
                               color: Colors.black12,
                             ),
                             borderRadius: BorderRadius.all(Radius.circular(20))
                         ),
                         child: Text(
                           'wallplugs',
                           style: TextStyle(
                             fontSize: 18.0,
                             fontWeight: FontWeight.bold,
                           ),
                         ),
                       ),
                       Container(
                         padding: EdgeInsets.all(10.0),
                         decoration: BoxDecoration(
                             color: Colors.blue[100],
                             border: Border.all(
                               color: Colors.black12,
                             ),
                             borderRadius: BorderRadius.all(Radius.circular(20))
                         ),
                         child: Text(
                           'Engineering',
                           style: TextStyle(
                             fontSize: 18.0,
                             fontWeight: FontWeight.bold,
                           ),
                         ),
                       ),
                       Container(
                         padding: EdgeInsets.all(10.0),
                         decoration: BoxDecoration(
                             color: Colors.blue[100],
                             border: Border.all(
                               color: Colors.black12,
                             ),
                             borderRadius: BorderRadius.all(Radius.circular(20))
                         ),
                         child: Text(
                           'IT',
                           style: TextStyle(
                             fontSize: 18.0,
                             fontWeight: FontWeight.bold,
                           ),
                         ),
                       ),
                     ],
                   ),
                 ],
                ),
              ),
              SizedBox(height : 20),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Review & Discussion',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Divider(
                height: 10,
                thickness: 2,
                color: Colors.black54,
              ),
              //comment area

            ],
          ),
        ),
      ),
    );
  }
}