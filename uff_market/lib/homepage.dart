import 'package:flutter/material.dart';


class HomepageBody extends StatelessWidget{
  
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width * 0.4;
    var height = MediaQuery.of(context).size.height * 0.15;
    
    return Container(
      child: Column(
        children: <Widget>[
          
          new Padding(
            padding: EdgeInsets.all(height/2),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Pesquise aqui um item específico...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
            ),
          ),
          
          new Expanded(
            child: ButtonGrid()
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
                onPressed: () => {},
                color: const Color(0xff005AAE),
                child: Text(
                  "Lanches e Doces",
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
              onPressed: () => {},
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
              onPressed: () => {},
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
              onPressed: () => {},
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