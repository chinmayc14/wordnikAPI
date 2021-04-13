import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class PostService {
  Future<List<String>> getWords() async {
    List<String> cardListFB = [];
    // db.snapshotsInSync();
    var _reportRef =
        FirebaseFirestore.instance.collection('wordList').doc('default');

    await _reportRef.get().then((DocumentSnapshot documentSnapshot) async {
      if (documentSnapshot.exists) {
        var a = documentSnapshot.data();
        print(a);
        if (a != null) {
          for (var historyCard in a.keys) {
            cardListFB.add(historyCard);
          }
        }
      }
    });
    cardListFB.sort();
    return cardListFB;
  }
}
