import 'package:flutter/material.dart';
import 'package:logindemo/HomePage.dart';
import 'package:logindemo/all_screens/signin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:logindemo/all_screens/signup.dart';
import 'package:logindemo/helper/authenticate.dart';
import 'package:logindemo/helper/helper_functions.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

 bool userIsLoggedIn=null;

 @override
  void initState() {
    getLoggedInState();
    super.initState();
  }

  getLoggedInState()async{
    await HelperFunctions.getUserLoggedInSharedPreference().then((value){
      setState(() {
        userIsLoggedIn=value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Something ",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0Xff1F1F1F),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Authenticate()  // userIsLoggedIn!=null?userIsLoggedIn?
     // HomePage():Authenticate():Container(child: Center(child: Authenticate(),),)
    );
  }
}
