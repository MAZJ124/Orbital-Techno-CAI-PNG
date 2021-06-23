import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Browse extends StatefulWidget {
  const Browse({Key key}) : super(key: key);

  @override
  _BrowseState createState() => _BrowseState();
}

class _BrowseState extends State<Browse> {
  //used to access locations from firestore database
  final fireStore = FirebaseFirestore.instance;

  TextEditingController _searchController = TextEditingController();
  List _allResults = [];
  List _resultsList = [];
  Future resultsLoaded;

  //dropdown boxes for the different categories
  bool firstValue = false;
  bool secValue = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    resultsLoaded = getLocations();
  }

  _onSearchChanged() {
    searchResultsList();
  }

  searchResultsList() {
    var showResults = [];

    if (_searchController.text != "") {
      for (var result in _allResults){
        var title = result['name'];
        if(title.contains(_searchController.text.toLowerCase())) {
          showResults.add(result);
        }
      }
    }
    else {
      showResults = List.from(_allResults);
    }
    setState(() {
      _resultsList = showResults;
    });
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
                  onChanged: (value) {},
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
                        backgroundColor:
                            MaterialStateProperty.all(Colors.green),
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
                        Checkbox(
                          value: this.firstValue,
                          onChanged: (bool value) {
                            setState(() {
                              this.firstValue = value;
                            });
                          },
                        ),
                        Text('First'),
                      ],
                    ),
                  ),
                  DropdownMenuItem(
                    child: Row(
                      children: <Widget>[
                        Checkbox(
                          value: this.secValue,
                          onChanged: (bool value) {
                            setState(() {
                              this.secValue = value;
                            });
                          },
                        ),
                        Text('Second'),
                      ],
                    ),
                  )
                ],
                onChanged: (value) {},
                hint: Text('Select tags/categories'),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _resultsList.length,
                  itemBuilder: (context, index){
                    //add item into final list view
                    return Center(
                      child: MaterialButton(
                        color: Colors.black12,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        onPressed: (){},
                        child: SizedBox(
                          child: Text(_resultsList[index]['name']),
                          width: double.infinity,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
