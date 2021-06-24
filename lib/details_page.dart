import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'globals.dart';
import 'browse_page.dart';
import 'package:flutter_tags/flutter_tags.dart';

class Details extends StatefulWidget {
  const Details({Key key}) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final GlobalKey<TagsState> _globalKey = GlobalKey<TagsState>();

  TextEditingController commentController = TextEditingController();

  buildComments() {
    return StreamBuilder(
        stream: commentsRef.doc(locationID).collection('comments').snapshots(),
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
    commentsRef.doc(locationID).collection("comments").add({
      //"username": currentUser.username,
      "comment": commentController.text,
      //"timestamp": timestamp
    });
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
                    child: Text(
                      '$locationName',
                      style: TextStyle(
                        fontSize: 30,
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
                      'Go to Map',
                      style: TextStyle(
                        fontSize: 17.0,
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
                    //      Row( //1st row
                    //        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //        children: <Widget>[
                    //          Container(
                    //          padding: EdgeInsets.all(10.0),
                    //          decoration: BoxDecoration(
                    //            color: Colors.blue[100],
                    //            border: Border.all(
                    //              color: Colors.black12,
                    //            ),
                    //            borderRadius: BorderRadius.all(Radius.circular(20))
                    //          ),
                    //            child: Text(
                    //                'study',
                    //              style: TextStyle(
                    //                fontSize: 18.0,
                    //                fontWeight: FontWeight.bold,
                    //              ),
                    //            ),
                    //          ),
                    //          Container(
                    //            padding: EdgeInsets.all(10.0),
                    //            decoration: BoxDecoration(
                    //                color: Colors.blue[100],
                    //                border: Border.all(
                    //                  color: Colors.black12,
                    //                ),
                    //                borderRadius: BorderRadius.all(Radius.circular(20))
                    //            ),
                    //            child: Text(
                    //              'aircon',
                    //              style: TextStyle(
                    //                fontSize: 18.0,
                    //                fontWeight: FontWeight.bold,
                    //              ),
                    //            ),
                    //          ),
                    //          Container(
                    //            padding: EdgeInsets.all(10.0),
                    //            decoration: BoxDecoration(
                    //                color: Colors.blue[100],
                    //                border: Border.all(
                    //                  color: Colors.black12,
                    //                ),
                    //                borderRadius: BorderRadius.all(Radius.circular(20))
                    //            ),
                    //            child: Text(
                    //              'indoor',
                    //              style: TextStyle(
                    //                fontSize: 18.0,
                    //                fontWeight: FontWeight.bold,
                    //              ),
                    //            ),
                    //          ),
                    //        ],
                    //      ),
                    //      SizedBox(height: 20),
                    //      Row( //2nd row
                    //        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //        children: <Widget>[
                    //          Container(
                    //            padding: EdgeInsets.all(10.0),
                    //            decoration: BoxDecoration(
                    //                color: Colors.blue[100],
                    //                border: Border.all(
                    //                  color: Colors.black12,
                    //                ),
                    //                borderRadius: BorderRadius.all(Radius.circular(20))
                    //            ),
                    //            child: Text(
                    //              'wallplugs',
                    //              style: TextStyle(
                    //                fontSize: 18.0,
                    //                fontWeight: FontWeight.bold,
                    //              ),
                    //            ),
                    //          ),
                    //          Container(
                    //            padding: EdgeInsets.all(10.0),
                    //            decoration: BoxDecoration(
                    //                color: Colors.blue[100],
                    //                border: Border.all(
                    //                  color: Colors.black12,
                    //                ),
                    //                borderRadius: BorderRadius.all(Radius.circular(20))
                    //            ),
                    //            child: Text(
                    //              'Engineering',
                    //              style: TextStyle(
                    //                fontSize: 18.0,
                    //                fontWeight: FontWeight.bold,
                    //              ),
                    //            ),
                    //          ),
                    //          Container(
                    //            padding: EdgeInsets.all(10.0),
                    //            decoration: BoxDecoration(
                    //                color: Colors.blue[100],
                    //                border: Border.all(
                    //                  color: Colors.black12,
                    //                ),
                    //                borderRadius: BorderRadius.all(Radius.circular(20))
                    //            ),
                    //            child: Text(
                    //              'IT',
                    //              style: TextStyle(
                    //                fontSize: 18.0,
                    //                fontWeight: FontWeight.bold,
                    //              ),
                    //            ),
                    //          ),
                    //        ],
                    //      ),
                    //    ],
                    //   ),
                    // ),
                    Tags(
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
  //final Timestamp timestamp;

  Comment({this.comment});

  factory Comment.fromDocument(DocumentSnapshot doc) {
    return Comment(comment: doc['comment']);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(comment),
          //leading, image...
        ),
        Divider(),
      ],
    );
  }
}
