import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/game/game_model.dart';

class GameService {
  GameService._();

  static final GameService _instance = GameService._();

  static GameService get instance => _instance;

  List<GameModel> games = [];

  Future<GameModel> findByGameUid(String uid) async {
    return (await findAll()).firstWhere((game) => game.uid == uid);
  }

  Future<List<GameModel>> findAll() async {
    if (games.isEmpty) {
      final String _data =
          await rootBundle.loadString('assets/mock/data/games.json');
      final List _jsonData = await jsonDecode(_data);
      final List<GameModel> _gamesList =
          _jsonData.map((game) => GameModel.fromJson(game)).toList();

      games = _gamesList;
    }

    await Future.delayed(const Duration(seconds: 1), () {});

    return games;
  }
}
