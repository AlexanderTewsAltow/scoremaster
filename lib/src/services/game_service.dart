import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/game/game_model.dart';

class GameService {
  GameService._();

  static final GameService _instance = GameService._();

  static GameService get instance => _instance;

  Future<GameModel> findOne(String uid) async {
    return (await all()).firstWhere((game) => game.uid == uid);
  }

  Future<List<GameModel>> all() async {
    String data = await rootBundle.loadString('assets/mock/data/games.json');
    final List jsonData = await jsonDecode(data);
    final List<GameModel> gamesList =
        jsonData.map((game) => GameModel.fromJson(game)).toList();

    await Future.delayed(const Duration(seconds: 1), () {});

    return gamesList;
  }
}
