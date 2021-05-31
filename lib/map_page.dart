import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'blocs/application_bloc.dart';

class Map extends StatefulWidget {
  const Map({Key key}) : super(key: key);

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
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
                      height: 300.0,
                      child: GoogleMap(
                        mapType: MapType.normal,
                        myLocationEnabled: true,
                        initialCameraPosition: CameraPosition(
                          //target: LatLng(applicationBloc.currentLocation.latitude, applicationBloc.currentLocation.longitude),
                          target: LatLng(1.3384789518170104, 103.7454277134935),
                          zoom: 15,
                        ),
                      ),
                    ),
                    if (applicationBloc.searchResults != null && applicationBloc.searchResults.length != 0)
                    Container(
                      height: 300.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        backgroundBlendMode: BlendMode.darken,
                      ),
                    ),
                    if (applicationBloc.searchResults != null && applicationBloc.searchResults.length != 0)
                    Container(
                      height: 300.0,
                      child: ListView.builder(
                        itemCount: applicationBloc.searchResults.length,
                        itemBuilder: (context, index){
                          return ListTile(
                            title: Text(
                              applicationBloc.searchResults[index].description,
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
}
