import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_model.freezed.dart';

part 'game_model.g.dart';

@freezed
class GameModel with _$GameModel {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory GameModel({
    required String uid,
    required String name,
  }) = _GameModel;

  factory GameModel.fromJson(Map<String, dynamic> json) =>
      _$GameModelFromJson(json);
}
