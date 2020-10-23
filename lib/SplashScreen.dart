import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'loader/Loader.dart';
import 'loader/dot_type.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String userID = "";

  Future<String> getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString('userID') ;
    if(stringValue == null)
      stringValue = "0";
    print("Shared Preferences in Splash Screen getString= $stringValue");
    return stringValue;
  }

  startTime() async {
    userID = await getStringValuesSF();
    var _duration = new Duration(seconds: 5);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    if(userID == "0")
      Navigator.of(context).pushReplacementNamed('/auth');
    else
      Navigator.of(context).pushReplacementNamed('/Home');
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.black,
      // backgroundColor: Colors.brown.shade900,
      body: new Center(
        child: Padding(
          padding: const EdgeInsets.only(top:250.0),
          child: Column(
            children: [
              Container(
                padding:const EdgeInsets.only(right:25.0,left: 25.0 ),
                child: new Image.asset('assets/images/logo.gif'),
              ),
              Container(
                height: 150.0,
                width: double.infinity,
                child: Center(
                  child: ColorLoader(
                    dotOneColor: Colors.white,
                    dotTwoColor: Colors.white,
                    dotThreeColor: Colors.white,
                    dotIcon: Icon(Icons.adjust),
                    dotType: DotType.circle,
                    duration: Duration(seconds: 2),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
