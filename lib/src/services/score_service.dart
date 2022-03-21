import 'dart:convert';

import 'package:flutter/services.dart';
import '../models/score/score_model.dart';

class ScoreService {
  ScoreService._();

  static final ScoreService _instance = ScoreService._();

  static ScoreService get instance => _instance;

  Future<List<ScoreModel>> findByUserUid(String userUid) async {
    return (await findAll())
        .where((score) => score.userUid == userUid)
        .toList();
  }

  Future<Map<String, int>> mappedToUid() async {
    Map<String, int> uidScoreMap = {};
    List<ScoreModel> scores = await findAll();

    for (var score in scores) {
      uidScoreMap.putIfAbsent(score.userUid, () => 0);
      uidScoreMap.update(score.userUid, (value) => score.score + value);
    }

    return uidScoreMap;
  }

  Future<List<ScoreModel>> findAll() async {
    final String data =
        await rootBundle.loadString('assets/mock/data/scores.json');
    final List jsonData = await jsonDecode(data);
    final List<ScoreModel> scoresList =
        jsonData.map((score) => ScoreModel.fromJson(score)).toList();

    await Future.delayed(const Duration(seconds: 1), () {});

    return scoresList;
  }
}
