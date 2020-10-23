import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailData extends StatefulWidget {
  DetailData({this.subject, this.details, this.notificationID});
  final String subject ;
  final String details;
  final int notificationID;

  @override
  _DetailDataState createState() => _DetailDataState();
}
var run = true;

class _DetailDataState extends State<DetailData> {
  var runbefore = true;

  @override
  void dispose() {
    run = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final DetailData args = ModalRoute
        .of(context)
        .settings
        .arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Details of ${args.notificationID}', style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Builder(
        builder: (context) =>
            SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 250.0),
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Text(args.subject, style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20),textAlign: TextAlign.center,),
                        Text(args.details, style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
      ),
    );
  }
}

