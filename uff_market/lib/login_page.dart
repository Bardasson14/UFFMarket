import 'package:flutter/material.dart';
import 'package:uff_market/auth.dart';
import 'package:uff_market/main.dart';

Color uffBlue = const Color(0xff005AAE);
    
class LoginPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: uffBlue,
      body: Center(
          child: loginButton(context), 
        )
      );
 }

  Widget loginButton (BuildContext context){
    return MaterialButton(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      splashColor: Colors.black,
      child: Text(
        "Entre aqui com sua conta Google",
        style: TextStyle(
          color: uffBlue,
        ),),
      onPressed: (){
        
        authService.handleSignIn().whenComplete((){
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context){
                return HomePage();
              }
            )
          );
        });
      },      
    );
  }
}

