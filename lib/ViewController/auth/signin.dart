import 'package:moayed_flutterapp/Helper/Constants.dart';
import 'package:moayed_flutterapp/blocks/auth_block.dart';
import 'package:moayed_flutterapp/models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final User userCredential = User();

   void getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString('user') ;
    prefs.setString("userID" , "123");
    if(stringValue == null)
      ConstantClass.notificationLog(context);
    else
      if(stringValue == userCredential.email)
        Navigator.pushNamed(context, '/Home');
      else{
        ConstantClass.notificationSignIN(context);
      }

  }

  // addStringToSF(User user) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   print("Shared Preferences in SignIn setString= $user");
  //   prefs.setString("user" , user.email);
  // }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Material(
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter Email';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          setState(() {
                            userCredential.email = value;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter Email',
                          labelText: 'Email',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Material(
                        child: TextFormField(
                            validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter Password';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        setState(() {
                          userCredential.password = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter Password',
                        labelText: 'Password',
                      ),
                      obscureText: true,
                        ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: Consumer<AuthBlock>(
                        builder:
                            (BuildContext context, AuthBlock auth, Widget child) {
                          return RaisedButton(
                            color: Colors.black,
                            textColor: Colors.white,
                            child: auth.loading && auth.loadingType == 'login' ? CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ) : Text('Sign In', style: TextStyle(fontSize: 20),),
                            onPressed: () {
                              if (_formKey.currentState.validate() && !auth.loading) {
                                _formKey.currentState.save();
                                getStringValuesSF();
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }
}
