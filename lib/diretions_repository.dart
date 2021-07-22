import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nus_spots/models/directions.dart';
import 'package:flutter/foundation.dart';

class DirectionsRepository {
  final Dio _dio;
  static const String _baseURL = 'https://maps.googleapis.com/maps/api/directions/json?';
  DirectionsRepository({Dio dio}) : _dio = dio ?? Dio(); //no idea what this line is supposed to mean

  Future<Directions> getDirections({@required LatLng origin, @required LatLng destination,}) async {
    final response = await _dio.get(
      _baseURL,
      queryParameters: {
        'origin': '${origin.latitude},${origin.longitude}',
        'destination': '${destination.latitude}, ${destination.longitude},',
        'key': 'AIzaSyAK6ZnJUF2IqiyeyccoqX215Tm-SoLFc7E',
      },
    );

    if (response.statusCode == 200) {
      return Directions.fromMap(response.data);
    }
    return null;
  }
}