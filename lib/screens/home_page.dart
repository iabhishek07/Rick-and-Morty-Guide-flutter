import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rickandmorty/constants.dart';
import 'dart:convert';
import 'package:rickandmorty/models/character_model.dart';
import 'package:rickandmorty/screens/character_detail.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var url = "https://rickandmortyapi.com/api/character/";
  Character character;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    var res = await http.get(url);
    var decodedJson = jsonDecode(res.body);

    character = Character.fromJson(decodedJson);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF202428),
      appBar: AppBar(
        backgroundColor: Color(0xFF202428),
        elevation: 0.0,
        title: Text("The Rick and Morty Guide", style: appbarStyle),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.lightbulb_outline),
            onPressed: () {},
          )
        ],
      ),
      body: character == null
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.yellow,
              ),
            )
          : ListView.builder(
              itemCount:
                  character.results == null ? 0 : character.results.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 150,
                  margin:
                      EdgeInsets.symmetric(vertical: 14.0, horizontal: 20.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CharDetail(
                            results: character.results[index],
                          ),
                        ),
                      );
                    },
                    child: Stack(
                      children: <Widget>[
                        Container(
                          height: 150.0,
                          margin: EdgeInsets.only(left: 46.0),
                          decoration: BoxDecoration(
                            color: Color(0xFF3B3F43),
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 10.0,
                                offset: Offset(0.0, 10.0),
                              ),
                            ],
                          ),
                          child: Container(
                            margin:
                                EdgeInsets.fromLTRB(105.0, 16.0, 16.0, 16.0),
                            constraints: BoxConstraints.expand(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  character.results[index].name,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontFamily: "Product-Sans",
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                Row(
                                  children: <Widget>[
                                    character.results[index].status == "Alive"
                                        ? Container(
                                            height: 12,
                                            width: 12,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.green,
                                            ),
                                          )
                                        : Container(
                                            height: 12,
                                            width: 12,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.red,
                                            ),
                                          ),
                                    SizedBox(width: 5),
                                    Text(
                                        "${character.results[index].status} - ${character.results[index].species}",
                                        style: wp14),
                                  ],
                                ),
                                SizedBox(
                                  height: 4.0,
                                ),
                                Text("Origin:", style: originText),
                                SizedBox(height: 5.0),
                                Expanded(
                                  child: Text(
                                      character.results[index].origin.name,
                                      style: originName),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          alignment: FractionalOffset.centerLeft,
                          child: Hero(
                            tag: character.results[index].image,
                            child: CircleAvatar(
                              radius: 60,
                              backgroundImage: NetworkImage(
                                character.results[index].image,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF202428),
        onPressed: () {},
        child: Icon(Icons.refresh),
      ),
    );
  }
}
