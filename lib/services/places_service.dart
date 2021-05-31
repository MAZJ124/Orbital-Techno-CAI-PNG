import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:nus_spots/models/place_search.dart';
import 'package:nus_spots/models/place.dart';

class PlacesService{
  final key = 'AIzaSyAK6ZnJUF2IqiyeyccoqX215Tm-SoLFc7E';

  Future<List<PlaceSearch>> getAutoComplete(String search) async{
    var url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&types=geocode&key=$key';
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['predictions'] as List;
    return jsonResults.map((place) => PlaceSearch.fromJson(place)).toList();
  }

  Future<Place> getPlace(String placeId) async{
    var url =
        'https://maps.googleapis.com/maps/api/place/details/json?key=$key&place_id=$placeId';
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['result'] as Map<String, dynamic>;
    return Place.fromJson(jsonResults);
  }
}

