import 'package:flutter/material.dart';
import 'package:uff_market/auth.dart';
import 'package:uff_market/main.dart';

Color uffBlue = const Color(0xff005AAE);
    
class LoginPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    _LoginPageState createState() => _LoginPageState();
  }
  
}

class _LoginPageState extends State<LoginPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: uffBlue,
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              logInButton()
            ],
          )
        )
      )
    );
  }

  Widget logInButton(){
    return OutlineButton(
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      child: Text(
        "Entre aqui com sua conta Google",
        style: TextStyle(
          color: Colors.white,
        ),
      ),

    );
  }
  
}

