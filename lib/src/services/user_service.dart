import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:scoremaster/src/models/user/user_model.dart';

class UserService {
  UserService._();

  static final UserService _instance = UserService._();

  static UserService get instance => _instance;

  Future<UserModel> findOne(String uid) async {
    return (await all()).firstWhere((user) => user.uid == uid);
  }

  Future<Map<String, UserModel>> asMap() async {
    Map<String, UserModel> uidToUser = {};
    List<UserModel> users = await all();

    for (UserModel user in users) {
      uidToUser.putIfAbsent(user.uid, () => user);
    }

    return uidToUser;
  }

  Future<List<UserModel>> all() async {
    String data = await rootBundle.loadString('assets/mock/data/users.json');
    final List jsonData = await jsonDecode(data);
    List<UserModel> usersList =
        jsonData.map((user) => UserModel.fromJson(user)).toList();

    Random random = Random();
    usersList = usersList
        .map(
          (user) => user.copyWith(
            imageUrl: 'assets/mock/pictures/profile-' +
                (random.nextInt(7) + 1).toString() +
                '.jpg',
          ),
        )
        .toList();

    await Future.delayed(const Duration(seconds: 1), () => null);

    return usersList;
  }
}
