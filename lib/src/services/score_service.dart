import 'dart:convert';

import 'package:flutter/services.dart';
import '../models/score/score_model.dart';

class ScoreService {
  ScoreService._();

  static final ScoreService _instance = ScoreService._();

  static ScoreService get instance => _instance;

  Future<List<ScoreModel>> forUser(String userId) async {
    return (await all()).where((score) => score.userUid == userId).toList();
  }

  Future<Map<String, int>> mappedToUid() async {
    Map<String, int> uidScoreMap = {};

    for (var score in (await all())) {
      uidScoreMap.putIfAbsent(score.userUid, () => 0);
      uidScoreMap.update(score.userUid, (value) => score.score + value);
    }

    return uidScoreMap;
  }

  Future<List<ScoreModel>> all() async {
    String data = await rootBundle.loadString('assets/mock/data/scores.json');
    final List jsonData = await jsonDecode(data);
    final List<ScoreModel> scoresList =
        jsonData.map((score) => ScoreModel.fromJson(score)).toList();

    await Future.delayed(const Duration(seconds: 1), () {});

    return scoresList;
  }
}
