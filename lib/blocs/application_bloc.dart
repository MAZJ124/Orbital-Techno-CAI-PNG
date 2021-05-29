import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nus_spots/services/geolocator_service.dart';

class ApplicationBloc with ChangeNotifier{
  final geolocatorService = GeolocatorService();

  //Variables
  Position currentLocation;

  ApplicationBloc(){
    setCurrentLocation();
  }

  setCurrentLocation() async{
    currentLocation = await geolocatorService.getCurrentLocation();
    notifyListeners();
  }
}