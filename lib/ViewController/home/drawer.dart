import 'package:flutter/material.dart';
import 'package:moayed_flutterapp/ViewController/auth/auth.dart';
import 'package:moayed_flutterapp/loader/Loader.dart';
import 'package:moayed_flutterapp/loader/dot_type.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDrawer extends StatefulWidget {
  @override
  AppDrawerState createState() => AppDrawerState();
}

class AppDrawerState extends State<AppDrawer> {
  String userName = "";
  String userName1 = "";


  Future<String> getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString('userName') ;
    if(stringValue == null)
      stringValue = "0";
    print("Shared Preferences in getString= $stringValue");
    setState(()  {
      userName = stringValue;
    });
    return stringValue;
  }


  removeValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Remove String
    prefs.remove("userID");
  }

  @override
  void initState() {
    getStringValuesSF();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      // Navigator.pop(context);
                      // Navigator.pushNamed(context, '/myAccount');
                    },
                    child: Container(
                      height: 90,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                              colors: [Colors.black, Colors.black])),
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage:
                        AssetImage("assets/images/drawer-header.jpg"),
                      ),
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Container(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 28.0, right: 25.0),
                      child: Row(
                        children: <Widget>[
                             Text(
                              "Hi $userName",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w600),
                            ),
                        ],
                      ),
                    ),
                  ),
                  //SizedBox(height: 30.0),
                ],
              ),

              ListTile(
                leading: Icon(Icons.home, color: Theme
                    .of(context)
                    .accentColor),
                title: Text('Home'),
                onTap: () {
                  //Navigator.pop(context);
                  Navigator.pushNamed(context, '/Home');
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.lock_outline,
                    color: Theme
                        .of(context)
                        .accentColor),
                title: Text("Logout"),
                onTap: () {
                  removeValues();
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, "/auth");
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}
