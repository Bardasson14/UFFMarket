import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'products.dart';

Color uffBlue = const Color(0xff005AAE);

Future<FirebaseUser> getUser() async {
  return await FirebaseAuth.instance.currentUser();
}

class User {
  String uid;
  String name;
  String email;
  String photoURL;

  User({this.uid, this.name, this.email, this.photoURL});
/*
  User.fromJson(Map json) {
    this.uid = json["uid"];
    this.name = json["displayName"];
    this.email = json["email"];
    this.photoURL = json["photoURL"];;
  }*/
}

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProfilePageState();
  }
}

class ProfilePageState extends State<ProfilePage> {
  var user = getUser();
  static String filter;
  Future _data;

  @override
  void initState() {
    super.initState();
    _data = getPosts();
  }

  Future getPosts() async {
    var firestore = Firestore.instance;
    var currentUser = await FirebaseAuth.instance.currentUser();
    String uid = await currentUser.uid;
    QuerySnapshot qs = await firestore
        .collection("products")
        .where("productSeller", isEqualTo: uid)
        .getDocuments();
    return qs.documents;
  }

  navigatetoDetail(DocumentSnapshot post, BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return DetailPage(post: post);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: uffBlue,
          title: Text("Vender Produtos",
              style: TextStyle(color: Colors.white, fontSize: 25)),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
        ),
        body: Container(
            child: FutureBuilder(
                future: user,
                builder: (_, snapshot) {
                  if (!snapshot.hasData)
                    return Center(
                      child: Text("ERROR 404! USER NOT FOUND"),
                    );
                  else {
                    var height = MediaQuery.of(context).size.height;
                    var width = MediaQuery.of(context).size.width;

                    return SingleChildScrollView(
                        child: Column(children: <Widget>[
                      SizedBox(
                          height: height / 5,
                          width: width,
                          child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    snapshot.data.displayName,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 18),
                                  ),
                                  Text(
                                    snapshot.data.email,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 15),
                                  ),
                                ],
                              ))),
                      Text(
                        '\nSeus Produtos',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 30),
                      ),
                      FutureBuilder(
                          future: _data,
                          builder: (_, snapshot) {
                            if (!snapshot.hasData)
                              return Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Center(child: Text("Loading")));
                            else {
                              return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (_, index) {
                                    return ListTile(
                                        title: Text(snapshot
                                            .data[index].data['productName']),
                                        subtitle: Text(snapshot.data[index]
                                            .data['productLocation']),
                                        trailing: Text(
                                          'R\$ ' +
                                              snapshot.data[index]
                                                  .data['productPrice'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.w800),
                                        ),
                                        onLongPress: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  AlertDialog(
                                                    //title: Text("Opções"),
                                                    content: SizedBox(
                                                        height: 50,
                                                        width: 80,
                                                        child: ListView(
                                                          children: <Widget>[
                                                            ListTile(
                                                                leading: Text(
                                                                  'Remover',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          18),
                                                                ),
                                                                trailing: Icon(
                                                                    FontAwesomeIcons
                                                                        .trash),
                                                                onTap: () {
                                                                  Firestore
                                                                      .instance
                                                                      .collection(
                                                                          'products')
                                                                      .document(snapshot
                                                                          .data[
                                                                              index]
                                                                          .data['productID'])
                                                                      .delete();
                                                                  Navigator.pop(
                                                                      context);
                                                                  Navigator.pushReplacement(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              ProfilePage()));
                                                                })
                                                          ],
                                                        )),
                                                  ));
                                        },
                                        onTap: () {
                                          navigatetoDetail(
                                              snapshot.data[index], context);
                                        });
                                  });
                            }
                          }),
                    ]));
                  }
                })));
  }
}
