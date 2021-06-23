import 'package:flutter/material.dart';
import 'package:nus_spots/authenticate_page.dart';
import 'package:nus_spots/home_page.dart';
import 'package:nus_spots/models/user.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<NUSer>(context);

    //return either home or authenticate screen
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
