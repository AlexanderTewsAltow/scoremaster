import 'dart:convert';
import 'package:uuid/uuid.dart';

import 'package:flutter/services.dart';
import '../models/score/score_model.dart';

class ScoreService {
  ScoreService._();

  static final ScoreService _instance = ScoreService._();

  static ScoreService get instance => _instance;

  List<ScoreModel> scores = [];

  // ===========================================================================
  // Getters
  // ===========================================================================

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
    if (scores.isEmpty) {
      String _rawData =
          await rootBundle.loadString('assets/mock/data/scores.json');
      final List _jsonData = await jsonDecode(_rawData);
      final List<ScoreModel> _scoresList =
          _jsonData.map((_score) => ScoreModel.fromJson(_score)).toList();
      scores = _scoresList;
    }

    await Future.delayed(const Duration(seconds: 1), () {});

    return scores;
  }

  // ===========================================================================
  // Setters
  // ===========================================================================

  Future<bool> addScore(
    String userUid,
    String gameUid,
    int score,
  ) async {
    scores.add(
      ScoreModel(
        uid: const Uuid().v1(),
        gameUid: gameUid,
        userUid: userUid,
        score: score,
        date: DateTime.now(),
      ),
    );

    return true;
  }
}
