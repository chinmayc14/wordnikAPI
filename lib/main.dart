import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wordnik/list.dart';
import 'package:wordnik/themechanger.dart';

import 'package:wordnik/try.dart';
import 'constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider<ThemeChanger>(
        create: (_) => ThemeChanger(), child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themechanger = Provider.of<ThemeChanger>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themechanger.getTheme(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  static var word;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _noconnection = false;

  String data;
  bool nakli = true;
  String animationtype = "idle";
  final focusno = FocusNode();
  // Connectivity connectivity;
  // StreamSubscription<ConnectivityResult> subscription;
  TextEditingController cont = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    animationtype = "idle";
    focusno.addListener(() {
      setState(() {
        if (focusno.hasFocus || !focusno.hasFocus) {
          animationtype = 'idle';
        }
      });
    });

    // connectivity = new Connectivity();
    // subscription =
    //     connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
    //   print(result);
    //   setState(() {
    //     animationtype = "idle";
    //     if (result == ConnectivityResult.none) {
    //       _noconnection = true;
    //     } else {
    //       _noconnection = false;
    //     }
    //   });
    // });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themechanger = Provider.of<ThemeChanger>(context);
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Wordnik',
            style: GoogleFonts.monoton(
                textStyle: TextStyle(
              fontSize: 22.0,
              letterSpacing: 2.5,
            )),
          ),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HistoryScreen()));
                },
                child: Text('List')),
            IconButton(
              icon: Icon(Icons.brightness_6),
              tooltip: themechanger.dark ? "Daytime Mode" : "Night Mode",
              onPressed: () {
                setState(() {
                  themechanger.themeSwitch();
                });
              },
            ),
          ]),
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: SingleChildScrollView(
            child: Stack(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 60,
                    ),
                    Center(
                      child: Container(
                        height: 275,
                        width: 275,
                        child: CircleAvatar(
                          backgroundColor: Colors.blueGrey,
                          child: ClipOval(
                            child: new FlareActor(
                              "assets/Teddy.flr",
                              alignment: Alignment.center,
                              fit: BoxFit.contain,
                              animation: animationtype,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      "Learn New Words with their Definations and Examples",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.dancingScript(
                          textStyle: TextStyle(
                        fontSize: 15.0,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold,
                      )),
                    ),
                    Container(
                      padding: EdgeInsets.all(30),
                      width: MediaQuery.of(context).size.width / 2,
                      child: TextField(
                        focusNode: focusno,
                        cursorColor:
                            themechanger.dark ? Colors.white : Colors.grey,
                        decoration: kInputDecoration.copyWith(
                          filled: true,
                          fillColor: themechanger.dark
                              ? Colors.white70
                              : Colors.grey[200],
                        ),
                        cursorWidth: 10.0,
                        controller: cont,
                      ),
                    ),
                    FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      color: themechanger.dark ? Colors.grey[900] : Colors.cyan,
                      child: Text(
                        '              Proceed              ',
                        style: TextStyle(
                          color:
                              themechanger.dark ? Colors.white : Colors.white,
                        ),
                      ),
                      onPressed: () async {
                        setState(() {
                          animationtype = 'success';
                        });

                        var _reportRef = FirebaseFirestore.instance
                            .collection('wordList')
                            .doc('default');

                        Map<String, dynamic> sets = {};

                        sets['${cont.text}'] = cont.text;
                        print(sets.toString() + 'parkadd line 199');
                        _reportRef
                            .set(sets, SetOptions(merge: true))
                            .catchError((error) {
                          if (error.toString() ==
                              '[cloud_firestore/not-found] Some requested document was not found.')
                            _reportRef.set(sets);
                          print("Errrorrrrr:" + error.toString());
                        });
                        setState(() {
                          MyHomePage.word = cont.text;

                          cont.clear();
                          FocusScope.of(context).unfocus();
                        });

                        // await new Future.delayed(
                        //     const Duration(milliseconds: 1100));
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => trying()));
                      },
                    ),
                  ],
                ),
                _noconnection
                    ? Container(
                        padding: EdgeInsets.only(bottom: 0),
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30))),
                        height: 20,
                        width: MediaQuery.of(context).size.width,
                        child: Center(child: Text("No connection")),
                      )
                    : SizedBox(
                        height: 1,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
