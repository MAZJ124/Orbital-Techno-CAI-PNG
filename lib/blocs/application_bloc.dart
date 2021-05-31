import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nus_spots/services/geolocator_service.dart';
import 'package:nus_spots/services/places_service.dart';
import 'package:nus_spots/models/place_search.dart';

class ApplicationBloc with ChangeNotifier{
  final geolocatorService = GeolocatorService();
  final placesService = PlacesService();

  //Variables
  Position currentLocation;
  List<PlaceSearch> searchResults;

  ApplicationBloc(){
    setCurrentLocation();
  }

  setCurrentLocation() async{
    currentLocation = await geolocatorService.getCurrentLocation();
    notifyListeners();
  }

  searchPlaces(String searchTerm) async{
    searchResults = await placesService.getAutoComplete(searchTerm);
    notifyListeners();
  }
}