import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'blocs/application_bloc.dart';
import 'dart:async';
import 'models/place.dart';

class Map extends StatefulWidget {
  const Map({Key key}) : super(key: key);

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  Completer<GoogleMapController> _mapController = Completer();
  StreamSubscription locationSubscription;

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
                    Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: GoogleMap(
                        mapType: MapType.normal,
                        myLocationEnabled: true,
                        initialCameraPosition: CameraPosition(
                          target: LatLng(
                              applicationBloc.currentLocation.latitude,
                              applicationBloc.currentLocation.longitude),
                          //target: LatLng(1.3384789518170104, 103.7454277134935),
                          zoom: 15,
                        ),
                        onMapCreated: (GoogleMapController controller) {
                          _mapController.complete(controller);
                        },
                        markers: {
                          marker1,
                        },
                      ),
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

Marker marker1 = Marker(
  markerId: MarkerId('UTown starbucks'),
  position: LatLng(1.3063730486397818, 103.7731868576717),
  infoWindow: InfoWindow(title: 'Starbucks'),
  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
);
