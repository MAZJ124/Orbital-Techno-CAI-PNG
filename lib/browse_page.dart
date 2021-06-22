import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Browse extends StatefulWidget {
  const Browse({Key key}) : super(key: key);

  @override
  _BrowseState createState() => _BrowseState();
}

class _BrowseState extends State<Browse> {

  final fireStore = FirebaseFirestore.instance;

  List<String> locations = [
    'TechnoEdge',
    'The Deck',
    'E2 Canteen',
    'Yusof Ishak House Canteen',
    'Central Library'
  ];

  //dropdown boxes for the different categories
  bool aircon = false;
  bool noAircon = false;
  bool indoors = false;
  bool outdoors = false;
  bool wallplugs = false;
  bool noWallplugs = false;



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
          //mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black26),
                    ),
                    onPressed: () {},
                    child: Text(
                        'Study',
                      style: TextStyle(
                        fontSize: 30.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 5.0),
                Expanded(
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black26),
                    ),
                    onPressed: () {},
                    child: Text(
                      'Eat',
                      style: TextStyle(
                        fontSize: 30.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 5.0),
                Expanded(
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green),
                    ),
                    onPressed: () {},
                    child: Text(
                      'All',
                      style: TextStyle(
                        fontSize: 30.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.0),
            //dropdown of categories
            DropdownButton(
              items: [
                DropdownMenuItem(
                  child: Row(
                    children: <Widget>[
                      StatefulBuilder(
                        builder: (context, _setState) => Checkbox(
                          value: this.aircon,
                          onChanged: (bool value) {
                            _setState(() {
                              this.aircon = value;
                            });
                          },
                        ),
                      ),
                      Text('Aircon'),
                    ],
                  ),
                ),
                DropdownMenuItem(
                  child: Row(
                    children: <Widget>[
                      StatefulBuilder(
                        builder: (context, _setState) => Checkbox(
                          value: this.noAircon,
                          onChanged: (bool value) {
                            _setState(() {
                              this.noAircon = value;
                            });
                          },
                        ),
                      ),
                      Text('No Aircon'),
                    ],
                  ),
                ),
                DropdownMenuItem(
                  child: Row(
                    children: <Widget>[
                      StatefulBuilder(
                        builder: (context, _setState) => Checkbox(
                          value: this.indoors,
                          onChanged: (bool value) {
                            _setState(() {
                              this.indoors = value;
                            });
                          },
                        ),
                      ),
                      Text('Indoors'),
                    ],
                  ),
                ),
                DropdownMenuItem(
                  child: Row(
                    children: <Widget>[
                      StatefulBuilder(
                        builder: (context, _setState) => Checkbox(
                          value: this.outdoors,
                          onChanged: (bool value) {
                            _setState(() {
                              this.outdoors = value;
                            });
                          },
                        ),
                      ),
                      Text('Outdoors'),
                    ],
                  ),
                ),
                DropdownMenuItem(
                  child: Row(
                    children: <Widget>[
                      StatefulBuilder(
                        builder: (context, _setState) => Checkbox(
                          value: this.wallplugs,
                          onChanged: (bool value) {
                            _setState(() {
                              this.wallplugs = value;
                            });
                          },
                        ),
                      ),
                      Text('Wallplugs'),
                    ],
                  ),
                ),
                DropdownMenuItem(
                  child: Row(
                    children: <Widget>[
                      StatefulBuilder(
                        builder: (context, _setState) => Checkbox(
                          value: this.noWallplugs,
                          onChanged: (bool value) {
                            _setState(() {
                              this.noWallplugs = value;
                            });
                          },
                        ),
                      ),
                      Text('No Wallplugs'),
                    ],
                  ),
                ),
              ],
              onChanged: (value) {
              },
              hint: Text('Select tags/categories'),
            ),
            Expanded(
              // child: ListView.builder(
              //   itemCount: locations.length,
              //   itemBuilder: (context, index) {
              //     return Card(
              //       child: ListTile(
              //         onTap: () {},
              //         title: Text(locations[index]),
              //         trailing: Icon(Icons.keyboard_arrow_right),
              //       ),
              //     );
              //   }
              // ),
              child: StreamBuilder(
                stream: fireStore.collection('locations').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.lightBlueAccent,
                      ),
                    );
                  }

                  return ListView(
                    children: snapshot.data.docs.map<Widget>((doc){
                      return Center(
                        child: MaterialButton(
                          color: Colors.black12,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          onPressed: (){},
                          // width: MediaQuery.of(context).size.width / 1.2,
                          // height: MediaQuery.of(context).size.height/ 6,
                          child: SizedBox(
                            child: Text(doc['name']),
                            width: double.infinity,
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },

              ),
            )
          ],
        ),
      ),
    );
  }
}
