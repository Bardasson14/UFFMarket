import 'package:flutter/material.dart';
import 'seller.dart';

class Product {
  String productName, description;
  double price;
  Image image;

  String getProductName(){
    return this.productName;
  }

  String getDescription(){
    return this.description;
  }

  double getPrice(){
    return this.price;
  }

  Image getImage(){
    return this.image;
  }

}

class ChooseBetween extends StatelessWidget{
  
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width * 0.4;
    var height = MediaQuery.of(context).size.height * 0.15;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xff005AAE),
          title: Text(
            "UFF Market",
            style: TextStyle(
              decoration: TextDecoration.none,
              fontFamily: 'Quicksand',
              fontSize: 25,
            ),
          ),
          centerTitle: true,
        ),
        drawer: Drawer(

        ),
        body: Container(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[

              Padding(
                padding: EdgeInsets.only(top: height/2),
              ),

              MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  onPressed: () => {},
                  minWidth: width,
                  height: height,
                  color: const Color(0xff005AAE),
                  child: Text(
                    "Doces",
                    style: TextStyle(
                      fontFamily: 'Quicksand',
                      fontSize: 20,
                      color: Colors.white
                      )
                    ),
              ),

              Padding(
                padding: EdgeInsets.only(top: height/2),
              ),

              MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  onPressed: () => {},
                  minWidth: width,
                  height: height,
                  color: const Color(0xff005AAE),
                  child: Text(
                    "Salgados",
                    style: TextStyle(
                      fontFamily: 'Quicksand',
                      fontSize: 20,
                      color: Colors.white
                      )
                    ),
              )
            ]
          ),
        ),
    );
  }
}

class ProductScreen extends StatelessWidget{
  Product p;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width * 0.4;
    var height = MediaQuery.of(context).size.height * 0.15;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xff005AAE),
          title: Text(
            "UFF Market",
            style: TextStyle(
              decoration: TextDecoration.none,
              fontFamily: 'Quicksand',
              fontSize: 25,
            ),
          ),
          centerTitle: true,
        ),
        drawer: Drawer(

        ),
         
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              
              Row(children: <Widget>[
                Text(
                  p.getProductName(),
                  style: TextStyle(

                  ),
                ),
                Text(
                  p.getPrice().toString(),
                  style: TextStyle(

                  ),
                )
              ],),
              Text(
                p.getDescription(),
                style: TextStyle(

                ),
              ),
              
            ],
          )
        ),
    );
  } 
}