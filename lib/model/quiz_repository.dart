import 'package:flutter/services.dart';
import '../entities/question_pair.dart';

abstract class QuizRepository {
  Future<List<QuestionPair>> load(String filename);
}

class QuizRepositoryImpl extends QuizRepository {
  @override
  Future<List<QuestionPair>> load(String filename) async {
    var jsonText = await rootBundle.loadString(filename);

    return questionPairsFromJson(jsonText);
  }
}
