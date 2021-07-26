import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nus_spots/models/user.dart';
import 'globals.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'dart:math' show cos, sqrt, asin;

const Color selectedColor = Colors.green;
const Color unselectedColor = Colors.black26;

//function to calculate distance between 2 locations given both latlngs
double calculateDistance(lat1, lon1, lat2, lon2) {
  var p = 0.017453292519943295;
  var c = cos;
  var a = 0.5 - c((lat2 - lat1) * p)/2 +
      c(lat1 * p) * c(lat2 * p) *
          (1 - c((lon2 - lon1) * p))/2;
  return 12742 * asin(sqrt(a));
}

final locationsRef = FirebaseFirestore.instance.collection('locations');
final commentsRef = FirebaseFirestore.instance.collection('comments');

final DateTime timestamp = DateTime.now();

NUSer currentUser;

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
  final GlobalKey<TagsState> _globalKeyBrowse = GlobalKey<TagsState>();
  Color studyColor = unselectedColor;
  Color eatColor = unselectedColor;
  Color allColor = selectedColor;
  String currentCategory = "all";
  var touched = false;

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
    List<String> comparedTags = (selectedTags.isEmpty) ? allTags : selectedTags;
    if (_searchController.text != "" || touched) {
      for (var location in _allResults) {
        var title = location['name'].toLowerCase();
        var category = location['category'];
        var correctCategory = false;
        var containsTag = true;
        for (var tag in selectedTags) {
          if (!location['tags'].contains(tag)) {
            containsTag = false;
          }
        }
        if (currentCategory == "all" || (category == currentCategory || category == "both")) {
          correctCategory = true;
        }
        if (title.contains(_searchController.text.toLowerCase()) && containsTag && correctCategory) {
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

  getNearbyLocations(currLat, currLong) {
    var nearLoc = [];
    int index = 0;
    for (var location in _allResults) {
      var distanceFrom = calculateDistance(currLat, currLong, _allResults[index]['lat'], _allResults[index]['lng'] );
      if (distanceFrom < 0.25 && distanceFrom > 0) {
        nearLoc.add(location);
      }
      index++;
    }
    setState(() {
      nearbyLocations = nearLoc;
    });
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
                // onChanged: _onSearchChanged(),
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
                          MaterialStateProperty.all(studyColor),
                    ),
                    onPressed: () {
                      setState(() {
                        studyColor = selectedColor;
                        eatColor = unselectedColor;
                        allColor = unselectedColor;
                        currentCategory = "study";
                        touched = true;
                        getLocations();
                      });
                    },
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
                          MaterialStateProperty.all(eatColor),
                    ),
                    onPressed: () {
                      setState(() {
                        studyColor = unselectedColor;
                        eatColor = selectedColor;
                        allColor = unselectedColor;
                        currentCategory = "food";
                        touched = true;
                        getLocations();
                      });
                    },
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
                      backgroundColor: MaterialStateProperty.all(allColor),
                    ),
                    onPressed: () {
                      setState(() {
                        studyColor = unselectedColor;
                        eatColor = unselectedColor;
                        allColor = selectedColor;
                        currentCategory = "all";
                        touched = true;
                        getLocations();
                      });
                    },
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
            Tags(
              itemCount: allTags.length,
              key: _globalKeyBrowse,
              columns: 3,
              itemBuilder: (index) {
                return ItemTags(
                  onPressed: (item) {
                    setState(() {
                      (selectedTags.contains(item.title)) ? (selectedTags.remove(item.title)) :(selectedTags.add(item.title));
                      touched = true;
                      getLocations();
                    });
                  },
                  index: index,
                  title: allTags[index],
                );
              },
            ),
            SizedBox(height: 15.0),
            Expanded(
              child: ListView.builder(
                itemCount: _resultsList.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      onTap: () {
                        locationID = _resultsList[index]['locationID'];
                        locationName = _resultsList[index]['name'];
                        imageURL = _resultsList[index]['image'];
                        tags = List.from(_resultsList[index]['tags']);
                        currentLat = _resultsList[index]['lat'];
                        currentLng = _resultsList[index]['lng'];

                        getNearbyLocations(currentLat, currentLng);

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
