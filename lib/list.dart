import 'package:flutter/material.dart';
import 'package:wordnik/main.dart';
import 'package:wordnik/service.dart';
import 'package:wordnik/try.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<String> history = [];
  ScrollController scrollController = new ScrollController();
  @override
  void initState() {
    super.initState();
    loadFirebase();
  }

  loadFirebase() async {
    history = await PostService().getWords();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(0),
          child: Text(
            'WordList',
            textAlign: TextAlign.start,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 36, color: Colors.black),
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: history.length == 0
          ? Center(
              child: Container(
                  alignment: AlignmentDirectional.bottomCenter,
                  child: Column(
                    children: <Widget>[
                      CircularProgressIndicator(),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                  )),
            )
          : SafeArea(
              child: SingleChildScrollView(
                  controller: scrollController,
                  child: Scrollbar(
                      isAlwaysShown: true,
                      controller: scrollController,
                      child: listLayout()))),
    );
  }

  Column listLayout() {
    List<Widget> col1 = [];

    for (var index = 0; index < history.length; index++) {
      col1.add(
        InkWell(
          onTap: () {
            print(history[index]);
            setState(() {
              MyHomePage.word = history[index];
            });
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => trying()));
          },
          child: Container(
            // height: 100.0,
            margin: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 10.0,
            ),
            child: new Stack(
              children: <Widget>[
                Container(
                  // height: 100.0,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  constraints: BoxConstraints(minHeight: 80),
                  decoration: new BoxDecoration(
                    color: Colors.grey[900],
                    shape: BoxShape.rectangle,
                    borderRadius: new BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white,
                        blurRadius: 5.0, // soften the shadow
                        spreadRadius: 1.0, //extend the shadow
                        offset: Offset(
                          0.0, // Move to right 10  horizontally
                          0.0, // Move to bottom 10 Vertically
                        ),
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 7,
                        ),
                        Center(
                          child: Text(
                            history[index],
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          children: col1,
        )
      ],
    );
  }
}
