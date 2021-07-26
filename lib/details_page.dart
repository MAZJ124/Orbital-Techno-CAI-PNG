import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'globals.dart';
import 'browse_page.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'dart:math' show cos, sqrt, asin;

double calculateDistance(lat1, lon1, lat2, lon2){
  var p = 0.017453292519943295;
  var c = cos;
  var a = 0.5 - c((lat2 - lat1) * p)/2 +
      c(lat1 * p) * c(lat2 * p) *
          (1 - c((lon2 - lon1) * p))/2;
  return 12742 * asin(sqrt(a));
}

class Details extends StatefulWidget {
  const Details({Key key}) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {

  final GlobalKey<TagsState> _globalKey = GlobalKey<TagsState>();

  TextEditingController commentController = TextEditingController();

  //var data = locationsRef.get();
  List allLocations = [];
  Future resultsLoaded;

  getLocations() async {
    var data = await locationsRef.get();
    setState(() {
      allLocations = data.docs;
    });
    return 'done';
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    resultsLoaded = getLocations();
  }

  getNearbyLocations(currLat, currLong) {
    var nearLoc = [];
    int index = 0;
    for (var location in allLocations) {
      var distanceFrom = calculateDistance(currLat, currLong, allLocations[index]['lat'], allLocations[index]['lng'] );
      if (distanceFrom < 0.25 && distanceFrom > 0) {
        nearLoc.add(location);
      }
      index++;
    }
    setState(() {
      nearbyLocations = nearLoc;
    });
  }


  buildComments() {
    return StreamBuilder(
        stream: commentsRef.doc(locationID).collection('comments').
        orderBy("timestamp", descending: false).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }

          List<Comment> comments = [];
          snapshot.data.docs.forEach((doc) {
            comments.add(Comment.fromDocument(doc));
          });
          return ListView(
            children: comments,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
          );
        });
  }

  addComment() {
    var randomDoc = commentsRef
                  .doc(locationID)
                  .collection("comments")
                  .doc();

    commentsRef
        .doc(locationID)
        .collection("comments")
        .doc(randomDoc.id)
        .set(
        {
      //"username": currentUser.username,
      "comment": commentController.text,
      "timestamp": timestamp,
      "commentID": randomDoc.id
      //"userID": currentUser.uid,
      },
    );
    commentController.clear();
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
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    //name of location
                    width: 200.0,
                    child: Text(
                      '$locationName',
                      style: TextStyle(
                        fontSize: 23.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, '/map');
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.black12),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                    icon: Icon(
                      Icons.map,
                      color: Colors.green[700],
                      size: 10.0,
                    ),
                    label: Text(
                      'Find Route',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.green[700],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Container(
                //picture of location
                child: Image.network(imageURL),
                // child: Placeholder(fallbackHeight: 150)
              ),
              SizedBox(height: 20),
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
              SizedBox(height: 20),
              Container(
                //tags/categories
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Tags(
                      itemCount: tags.length,
                      key: _globalKey,
                      columns: 3,
                      itemBuilder: (index) {
                        return ItemTags(
                          index: index,
                          title: tags[index],
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Nearby NUSpots',
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
              SizedBox(height: 20),
              SizedBox(
                height: 250,
                child: ListView.builder(
                  /*physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,*/
                  //shrinkWrap: true,
                  itemCount: nearbyLocations.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        onTap: () {
                          locationID = nearbyLocations[index]['locationID'];
                          locationName = nearbyLocations[index]['name'];
                          imageURL = nearbyLocations[index]['image'];
                          tags = List.from(nearbyLocations[index]['tags']);
                          currentLat = nearbyLocations[index]['lat'];
                          currentLng = nearbyLocations[index]['lng'];
                          Navigator.pushNamed(context, '/details');

                          getNearbyLocations(currentLat, currentLng);
                        },
                        title: Text(nearbyLocations[index]['name']),
                        trailing: Icon(Icons.keyboard_arrow_right),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
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
              SizedBox(height: 5),
              //comment area
              ListTile(
                title: TextFormField(
                  controller: commentController,
                  decoration: InputDecoration(labelText: "Add a comment..."),
                ),
                trailing: OutlineButton(
                  onPressed: () => addComment(),
                  borderSide: BorderSide.none,
                  child: Text("Post"),
                ),
              ),
              SizedBox(height: 10.0),
              buildComments(),
            ],
          ),
        ),
      ),
    );
  }
}

class Comment extends StatelessWidget {
  //const Comment({Key key}) : super(key: key);
  final String comment;

  //final String username;
  final Timestamp timestamp;
  final String commentID;

  Comment({
    this.comment,
    this.timestamp,
    this.commentID
  });

  factory Comment.fromDocument(DocumentSnapshot doc) {
    return Comment(
        comment: doc.get('comment'),
        timestamp: doc.get('timestamp'),
        commentID: doc.get('commentID')
    );
  }

  @override
  Widget build(BuildContext context) {

    //TODO: implement ownerID and currentUserID check for this
    void deleteComment(String commentID) {
      commentsRef.doc(locationID)
          .collection('comments')
          .doc(commentID)
          .get().then((doc) {
        if (doc.exists) {
          doc.reference.delete();
        }
      });
    }

    void updateComment(String commentID, String val) {
      commentsRef.doc(locationID)
          .collection('comments')
          .doc(commentID)
          .get().then((doc) {
            if (doc.exists) {
              doc.reference.update(
                {'comment': val,}
              );
            }
          });
    }

    void _editCommentPanel(String commentID) {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget> [
                Text(
                  'Edit your comment',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 0.1, horizontal: 0.1) ,
                    border: OutlineInputBorder(),
                  ),
                  validator: (val) => val.isEmpty ? 'Please write a comment' : null,
                  onChanged: (val) => updateComment(commentID, val),
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                        color: Colors.pink[400],
                        onPressed: () {
                          Navigator.pop(context);

                        },
                      child: Text(
                        'Update',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    RaisedButton(
                      color: Colors.pink[400],
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      });
    }


    deleteEditComment(BuildContext parentContext, String commentID) {
      return showDialog(
          context: parentContext,
          builder: (context) {
            return SimpleDialog(
              children: <Widget> [
                SimpleDialogOption(
                    onPressed: () {
                      deleteComment(commentID);
                      Navigator.pop(context);
                    },
                    child: Text('Delete comment',
                      style: TextStyle(color: Colors.red),
                    )
                ),
                SimpleDialogOption(
                    onPressed: () {
                      Navigator.pop(context);
                      _editCommentPanel(commentID);
                    },
                    child: Text('Edit comment',
                      style: TextStyle(color: Colors.red),
                    )
                ),
                SimpleDialogOption(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Cancel',
                      style: TextStyle(color: Colors.red),
                    )
                ),
              ],
            );
          }
      );
    }

    return Column(
      children: <Widget>[
        ListTile(
          title: Text(comment),
          //leading, image...
          subtitle: Text(timeago.format(timestamp.toDate())),
          trailing: IconButton(
            onPressed: () {
              deleteEditComment(context, this.commentID);
              },
            icon: Icon(Icons.more_vert),
          ),
        ),
        Divider(),
      ],
    );
  }
}




