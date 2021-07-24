import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'blocs/application_bloc.dart';
import 'dart:async';
import 'models/place.dart';
import 'globals.dart';
// import 'models/geometry.dart';
// import 'models/location.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class Map extends StatefulWidget {
  const Map({Key key}) : super(key: key);

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  Completer<GoogleMapController> _mapController = Completer();
  StreamSubscription locationSubscription;
  final fireStore = FirebaseFirestore.instance;

  //trial for route finder
  Set<Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();

  @override
  void initState() {
    final applicationBloc = Provider.of<ApplicationBloc>(
      context,
      listen: false,
    );

    locationSubscription =
        applicationBloc.selectedLocation.stream.listen((place) {
      if (place != null) {
        _goToPlace(place);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    final applicationBloc = Provider.of<ApplicationBloc>(
      context,
      listen: false,
    );
    applicationBloc.dispose();
    locationSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<ApplicationBloc>(context);

    //Attempt for go to map feature (does not work)
    // if (currentLat != null && currentLng != null) {
    //   _goToPlace(Place(geometry: Geometry(location: Location(lat: currentLat, lng: currentLng))));
    // }
    // currentLat = 500;
    // currentLng = 500;

    void setPolylines() async {
      PolylineResult result = await
      polylinePoints.getRouteBetweenCoordinates(
          'AIzaSyCLv6qOhkAcvRUhb4WSCKLL-P5AtBktr6E',
          // 'AIzaSyAbJKG6Q97kA_SXrvQ_sNPV05GHJelzXR4',
        // 'AIzaSyC6Vq2RH4XM4Lm3wpAYDxCJuSsQWSuf5yM',
          PointLatLng(
              applicationBloc.currentLocation.latitude,
              applicationBloc.currentLocation.longitude,
          ),
          PointLatLng(
              (currentLat != null) ? currentLat : applicationBloc.currentLocation.latitude,
              (currentLng != null) ? currentLng : applicationBloc.currentLocation.longitude,
          ),
          travelMode: TravelMode.walking,//destination coordinates
      );
      print(result.status);
      print(polylines.isEmpty);
      if (result.points.isNotEmpty){
        // loop through all PointLatLng points and convert them
        // to a list of LatLng, required by the Polyline
        result.points.forEach((PointLatLng point){
          polylineCoordinates.add(
              LatLng(point.latitude, point.longitude));
        });

        setState(() {
          polylines.add(
              Polyline(
                width: 10,
                polylineId: PolylineId('polyLine'),
                color: Color(0xFF08A5CB),
                points: polylineCoordinates,
              )
          );
        });
        print(polylines.isEmpty);
      }
      // setState(() {
      //   // create a Polyline instance
      //   // with an id, an RGB color and the list of LatLng pairs
      //   Polyline polyline = Polyline(
      //     polylineId: PolylineId('poly'),
      //     color: Color(0xFF08A5CB),
      //     points: polylineCoordinates,
      //   );
      //
      //   // add the constructed polyline as a set of points
      //   // to the polyline set, which will eventually
      //   // end up showing up on the map
      //   polylines.add(polyline);
      // });

    }



    return Scaffold(
      body: (applicationBloc.currentLocation == null)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: ' Search',
                      suffixIcon: Icon(
                        Icons.search,
                      ),
                    ),
                    onChanged: (value) => applicationBloc.searchPlaces(value),
                  ),
                ),
                Stack(
                  children: [
                    StreamBuilder<QuerySnapshot>(
                      stream: fireStore.collection('locations').snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.lightBlueAccent,
                            ),
                          );
                        }
                        final locations = snapshot.data.docs;
                        Set<Marker> set = {};


                        for (var location in locations) {
                          final markerId = location['name'];
                          final lat = location['lat'];
                          final lng = location['lng'];
                          final marker = customMarker(
                            markerId: markerId,
                            lat: lat,
                            lng: lng,
                          );
                          set.add(marker);
                        }
                        return Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: GoogleMap(
                            mapType: MapType.normal,
                            myLocationEnabled: true,
                            initialCameraPosition: CameraPosition(
                              target: LatLng(
                                  // (currentLat != null) ? currentLat :
                                  applicationBloc.currentLocation.latitude,
                                  // (currentLng != null) ? currentLng :
                                  applicationBloc.currentLocation.longitude),
                              zoom: 15,
                            ),
                            onMapCreated: (GoogleMapController controller) {
                              _mapController.complete(controller);
                              setPolylines();
                            },
                            markers: set,
                            polylines: polylines,
                          ),
                        );
                      },
                    ),
                    if (applicationBloc.searchResults != null &&
                        applicationBloc.searchResults.length != 0)
                      Container(
                        height: 300.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          backgroundBlendMode: BlendMode.darken,
                        ),
                      ),
                    if (applicationBloc.searchResults != null &&
                        applicationBloc.searchResults.length != 0)
                      Container(
                        height: 300.0,
                        child: ListView.builder(
                          itemCount: applicationBloc.searchResults.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () {
                                applicationBloc.setSelectedLocation(
                                  applicationBloc.searchResults[index].placeId,
                                );
                              },
                              title: Text(
                                applicationBloc
                                    .searchResults[index].description,
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                          },
                        ),
                      ),
                  ],
                ),
              ],
            ),
    );
  }

  Future<void> _goToPlace(Place place) async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target:
              LatLng(place.geometry.location.lat, place.geometry.location.lng),
          zoom: 14.0,
        ),
      ),
    );
  }
}

Marker customMarker({String markerId, double lat, double lng}) {
  return Marker(
    markerId: MarkerId(markerId),
    position: LatLng(lat, lng),
    infoWindow: InfoWindow(title: markerId),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
  );
}

