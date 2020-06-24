import 'package:flutter/material.dart';
import 'package:rickandmorty/models/character_model.dart';
import '../constants.dart';

class CharDetail extends StatelessWidget {
  final Results results;
  CharDetail({this.results});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF202428),
      appBar: AppBar(
        backgroundColor: Color(0xFF202428),
        title: Text(
          results.name,
          style: TextStyle(
            fontFamily: "Product-Sans",
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 30,
            ),
            onPressed: Navigator.of(context).pop),
        elevation: 0.0,
        // centerTitle: true,
      ),
      body: bodyWidget(context),
    );
  }

  bodyWidget(BuildContext context) => Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 1.4,
            width: MediaQuery.of(context).size.width - 30,
            margin: EdgeInsets.only(top: 110, left: 15.0),
            child: Card(
              color: Color(0xFF3B3F43),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(height: 60.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        results.name.toUpperCase(),
                        style: detailName,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FilterChip(
                        onSelected: (a) {},
                        label: Row(
                          children: <Widget>[
                            results.status == "Alive" ? alive : dead,
                            SizedBox(width: 6),
                            Text(
                              "${results.status} - ${results.species}",
                              style: bp24,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0),
                    child: Row(
                      children: <Widget>[
                        Text("Gender: ", style: gp24),
                        Text(results.gender, style: wp24),
                      ],
                    ),
                  ),
                  results.origin.name.length > 28
                      ? Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Origin: ", style: gp24),
                              Text(results.origin.name, style: wp24),
                            ],
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(left: 29.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text("Origin: ", style: gp24),
                              Text(results.origin.name, style: wp24),
                            ],
                          ),
                        ),
                  results.location.name.length > 25
                      ? Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Location: ", style: gp24),
                              Text(results.location.name, style: wp24),
                            ],
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(left: 30.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Location: ", style: gp24),
                              Text(results.location.name, style: wp24),
                            ],
                          ),
                        ),
                ],
              ),
            ),
          ),
          Hero(
            tag: results.image,
            child: Container(
              margin: EdgeInsets.only(top: 20, left: 115),
              height: 200.0,
              width: 200.0,
              child: CircleAvatar(
                backgroundImage: NetworkImage(results.image),
              ),
            ),
          ),
        ],
      );
}
