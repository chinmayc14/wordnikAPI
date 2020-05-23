import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'key.dart';

class trying extends StatefulWidget {
  @override
  _tryingState createState() => _tryingState();
}

class _tryingState extends State<trying> {
  List datadef;
  List dataexp;
  String API = keyy().api_key;
  Future<String> getData(String word) async {
    final String api1 = "https://api.wordnik.com/v4/word.json/";

    final String api2 =
        "/definitions?limit=3&includeRelated=false&useCanonical=false&includeTags=false&api_key=$API";

    final String api3 =
        "/examples?includeDuplicates=false&useCanonical=false&limit=5&api_key=$API";

    final responsedef = await http.get(api1 + word + api2);
    final responseexp = await http.get(api1 + word + api3);
    print(responsedef.body);
    print(responseexp.body);

    setState(() {
      var convertJsondef = json.decode(responsedef.body);
      var convertJsonexp = json.decode(responseexp.body);
      datadef = convertJsondef;
      dataexp = convertJsonexp['examples'];
    });
  }

  @override
  void initState() {
    String text = MyHomePage.word;
    // TODO: implement initState
    this.getData(text);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('learn'),
      ),
      body: datadef == null
          ? Center(child: Loader())
          : Container(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    "Defination",
                    style: GoogleFonts.dancingScript(
                        textStyle: TextStyle(
                      fontSize: 24.0,
                      letterSpacing: 2.5,
                      fontWeight: FontWeight.bold,
                    )),
                  ),
                  Flexible(
                    fit: FlexFit.loose,
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      separatorBuilder: (context, index) {
                        return Divider(
                          thickness: 5.0,
                        );
                      },
                      itemCount: 3,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              color: Colors.grey[900],
                              elevation: 5.0,
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8.0),
                                    child: Text(
                                      datadef[index]['text'],
                                      style: GoogleFonts.spectral(
                                          textStyle: TextStyle(
                                              fontSize: 17.0,
                                              wordSpacing: 1.0,
                                              letterSpacing: 1.5)),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 5.0),
                    child: Text(
                      "Examples",
                      style: GoogleFonts.dancingScript(
                          textStyle: TextStyle(
                              fontSize: 24.0,
                              letterSpacing: 2.5,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: ListView.separated(
                      physics: ScrollPhysics(),
                      separatorBuilder: (context, index) {
                        return Divider(
                          thickness: 5.0,
                        );
                      },
                      itemCount: dataexp == null ? 0 : dataexp.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              color: Colors.grey[900],
                              elevation: 5.0,
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8.0),
                                    child: Text(
                                      dataexp[index]['text'],
                                      style: GoogleFonts.spectral(
                                          textStyle: TextStyle(
                                              fontSize: 17.0,
                                              wordSpacing: 1.0,
                                              letterSpacing: 1.5)),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      child: FlareActor(
        "assets/Loading.flr",
        animation: 'Alarm',
      ),
    );
  }
}
