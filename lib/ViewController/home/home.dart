import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moayed_flutterapp/Helper/Constants.dart';
import 'package:moayed_flutterapp/loader/Loader.dart';
import 'package:moayed_flutterapp/loader/dot_type.dart';
import 'package:moayed_flutterapp/models/UsersData.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'detailData.dart';
import 'drawer.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() =>
      _HomeState();
}
var onlyOne = true;

class _HomeState extends State<Home> {
  List<UsersData> data;

  _getData() {
    ConstantClass.getData().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        data = list.map((model) => UsersData.fromJson(model)).toList();
      });
    });
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: ClipPath(
        clipper: OvalRightBorderClipper(),
        child: Container(
          width: 250.0,
          child: Drawer(
            child: AppDrawer(),
          ),
        ),
      ),
      backgroundColor: Colors.white70,
      appBar:buildAppBar(),

      body: DefaultTabController(
        length: 50,
        child: Container(
          height: MediaQuery
              .of(context)
              .size
              .height,
          width: MediaQuery
              .of(context)
              .size
              .width,
          child: Stack(
            children: <Widget>[
              Container(
                //padding: EdgeInsets.only(top: 100),
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
                width: double.infinity,
                child: buildBody(),

              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAppBar() {
    return  AppBar(
      iconTheme: IconThemeData(color:Colors.white),
      title: Text("MOAYAD", style: TextStyle(color: Colors.white ,fontWeight: FontWeight.bold), textAlign: TextAlign.center,),

    );
  }

  Widget buildBody() {
    if (data == null)
      return AbsorbPointer(
        child: Container(
            height: 50.0,
            width: double.infinity,
            child: Center(
              child: ColorLoader(
                dotOneColor: Colors.black,
                dotTwoColor: Colors.black,
                dotThreeColor: Colors.black,
                dotIcon: Icon(Icons.adjust),
                dotType: DotType.circle,
                duration: Duration(seconds: 2),
              ),)),
      );
    return DefaultTabController(
      length: 5000,
      child: SafeArea(
        child: Container(
          height: 500,
          width: double.infinity,
          child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return buildData(data[index]);
            },
          ),
        ),
      ),
    );
  }


  Widget buildData(UsersData data) {
    return Builder(
        builder: (BuildContext context) {
          return Container(
            width: 300.0,
            height: 100.0,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 8.0, vertical: 4.0),
              child: MaterialButton(
                padding: const EdgeInsets.all(0),
                elevation: 0.5,
                color: Colors.white,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                onPressed: () {
                  Navigator.pushNamed(
                      context, '/detailData',
                      arguments: DetailData(details:data.body , subject: data.title , notificationID: data.id,));
                },
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left:10.0 , right: 8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            "${data.id}",
                                            style: TextStyle(
                                             fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                              color: Colors.redAccent,
                                            ),
                                          ),
                                          Text(
                                            "User Id: ${data.userId}",
                                          ),
                                        ],
                                    ),
                                  ),
                                  Text(data.title,
                                    style: TextStyle(fontSize: 16.0),),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}