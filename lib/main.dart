import 'package:flutter/material.dart';
import 'package:moayed_flutterapp/SplashScreen.dart';
import 'package:moayed_flutterapp/ViewController/home/detailData.dart';
import 'ViewController/auth/auth.dart';
import 'ViewController/auth/signin.dart';
import 'ViewController/auth/signup.dart';
import 'package:provider/provider.dart';
import 'ViewController/home/home.dart';
import 'blocks/auth_block.dart';

void main() {
  runApp(
      MultiProvider(
    providers: [ChangeNotifierProvider<AuthBlock>.value(value: AuthBlock())],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.black,
          accentColor: Colors.black,
      ),
      initialRoute: '/splashScreen',
      routes: <String, WidgetBuilder>{
        '/Home': (BuildContext context) => Home(),
        '/splashScreen':(BuildContext context) => SplashScreen(),
        '/signIn':(BuildContext context)=> SignIn(),
        '/signup':(BuildContext context)=> SignUp(),
        '/auth':(BuildContext context)=> Auth(),
        '/detailData':(BuildContext context)=> DetailData(),

      },
    ),
  ));
}

