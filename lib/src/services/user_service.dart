import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scoremaster/src/models/user/user_model.dart';

class UserService {
  UserService._();

  static final UserService _instance = UserService._();

  static UserService get instance => _instance;

  Future<UserModel> findOne(String uid) async {
    return (await all()).firstWhere((user) => user.uid == uid);
  }

  Future<List<UserModel>> all() async {
    String data = await rootBundle.loadString('assets/mock/data/users.json');
    final List jsonData = await jsonDecode(data);
    final List<UserModel> usersList =
        jsonData.map((user) => UserModel.fromJson(user)).toList();

    return usersList;
  }
}
