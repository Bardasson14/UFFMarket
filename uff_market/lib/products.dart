import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_modern/image_picker_modern.dart';
import 'package:uff_market/auth.dart';
import 'package:path/path.dart';


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
  String pictureID;

  Product({this.productName, this.productDescription, this.productLocation, this.productPrice, this.productSeller, this.productCategory, this.pictureID});

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

  String getPictureID(){
    return this.pictureID;
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

  void setPictureID(String pictureID){
    this.pictureID = pictureID;
  }

  createData(){
    DocumentReference dr = Firestore.instance.collection('products').document();
    Map <String, dynamic> product = {
      "productDescription": productDescription,
      "productLocation": productLocation,
      "productName": productName,
      "productPrice": productPrice,
      "productSeller": productSeller,
      "productCategory": productCategory,
      "pictureID": pictureID
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

  static File _image; 

  Future<String> uploadPic(BuildContext context) async{
    String fileName = basename(_image.path);
    StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    return fileName;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width * 0.4;
    var height = MediaQuery.of(context).size.height * 0.15;
    AddPictureState.height = height/2;
    AddPictureState.width  = width;
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
                padding: EdgeInsets.all(height/6),
                child: ProductName(),
              ),

              Padding(
                padding: EdgeInsets.all(height/6),
                child: 
                ProductDescription()
              ),

              Padding(
                padding: EdgeInsets.all(height/6),
                child: ProductPrice(),
              ),

              Padding(
                padding: EdgeInsets.all(height/6),
                child: AddPicture(),
              ),

              Padding(
                padding: EdgeInsets.symmetric(vertical: height/6),
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
                  String pictureID = await uploadPic(context);
                  String description = productDescriptionTFController.text;
                  String price = (productPriceTFController.text);
                  String location = dropdownValueLoc;
                  String category = dropdownValueCat;
                  String uid = await authService.getUID();
                  Product p = Product(productDescription: description, productLocation: location, productName: name, productPrice: price, productSeller: uid, productCategory: category, pictureID: pictureID);
                  p.createData();
                  //Scaffold.of(context).showSnackBar(SnackBar(content: Text("Produto vendido!")));
                  productDescriptionTFController.text = "";
                  productNameTFController.text = "";
                  productPriceTFController.text = "";
                  dropdownValueLoc = "Gragoatá";
                  dropdownValueCat = "Doces";
                  pictureID = "";
                  Navigator.pop(context, true);
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

class AddPicture extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return AddPictureState();
  }
}

class AddPictureState extends State<AddPicture>{

  Future<File> getImage() async{
    var image = await ImagePicker.pickImage(
      source: ImageSource.gallery
    );
    return image;
  }

  @override
  static double width, height;
  Widget build(BuildContext context) {
    return MaterialButton(
      color: uffBlue,
      shape: RoundedRectangleBorder(
        side: BorderSide(width:1, style: BorderStyle.solid),
        borderRadius: BorderRadius.all(Radius.circular(15))
      ),
      height: height,
      minWidth: width,
      onPressed: () async{
        SellProductState._image = await getImage();
      },
      child: Row(
        children: <Widget>[
        Icon(Icons.add,  
          color: Colors.white),
        Padding(
          padding: EdgeInsets.symmetric(horizontal:30),
        ),
        Text(
          "Adicionar imagem",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20
            ),
          ),
        ],
      )
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
                  onPressed: () => {
                    ProductScreenState.filter = "Doces",
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProductScreen())
                    )
                  },
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
                  onPressed: () => {
                    ProductScreenState.filter = "Salgados",
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProductScreen())
                    )
                  },
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
              ),
              
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
    QuerySnapshot qs = await firestore.collection("products").where('productCategory', isEqualTo: filter).getDocuments();
    return qs.documents;
  }

  navigatetoDetail(DocumentSnapshot post, BuildContext context){
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
                      trailing: Text('R\$ ' + snapshot.data[index].data['productPrice'],
                        style: TextStyle(
                          fontWeight: FontWeight.w800
                        ),),
                        onTap: (){
                          navigatetoDetail(snapshot.data[index], context);
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
  
  Future<String> getURL(StorageReference ref) async{
    var url = await ref.getDownloadURL();
    print(url.toString());
    return url;
  }
  
  @override
  Widget build(BuildContext context) {
    StorageReference ref = FirebaseStorage.instance.ref().child("${widget.post.data['pictureID']}");
    Future<String> url = getURL(ref).whenComplete((){
      print("ok");
    });
    var height = MediaQuery.of(context).size.height * 0.15;
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
      child: SingleChildScrollView(
            child: Column(
              
              children: <Widget>[

                FutureBuilder(
                  future: url,
                  builder: (_, snapshot){
                    if (!snapshot.hasData)
                      return Container(
                        color: Colors.grey,
                        child: Container(
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                          ),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height/2,
                            
                            child: Center(
                              child: Text("Sem Imagens disponíveis",
                              style: TextStyle(
                                fontSize: 20,
                              ),)
                            )
                          ))
                        );
                    else{
                      return SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height/2,
                          child: Container(
                            decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                              ),
                            ),
                            child: Image.network(snapshot.data))
                          );
                      
                    }
                  }
                ),
                
                Padding(
                  padding: EdgeInsets.all(height/4),
                  child: Column(
                    children: <Widget>[ 
                      Text(
                        widget.post.data['productName'],
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      
                      Text(
                        'R\$ ' + widget.post.data['productPrice'],
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize:20
                        ),),
                    ]
                  )
                ),
                
                  /*Padding(
                    padding: EdgeInsets.all(height/4),
                    child: ),*/

                  Row(children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(height/5),
                        child:  Text(widget.post.data['productLocation'],
                          style: TextStyle(
                            fontSize: 18,
                    ),)
                  ),

                    Flexible(
                      //padding: EdgeInsets.all(height/4),
                        child:  Padding(
                          padding: EdgeInsets.all(height/5),
                          child: Text(widget.post.data['productDescription'],
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                    ),))
                  ),
                    ],
                  )
                ],
              ),
            ),
          ),
        
      );
  }
}