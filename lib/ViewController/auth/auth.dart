import 'package:flutter/material.dart';
import 'package:moayed_flutterapp/blocks/auth_block.dart';
import 'signin.dart';
import 'signup.dart';
import 'package:provider/provider.dart';

class Auth extends StatelessWidget {
  final List<Widget> tabs = [
    SignIn(),
    SignUp()
  ];
  @override
  Widget build(BuildContext context) {
    final AuthBlock authBlock = Provider.of<AuthBlock>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(authBlock.currentIndex == 0 ? 'Sign In' : 'Create Account'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // Navigator.pop(context);
          },
        ),

      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.lock_open),
            title: Text('Sign In'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline),
            title: Text('Create Account'),
          ),
        ],
        currentIndex: authBlock.currentIndex,
        selectedItemColor: Colors.black,
        onTap: (num){
           authBlock.currentIndex = num;
        },
      ),
      body: tabs[authBlock.currentIndex],
    );
  }
}