import 'package:flutter/material.dart';
import 'package:moayed_flutterapp/blocks/auth_block.dart';
import 'package:moayed_flutterapp/models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  @override
  SignUpState createState() => SignUpState();
}

class SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final User user = User();
  String confirmPassword;

  addStringToSF(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("user" , user.email);
    prefs.setString("userName" , user.userName);
    prefs.setString("userID" , "123");
  }

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
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please Enter Username';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          setState(() {
                            user.userName = value.trim();
                            print(value.replaceAll(new RegExp(r"\s+"), ""));
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter Username',
                          labelText: 'Username',
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
                            return 'Please Enter Email';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          setState(() {
                            user.email = value;
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
                            return 'Please Enter Mobile';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          setState(() {
                            user.mobile = value;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter Mobile',
                          labelText: 'Mobile',
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
                              user.password = value;
                            });
                          },
                          onChanged: (text) {
                            user.password = text;
                          },
                          decoration: InputDecoration(
                            hintText: 'Enter Password',
                            labelText: 'Password',
                          ),
                          obscureText: true),
                    ),
                  ),
                  Material(
                    child: TextFormField(validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter Confirm Password';
                        } else if (user.password != confirmPassword) {
                          return 'Password fields dont match';
                        }
                        return null;
                      },
                      onChanged: (text) {
                        confirmPassword = text;
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter Same Password',
                        labelText: 'Confirm Password',
                      ),
                      obscureText: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: Consumer<AuthBlock>(builder:
                          (BuildContext context, AuthBlock auth, Widget child) {
                        return RaisedButton(
                          color: Theme.of(context).primaryColor,
                          textColor: Colors.white,
                          child: auth.loading && auth.loadingType == 'register' ? CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ) : Text('Sign Up', style: TextStyle(fontSize: 20),),
                          onPressed: () {
                            if (_formKey.currentState.validate() && !auth.loading) {
                              _formKey.currentState.save();
                              addStringToSF(user);
                              Navigator.pushNamed(context, '/Home');
                            }
                          },
                        );
                      }),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
    );
  }
}
