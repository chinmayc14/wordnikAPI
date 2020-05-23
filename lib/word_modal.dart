// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<Welcome> welcomeFromJson(String str) =>
    List<Welcome>.from(json.decode(str).map((x) => Welcome.fromJson(x)));

String welcomeToJson(List<Welcome> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Welcome {
  String id;
  String partOfSpeech;
  String attributionText;
  String sourceDictionary;
  String text;
  String sequence;
  int score;
  List<dynamic> labels;
  List<dynamic> citations;
  String word;
  List<dynamic> relatedWords;
  List<dynamic> exampleUses;
  List<dynamic> textProns;
  List<dynamic> notes;
  String attributionUrl;
  String wordnikUrl;

  Welcome({
    this.id,
    this.partOfSpeech,
    this.attributionText,
    this.sourceDictionary,
    this.text,
    this.sequence,
    this.score,
    this.labels,
    this.citations,
    this.word,
    this.relatedWords,
    this.exampleUses,
    this.textProns,
    this.notes,
    this.attributionUrl,
    this.wordnikUrl,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        id: json["id"],
        partOfSpeech: json["partOfSpeech"],
        attributionText: json["attributionText"],
        sourceDictionary: json["sourceDictionary"],
        text: json["text"],
        sequence: json["sequence"],
        score: json["score"],
        labels: List<dynamic>.from(json["labels"].map((x) => x)),
        citations: List<dynamic>.from(json["citations"].map((x) => x)),
        word: json["word"],
        relatedWords: List<dynamic>.from(json["relatedWords"].map((x) => x)),
        exampleUses: List<dynamic>.from(json["exampleUses"].map((x) => x)),
        textProns: List<dynamic>.from(json["textProns"].map((x) => x)),
        notes: List<dynamic>.from(json["notes"].map((x) => x)),
        attributionUrl: json["attributionUrl"],
        wordnikUrl: json["wordnikUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "partOfSpeech": partOfSpeech,
        "attributionText": attributionText,
        "sourceDictionary": sourceDictionary,
        "text": text,
        "sequence": sequence,
        "score": score,
        "labels": List<dynamic>.from(labels.map((x) => x)),
        "citations": List<dynamic>.from(citations.map((x) => x)),
        "word": word,
        "relatedWords": List<dynamic>.from(relatedWords.map((x) => x)),
        "exampleUses": List<dynamic>.from(exampleUses.map((x) => x)),
        "textProns": List<dynamic>.from(textProns.map((x) => x)),
        "notes": List<dynamic>.from(notes.map((x) => x)),
        "attributionUrl": attributionUrl,
        "wordnikUrl": wordnikUrl,
      };
}
