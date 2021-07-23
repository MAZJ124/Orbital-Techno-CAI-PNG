import 'package:flutter_tags/flutter_tags.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'globals.dart';

class Custom extends StatefulWidget {
  const Custom({Key key}) : super(key: key);

  @override
  _CustomState createState() => _CustomState();
}

var tagValues = [
  false, //aircon
  false, //wall plug
  false, //vege
  false, //halal
  false, //indoors
  false //bus stop nearby
];

// var tagValuesMap = tagValues.asMap();
List<String> currentTags =[];

class _CustomState extends State<Custom> {

  final _formKey = GlobalKey<FormState>();
  final List<String> categories = ['study', 'food', 'both'];
  // text field state
  String locName = '';
  String imgURL = '';
  String category = '';
  String error = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add your own NUSpot',
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              //dropdown box for category
              SizedBox(height: 20.0),
              TextFormField(
                  //validator: (val) => val.length == 1 ? 'Enter a valid location name' : null,
                  onChanged: (val) {
                    setState(() => locName = val);
                  },
                  decoration: new InputDecoration(
                      hintText: 'Enter location name'
                  )
              ),
              SizedBox(height: 20.0),
              DropdownButtonFormField(
                  items: categories.map((cat){
                    return DropdownMenuItem(
                      value: cat,
                      child: Text('$cat'),
                    );
                  }).toList(),
                onChanged: (val) {
                  setState(() => category = val);
                },
                decoration:  new InputDecoration(
                    hintText: 'Choose category'
                ),
              ),
              SizedBox(height: 20.0),
              DropdownButtonFormField(
                items: allTags.map((tag){
                  var index = allTags.indexOf(tag);
                  return DropdownMenuItem(
                    child: Row(
                      children: <Widget>[
                        StatefulBuilder(
                          builder: (context, setState) => Checkbox(
                              //value: tagValuesMap[index],
                              value: tagValues[index],
                              onChanged: (bool value) {
                                setState(() {
                                  tagValues[index] = value;
                                  if (tagValues[index] == true) {
                                    currentTags.add(allTags[index]);
                                  } else {
                                    currentTags.removeWhere(
                                        (item) => item == allTags[index]
                                    );
                                  }
                                });
                              },
                          ),
                        ),
                        Text('$tag'),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                },
                decoration:  new InputDecoration(
                    hintText: 'Choose tags'
                ),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                  onChanged: (val) {
                    setState(() => imgURL = val);
                  },
                  decoration: new InputDecoration(
                      hintText: 'Enter image url link'
                  )
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                  color: Colors.pink[400],
                  child: Text(
                    'Customize location',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    locationName = locName;
                    imageURL = imgURL;
                    if (locationName.isEmpty || imageURL.isEmpty) {
                      setState(() => error = 'Please enter valid answers');
                    } else {
                      error = '';
                      Navigator.pushNamed(context, '/home');
                    }


                    print(locName);
                    print(category);
                    print(currentTags);
                    print(imgURL);

                  }
              ),
               SizedBox(height: 12.0),
               Text(
                error,
                 style: TextStyle(color: Colors.red, fontSize: 14.0),
               ),
            ],
          ),
        ),
      ),
    );
  }
}
