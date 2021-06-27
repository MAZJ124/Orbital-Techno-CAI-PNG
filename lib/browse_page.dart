import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nus_spots/models/user.dart';
import 'globals.dart';
import 'package:flutter_tags/flutter_tags.dart';

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
  //dropdown boxes for the different categories
  // bool aircon = false;
  // bool noAircon = false;
  // bool indoors = false;
  // bool outdoors = false;
  // bool wallplugs = false;
  // bool noWallplugs = false;

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
        if (title.contains(_searchController.text.toLowerCase())
            // && location['tags'].any((item) => selectedTags.contains(item))
        ) {
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
            Tags(
              itemCount: allTags.length,
              key: _globalKeyBrowse,
              columns: 3,
              itemBuilder: (index) {
                return ItemTags(
                  onPressed: (item) {
                    (selectedTags.contains(item.title)) ? (selectedTags.remove(item.title)) :(selectedTags.add(item.title));
                    // var subAllResults = [];
                    // for (var location in _allResults){
                    //   if (location['tags'].any((item) => selectedTags.contains(item))){
                    //     subAllResults.add(location);
                    //   }
                    // }
                    // _allResults = subAllResults;
                  },
                  index: index,
                  title: allTags[index],
                );
              },
            ),
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
