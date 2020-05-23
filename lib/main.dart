import 'package:flutter/material.dart';
import 'package:wordnik/try.dart';
import 'constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.grey[900],
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  static var word;
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController cont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                cursorColor: Colors.white,
                decoration: kInputDecoration,
                cursorWidth: 10.0,
                controller: cont,
              ),
            ),
            FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              color: Colors.grey[900],
              child: Text('              Submit              '),
              onPressed: () {
                setState(() {
                  MyHomePage.word = cont.text;
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => trying()));
                  cont.clear();
                  FocusScope.of(context).unfocus();
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
