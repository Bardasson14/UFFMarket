import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uff_market/auth.dart';

Color uffBlue = const Color(0xff005AAE);
String dropdownValue;

class Product {
  String productName;
  String productDescription;
  String productLocation;
  double productPrice;
  String productSeller;

  Product({this.productName, this.productDescription, this.productLocation, this.productPrice, this.productSeller});

  String getName(){
    return this.productName;
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

  createData(){
    DocumentReference dr = Firestore.instance.collection('products').document();
    Map <String, dynamic> product = {
      "productDescription": productDescription,
      "productLocation": productLocation,
      "productName": productName,
      "productPrice": productPrice,
      "productSeller": productSeller
    };

    dr.setData(product).whenComplete((){
      print("Product added to Firestore");
    });
  } 
 }

class ProductName extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return ProductNameState();
  }

}

class ProductNameState extends State<ProductName>{
  final productNameTFController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: productNameTFController,
      decoration: InputDecoration(
        hintText: "Nome do Produto..",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    );
  }
  
}

class ProductDescription extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return ProductDescriptionState();
  }

}

class ProductDescriptionState extends State<ProductDescription>{
  final productDescriptionTFController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: productDescriptionTFController,
      maxLines: null,
      decoration: InputDecoration(
        hintText: "Descrição do Produto..",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    );
  }
  
}

class ProductPrice extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return ProductPriceState();
  }
}

class ProductPriceState extends State<ProductPrice>{
  final productPriceTFController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: productPriceTFController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: "Preço do Produto",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
        )
      ),
    );
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
    Product p;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: uffBlue,
        title: Text("Vender Produtos",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25)),
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
              Padding(
                padding: EdgeInsets.all(height/3),
                child: ProductName(),
              ),

              Padding(
                padding: EdgeInsets.all(height/3),
                child: 
                ProductDescription()
              ),

              Padding(
                padding: EdgeInsets.all(height/3),
                child: ProductPrice(),
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
                        onChanged: (newValue){
                          setState(() {
                            dropdownValue = newValue;
                          }); 
                        }, 
                        items: <String>['Gragoatá', 'Praia Vermelha', 'IACS', 'Valonguinho',
                          'Direito'].map<DropdownMenuItem<String>>((String value){
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
                onPressed: () async{
                  p.setDescription(ProductDescriptionState().productDescriptionTFController.text);
                  p.setName(ProductNameState().productNameTFController.text);
                  p.setLocation(dropdownValue);
                  p.setPrice(double.tryParse(ProductPriceState().productPriceTFController.text));
                  p.setSeller(null);
                  p.createData();
                },
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