import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:rflutter_alert/rflutter_alert.dart';

class ConstantClass {
    static String userName = "";
    static const baseUrl = "https://jsonplaceholder.typicode.com/posts";

    static Future getData() {
        return http.get(baseUrl);
    }

    static void notificationSignIN(context){
        Alert(
            context: context,
            type: AlertType.warning,
            title: "Sign In ",
            desc: "Your email is incorrect please try again",
        ).show();
    }

    static void notificationLog(context){
        Alert(
            context: context,
            type: AlertType.warning,
            title: "Sign Up ",
            desc: "You Don't Have Account , Please Creat new account ",
        ).show();
    }

}