import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:scoremaster/src/models/user/user_model.dart';

class UserService {
  UserService._();

  static final UserService _instance = UserService._();

  static UserService get instance => _instance;

  List<UserModel> users = [];

  Future<UserModel> findByUserUid(String uid) async {
    return (await findAll()).firstWhere((user) => user.uid == uid);
  }

  Future<Map<String, UserModel>> asMap() async {
    Map<String, UserModel> uidToUser = {};
    List<UserModel> users = await findAll();

    for (UserModel user in users) {
      uidToUser.putIfAbsent(user.uid, () => user);
    }

    return uidToUser;
  }

  Future<List<UserModel>> findAll() async {
    if (users.isEmpty) {
      final String _data =
          await rootBundle.loadString('assets/mock/data/users.json');
      final List _jsonData = await jsonDecode(_data);
      List<UserModel> _userList =
          _jsonData.map((user) => UserModel.fromJson(user)).toList();

      Random random = Random();
      _userList = _userList
          .map(
            (user) => user.copyWith(
              imageUrl: 'assets/mock/pictures/profile-' +
                  (random.nextInt(7) + 1).toString() +
                  '.jpg',
            ),
          )
          .toList();

      users = _userList;
    }

    await Future.delayed(const Duration(seconds: 1), () => null);

    return users;
  }
}
