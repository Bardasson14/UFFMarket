import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uff_market/auth.dart';

Color uffBlue = const Color(0xff005AAE);
String dropdownValueLoc;
String dropdownValueCat;
final productNameTFController = TextEditingController();
final productDescriptionTFController = TextEditingController();
final productPriceTFController = TextEditingController();
var db = Firestore.instance;

class Product {
  String productName;
  String productDescription;
  String productLocation;
  String productPrice;
  String productSeller;
  String productCategory;

  Product({this.productName, this.productDescription, this.productLocation, this.productPrice, this.productSeller, this.productCategory});

  String getName(){
    return this.productName;
  }

  String getDescription(){
    return this.productDescription;
  }

  String getLocation(){
    return this.productLocation;
  }

  String getPrice(){
    return this.productPrice;
  }

  String getSeller(){
    return this.productSeller;
  }

  String getCategory(){
    return this.productCategory;
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

  void setPrice(String price){
    this.productPrice = price;
  }

  void setSeller(String seller){
    this.productSeller = seller;
  }

  void setCategory(String category){
    this.productCategory = category;
  }

  createData(){
    DocumentReference dr = Firestore.instance.collection('products').document();
    Map <String, dynamic> product = {
      "productDescription": productDescription,
      "productLocation": productLocation,
      "productName": productName,
      "productPrice": productPrice,
      "productSeller": productSeller,
      "productCategory": productCategory
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
                padding: EdgeInsets.all(height/4),
                child: ProductName(),
              ),

              Padding(
                padding: EdgeInsets.all(height/4),
                child: 
                ProductDescription()
              ),

              Padding(
                padding: EdgeInsets.all(height/4),
                child: ProductPrice(),
              ),
              
              Padding(
                padding: EdgeInsets.symmetric(vertical: height/3),
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
                        value: dropdownValueLoc,
                        hint: Text("Escolha o local de venda do produto"),
                        icon: Icon(Icons.arrow_downward),
                        iconSize: 22,
                        onChanged: (newValue){
                          setState(() {
                            dropdownValueLoc = newValue;
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
              Padding(
                padding: EdgeInsets.symmetric(vertical: height/3),
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
                        value: dropdownValueCat,
                        hint: Text("Escolha a categoria do produto"),
                        icon: Icon(Icons.arrow_downward),
                        iconSize: 22,
                        onChanged: (newValue){
                          setState(() {
                            dropdownValueCat = newValue;
                          }); 
                        }, 
                        items: <String>['Doces', 'Salgados', 'Refeições', 'Serviços', 'Outros Produtos'
                        ].map<DropdownMenuItem<String>>((String value){
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
                  String name = productNameTFController.text;
                  String description = productDescriptionTFController.text;
                  String price = (productPriceTFController.text);
                  String location = dropdownValueLoc;
                  String category = dropdownValueCat;
                  String uid = await authService.getUID();
                  Product p = Product(productDescription: description, productLocation: location, productName: name, productPrice: price, productSeller: uid, productCategory: category);
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
            //shrinkWrap: true,
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

class ProductScreen extends StatefulWidget{

  
  @override
  State<StatefulWidget> createState() {
    return ProductScreenState();
  }
}

class ProductScreenState extends State<ProductScreen>{
  static String filter;
  Future _data;

  @override
  void initState(){
    super.initState();
    _data = getPosts();
  }
  
  Future getPosts() async{
    var firestore = Firestore.instance;
    QuerySnapshot qs = await firestore.collection("products")/*.where('productCategory', isEqualTo: filter)*/.getDocuments();
    return qs.documents;
  }

  navigatetoDetail(DocumentSnapshot post){
    Navigator.push(context, MaterialPageRoute(
        builder: (context){
          return DetailPage(post: post);
        }
      ) 
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: uffBlue,
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
        child: FutureBuilder(
            future: _data,
            builder: (_, snapshot){
              if (!snapshot.hasData)
                return Center(
                  child: Text("Loading")
                );
              else{
                return ListView.builder(  
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  itemBuilder: (_, index){
                    return ListTile(
                      title: Text(snapshot.data[index].data['productName']),
                      subtitle: Text(snapshot.data[index].data['productLocation']),
                      trailing: Text(snapshot.data[index].data['productPrice'].toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w800
                        ),),
                        onTap: (){
                          navigatetoDetail(snapshot.data[index]);
                      }
                  );
              });
            
              }
          }),
        )
    
    );
  }
}

class DetailPage extends StatefulWidget{

  final DocumentSnapshot post;
  
  DetailPage({this.post});

  @override
  State<StatefulWidget> createState() {
    return DetailPageState();
  } 
}

class DetailPageState extends State<DetailPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: uffBlue,
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
        child: Center(
          child: Column(
            children: <Widget>[
              Text(widget.post.data['productName']),
              /*Row(children: <Widget>[
                Text(widget.post.data['productPrice'],
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize:25
                  ),),
                Text(widget.post.data['productLocation']),
              ],),
              */
              Text(widget.post.data['productDescription']),
              ],
            ),
          ),
        ),
      );
  }
}