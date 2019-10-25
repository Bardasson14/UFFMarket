import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uff_market/auth.dart';
import 'login_page.dart';
import 'products.dart';

void main() => runApp(MainApp());



Color uffBlue = const Color(0xff005AAE);

class MainApp extends StatefulWidget{
  
  @override
  State<StatefulWidget> createState() {
    return _MainAppState();
  }  
}
 
class _MainAppState extends State<MainApp>{
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage()
    );
  }
}


class HomePage extends StatelessWidget{
  
  @override
  Widget build (BuildContext context){
    
    var width = MediaQuery.of(context).size.width * 0.4;
    var height = MediaQuery.of(context).size.height * 0.15;
    
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.all(20),
          children: <Widget>[
              ListTile(contentPadding: EdgeInsets.only(top:height/4),),
              ListTile(
                
                leading: Text("Sair",
                  style: TextStyle(
                    fontSize: 20,
                  ),),
                trailing: IconButton(icon: Icon(Icons.do_not_disturb_off, color: Colors.red,),
                onPressed: (){
                  authService.signOut();
                  Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context){
                      return LoginPage();
                    }
                )
              );
                },),
              )
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: const Color(0xff005AAE),
          title: Text(
            "UFF Market",
            style: TextStyle(
              decoration: TextDecoration.none,
              //fontFamily: 'Quicksand',
              fontSize: 25,
            ),
          ),
          centerTitle: true,
        ),
      body: Column(
      children: <Widget>[
        new Padding(
          padding: EdgeInsets.symmetric(vertical: height/3),
          child: FutureBuilder(
          future: FirebaseAuth.instance.currentUser(),
            builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
                if (snapshot.hasData) {
                  return Text("Bem vindo, " + snapshot.data.displayName.split(" ")[0] + "!",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600
                    ),);
                }
                else {
                  return Text('Loading...',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600
                    ),);
                }
            } 
          ),
        ),
        
       
        new Expanded(
          child: ButtonGrid()
        ),
         FloatingActionButton(
           backgroundColor: uffBlue,
           child: Icon(Icons.add,
            color: Colors.white,),
            onPressed: (){
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context){
                    return SellProduct();
                  }
                )
              );
            },
         )
        ],
      )  
    );
  }
}

class ButtonGrid extends StatelessWidget{

@override
Widget build(BuildContext context) {
  var width = MediaQuery.of(context).size.width * 0.4;
  var height = MediaQuery.of(context).size.height * 0.15;
  return GridView.count(
        childAspectRatio: width/height,
        padding: EdgeInsets.all(10),
        crossAxisCount: 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        children: <Widget>[
          SizedBox(
            width: width,
            height: height,
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChooseBetween()),
                )
              },
              color: const Color(0xff005AAE),
              child: Text(
                "Doces e Salgados",
                style: TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 20,
                  color: Colors.white
                  )
                ),
              ),
            ),
          MaterialButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            onPressed: () => {
              ProductScreenState.filter = "Refeições",
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProductScreen())
              )
            },
            minWidth: width,
            height: height,
            color: const Color(0xff005AAE),
            
            child: Text(
              "Refeições",
              style: TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 20,
                color: Colors.white
                )
              ),
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            onPressed: () => {
              ProductScreenState.filter = "Serviços",
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProductScreen())
              )
            },
            minWidth: width,
            height: height,
            color: const Color(0xff005AAE),
            child: Text(
              "Serviços",
              style: TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 20,
                color: Colors.white
                )
              ),
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            onPressed: () => {
              ProductScreenState.filter = "Outros Produtos",
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProductScreen())
              )
            },
            minWidth: width,
            height: height,
            color: const Color(0xff005AAE),
            child: Text(
              "Outros Produtos",
              style: TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 20,
                color: Colors.white
                )
              ),
            ),
      ],
    );
  }
}