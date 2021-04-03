import 'dart:convert';

List<QuestionPair> questionPairsFromJson(String str) =>
    List<QuestionPair>.from(json.decode(str).map((x) => QuestionPair.fromJson(x)));

String questionPairsToJson(List<QuestionPair> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class QuestionPair {
  QuestionPair({
    this.left,
    this.right,
  });

  factory QuestionPair.fromJson(Map<String, dynamic> json) => QuestionPair(
        left: json['left'],
        right: json['right'],
      );

  String left;
  String right;

  Map<String, dynamic> toJson() => {
        'left': left,
        'right': right,
      };
}
