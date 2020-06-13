import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var url = "https://rickandmortyapi.com/api/character/";
  List data;

  Future<String> fetchData() async {
    var res = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    setState(() {
      var resBody = json.decode(res.body);
      data = resBody["results"];
    });
    return "Success!";
  }

  @override
  void initState() {
    super.initState();
    this.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF202428),
      appBar: AppBar(
        backgroundColor: Color(0xFF202428),
        elevation: 0.0,
        title: Text("The Rick and Morty Guide"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.lightbulb_outline),
            onPressed: () {},
          )
        ],
      ),
      body: ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13.0),
              ),
              color: Color(0xFF3B3F43),
              child: Container(
                height: 140,
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 140,
                      width: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(13.0),
                        ),
                        image: DecorationImage(
                          image: NetworkImage(
                            data[index]["image"],
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 17.0),
                    Container(
                      child: Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              data[index]["name"],
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  height: 12,
                                  width: 12,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.green,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  "${data[index]["status"]} - ${data[index]["species"]}",
                                  style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            Text(
                              "Origin:",
                              style: TextStyle(
                                color: Color(0xFF929293),
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              data[index]["origin"]["name"],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w500
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
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
