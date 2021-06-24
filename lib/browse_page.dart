import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'globals.dart';

class Browse extends StatefulWidget {
  const Browse({Key key}) : super(key: key);

  @override
  _BrowseState createState() => _BrowseState();
}

class _BrowseState extends State<Browse> {
  final fireStore = FirebaseFirestore.instance;
  Future resultsLoaded;
  List _allResults = [];
  List _resultsList = [];
  TextEditingController _searchController = TextEditingController();

  //dropdown boxes for the different categories
  bool aircon = false;
  bool noAircon = false;
  bool indoors = false;
  bool outdoors = false;
  bool wallplugs = false;
  bool noWallplugs = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  _onSearchChanged() {
    searchResultsList();
  }

  searchResultsList() {
    var showResults = [];
    if (_searchController.text != "") {
      for (var location in _allResults) {
        var title = location['name'].toLowerCase();
        if (title.contains(_searchController.text.toLowerCase())) {
          showResults.add(location);
        }
      }
    } else {
      showResults = List.from(_allResults);
    }
    setState(() {
      _resultsList = showResults;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    resultsLoaded = getLocations();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  getLocations() async {
    var data = await fireStore.collection('locations').get();
    setState(() {
      _allResults = data.docs;
    });
    searchResultsList();
    return 'done';
  }

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
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: ' Search',
                  suffixIcon: Icon(
                    Icons.search,
                  ),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.black26),
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
                      backgroundColor:
                          MaterialStateProperty.all(Colors.black26),
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
              onChanged: (value) {},
              hint: Text('Select tags/categories'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _resultsList.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      onTap: () {
                        locationName = _resultsList[index]['name'];
                        imageURL = _resultsList[index]['image'];
                        tags = List.from(_resultsList[index]['tags']);
                        Navigator.pushNamed(context, '/details');
                      },
                      title: Text(_resultsList[index]['name']),
                      trailing: Icon(Icons.keyboard_arrow_right),
                    ),
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
