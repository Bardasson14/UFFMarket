import 'package:flutter/material.dart';

Color uffBlue = const Color(0xff005AAE);

class Product {
  String productID;
  String productName;
  String photoURL;
  String productDescription;
  String productLocation;
  double productPrice;
  String productSeller;

  String getID(){
    return this.productID;
  }

  String getName(){
    return this.productName;
  }

  String getPhotoURL(){
    return this.photoURL;
  }

  String getDescription(){
    return this.productDescription;
  }

  String getLocation(){
    return this.productLocation;
  }

  double getPrice(){
    return this.productPrice;
  }

  String getSeller(){
    return this.productSeller;
  }

  void setName(String name){
    this.productName = name;
  }

  void setPhotoURL(String url){
    this.photoURL = url;
  }

  void setDescription(String description){
    this.productDescription = description;
  }

  void setLocation(String location){
    this.productLocation = location;
  }

  void setPrice(double price){
    this.productPrice = price;
  }

  void setSeller(String seller){
    this.productSeller = seller;
  }
}

class SellProduct extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return SellProductState();
  }
}

class SellProductState extends State<SellProduct>{
  
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width * 0.4;
    var height = MediaQuery.of(context).size.height * 0.15;
    String dropdownValue;
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: uffBlue,
        title: Text("Vender Produtos",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25),),
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.arrow_back), 
        onPressed: (){
          Navigator.pop(context, true);
        },),
      ),

      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
               new Padding(
                padding: EdgeInsets.all(height/3),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Nome do Produto..",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
              ),

              new Padding(
                padding: EdgeInsets.all(height/3),
                child: TextField(
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: "Descrição do Produto..",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
              ),
              
              Padding(
                padding: EdgeInsets.symmetric(vertical: height/2),
                child:
                  Container(
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width:1, style: BorderStyle.solid),
                        borderRadius: BorderRadius.all(Radius.circular(15))
                      )
                    ),
                    child: 
                      DropdownButton<String>(
                        value: dropdownValue,
                        hint: Text("Escolha o local de venda do produto"),
                        icon: Icon(Icons.arrow_downward),
                        iconSize: 22,
                        //elevation: 14,
                        onChanged: (newValue){
                          setState(() {
                            dropdownValue = newValue;
                          });
                        },
                        items: <String>['Gragoatá', 'Praia Vermelha', 'IACS', 'Valonguinho',
                          'Gragoatá', 'Direito'].map<DropdownMenuItem<String>>((String value){
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                        }).toList(),
                    ),
                  ),
              ),
              MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                onPressed: () => {},
                minWidth: width,
                height: height/2,
                color: const Color(0xff005AAE),
                child: Text(
                  "Vender!",
                  style: TextStyle(
                    fontFamily: 'Quicksand',
                    fontSize: 20,
                    color: Colors.white
                    )
                  ),
                ),
            ],
          )
        )
      ),
    );
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
        /*drawer: Drawer(

        ),*/
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
                  p.getName(),
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