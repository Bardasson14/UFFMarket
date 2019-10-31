import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_modern/image_picker_modern.dart';
import 'package:uff_market/auth.dart';
import 'package:path/path.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';


Color uffBlue = const Color(0xff005AAE);
String dropdownValueLoc;
String dropdownValueCat;
final productNameTFController = TextEditingController();
final productDescriptionTFController = TextEditingController();
final productPriceTFController = TextEditingController();
var db = Firestore.instance;

class utils {
    static final Random _random = Random.secure();

    static String CreateCryptoRandomString([int length = 32]) {
        var values = List<int>.generate(length, (i) => _random.nextInt(256));

        return base64Url.encode(values);
    }
}

class Product {
  String productID;
  String productName;
  String productDescription;
  String productLocation;
  String productPrice;
  String productSeller;
  String productCategory;
  String pictureID;
  double avgScore;
  int scoresGiven;

  Product({this.productID, this.productName, this.productDescription, this.productLocation, this.productPrice, this.productSeller, this.productCategory, this.pictureID, this.avgScore, this.scoresGiven});

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

  createData(String id){
    DocumentReference docRef = Firestore.instance.collection('products').document(id);
    Map <String, dynamic> product = {
      "productID": productID,
      "productDescription": productDescription,
      "productLocation": productLocation,
      "productName": productName,
      "productPrice": productPrice,
      "productSeller": productSeller,
      "productCategory": productCategory,
      "pictureID": pictureID,
      "avgScore": avgScore,
      "scoresGiven": scoresGiven
    };
   
   docRef.setData(product).whenComplete((){
     print("Product added to firestore");
   });
  } 

  Product.fromJson(Map json){
    this.productID = json["productID"];
    this.productDescription = json["productDescription"];
    this.productLocation = json["productLocation"];
    this.productName = json["productName"];
    this.productPrice = json["productPrice"];
    this.productSeller = json["productSeller"];
    this.productCategory = json["productCategory"];
    this.avgScore = double.parse(json["avgScore"].toString());
    this.scoresGiven =int.parse(json["scoresGiven"].toString());
    this.pictureID = json["pictureID"];
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
                  String description = productDescriptionTFController.text;
                  String price = (productPriceTFController.text);
                  String location = dropdownValueLoc;
                  String category = dropdownValueCat;
                  String uid = await authService.getUID();
                  int scoresGiven = 0;
                  double avgScore = 0;
                  String id = utils.CreateCryptoRandomString(20);
                  String pictureID = await uploadPic(context);
                  Product p = Product(productID: id, productDescription: description, productLocation: location, productName: name, productPrice: price, productSeller: uid, productCategory: category, pictureID: pictureID, scoresGiven: scoresGiven, avgScore: avgScore);
                  p.createData(id);
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



class Rating{
  String uid;
  String productID;
  double rating;

  Rating({this.uid, this.productID, this.rating});

  String createData(){
    DocumentReference dr = Firestore.instance.collection('ratings').document();
    Map <String, dynamic> r = {
      "productID": productID,
      "uid": uid, 
      "rating": rating
    };

    dr.setData(r).whenComplete((){
      print("Rating added to Firestore");
    });
  }

  Rating.fromJson(Map json){
    this.productID = json["productID"];
    this.uid = json["uid"];
    this.rating = double.parse(json["rating"].toString());
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

  static String productID; 
  
  Future<String> getURL(StorageReference ref) async{
    var url = await ref.getDownloadURL();
    print(url.toString());
    return url;
  }


  @override
  Widget build(BuildContext context) {
    productID = widget.post.data['productID'];
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
                
                SmoothStarRating(
                  
                    rating: (widget.post.data['avgScore']),
                    color: uffBlue,
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
                  ),

                  RaisedButton(
                      color: uffBlue,
                      onPressed: (){
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: Text("Nota"),
                            content: StarRating(),
                          )
                        );
                      },
                      child: Text(
                        "Avalie o Produto",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20
                        ),
                      )
                    ),
                ],
              ),
            ),
          ),
        
      );
  }
}

class StarRating extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return StarRatingState();
  }
}

class StarRatingState extends State<StarRating>{

  double v=2;
  static double rating=3;
  static String productID;
  CollectionReference ratingsRef = db.collection("ratings");
  CollectionReference productsRef = db.collection("products");
  double totalScore = 0.0;

  Future<double> qs2 = db.collection("ratings")
          .where("productID", isEqualTo: productID).getDocuments().then((qs2){
            double tS = 0;
            for (DocumentSnapshot doc in qs2.documents){
              Rating r = Rating.fromJson(doc.data);
              /*print("r[uid] = " + r.uid);
              print("r[productID] = " + r.productID);
              print("r[rating] = " + r.rating.toString());*/
              tS += r.rating; 
            }
            return tS;
    });
        
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 80,
      child: Column(children: <Widget>[
        SmoothStarRating(
          rating: rating,
          allowHalfRating: true,
          starCount: 5,
          size: 40.0,
          color: uffBlue,
          borderColor: uffBlue,
          spacing:0.0,
          onRatingChanged: (v){
            setState((){rating = v;});
          } ,
        ),
        Padding(
          padding: EdgeInsets.all(5),
        ),
        RaisedButton(
          color: uffBlue,
          child: Text("Enviar!",
            style: TextStyle(color: Colors.white)),
          onPressed: () { 
            setRating(rating, DetailPageState.productID);
            Navigator.pop(context);
            //DetailPage(post: );
          },
        )
      ],)
    );
  }

  setRating(double rating, productID) async{
    String uid = await authService.getUID();
    bool inDB = false;
    double sum = await qs2;
        
    setState(() {
        StarRatingState.rating = rating;
        
        Future<QuerySnapshot> qs1 = db.collection("ratings")
          .where("productID", isEqualTo: productID)
          .where("uid", isEqualTo: uid).getDocuments().then((qs1){
              //SE A AVALIAÇÃO NÃO ESTIVER NA TABELA, CRIAR RATING
              if (qs1.documents.isEmpty){
                Rating r = Rating(rating: rating, uid: uid, productID: productID);
                r.createData();
              }
              //SE A AVALIAÇÃO ESTIVER NO FIRESTORE, APENAS MODIFICÁ-LA
              else {
                inDB = true;
                for (DocumentSnapshot doc in qs1.documents){
                  Map <String, dynamic> r = {
                    "productID": productID,
                    "uid": uid, 
                    "rating": rating
                  };
                  db.collection("ratings").document(doc.documentID).updateData(r);
                }
              }
            }
          );

        this.totalScore = 0;
        
        
        print("sum = " + sum.toString());
        db.collection("products").where("productID", isEqualTo: productID).getDocuments().then(
          (querySnapshot) {
          for (DocumentSnapshot doc in querySnapshot.documents){
            Product p = Product.fromJson(doc.data);
              //if (inDB == false) p.scoresGiven ++;
              
              //print(this.totalScore.toString());
              p.avgScore = double.parse((sum / p.scoresGiven).toStringAsFixed(2));
              print("this.totalScore = " + this.totalScore.toString());
        
              Map<String, dynamic> mapProduct = {
                "productName": p.getName(),
                "productDescription": p.getDescription(),
                "productCategory": p.getCategory(),
                "productPrice": p.getPrice(),
                "productSeller": p.getSeller(),
                "productLocation": p.getLocation(),
                "avgScore": p.avgScore,
                "scoresGiven": p.scoresGiven,
                "pictureID": p.pictureID
              };

              db.collection("products").document(doc.documentID).updateData(mapProduct).whenComplete((){
                print(mapProduct["avgScore"]);
                print("modificated\n");
              });}
          });
      });
      
  }
}