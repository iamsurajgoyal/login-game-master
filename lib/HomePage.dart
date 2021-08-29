import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:logindemo/services/auth.dart';
import 'package:logindemo/widgets/widget.dart';
import 'package:http/http.dart' as http;

import 'helper/authenticate.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 AuthMethods authMethods=new AuthMethods();
  String stringResponse;
  Map mapResponse;
  List listOfTournaments;
  Future fetchData() async{
    http.Response response;
    response= await http.get(Uri.parse("http://tournaments-dot-game-tv-prod.uc.r.appspot.com/tournament/api/tournaments_list_v2?limit=10&status=all"));
    if (response.statusCode==200)
    {
       setState(() {
         mapResponse=jsonDecode(response.body);
         listOfTournaments=mapResponse['data']['tournaments'];
       });
    }
  }


 @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(  
      appBar:AppBar(
        title: Text("Midas Blue App"),
        actions: [
          GestureDetector(
            onTap: (){
              authMethods.signOut();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Authenticate()));
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.exit_to_app),
            ),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: 
      mapResponse==null?Container(): 
      SingleChildScrollView(
        child: Column(   
          crossAxisAlignment: CrossAxisAlignment.start,       
          children:[
            
            SizedBox(height: 20,),
            Container(                         
              margin: const EdgeInsets.all(10.0),
              width: 600,
              height: 100,
             // color: Colors.white,              
              child: Card(
                  clipBehavior:Clip.antiAlias,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),                
                  color: Colors.orange,
                child: Row(
                children: [
                  Container(decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.orange,Colors.yellow])),
                              width: 130,),
                  Container(color: Colors.purpleAccent,width: 120,),
                  Container(color: Colors.orange,width: 100,)
                ],
              ),)
            ),
            SizedBox(height: 30,),
            Padding(
              padding: EdgeInsets.only(left: 27),
              child: Text("Recommended for you", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap:true,
              itemBuilder:(context,index){              
              return Container(
                margin:EdgeInsets.all(15),                
                child:Card(
                  elevation:6,
                  clipBehavior:Clip.antiAlias,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                            Image.network(listOfTournaments[index]['cover_url']),
                        ],
                      ),
                       Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Text(listOfTournaments[index]['tournament_slug'].toString(),
                         style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), ),
                       ),
                       SizedBox(height: 10,),
                       Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Text(listOfTournaments[index]['name'].toString(), 
                         style: TextStyle(fontSize: 14, ),),
                       ),                      
                    ],
                  ),
                )
              );
            },
            itemCount: listOfTournaments==null?0:listOfTournaments.length,)
                                ]),
      )
    );
  }
}

