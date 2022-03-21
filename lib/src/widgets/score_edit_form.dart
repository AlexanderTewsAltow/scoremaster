import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scoremaster/src/config/app_colors.dart';
import 'package:scoremaster/src/models/game/game_model.dart';
import 'package:scoremaster/src/models/score/score_model.dart';
import 'package:scoremaster/src/models/user/user_model.dart';
import 'package:scoremaster/src/services/score_service.dart';

class ScoreEditForm extends StatefulWidget {
  final List<UserModel> users;
  final List<GameModel> games;

  const ScoreEditForm({Key? key, required this.users, required this.games})
      : super(key: key);

  @override
  State<ScoreEditForm> createState() => _ScoreEditFormState();
}

class _ScoreEditFormState extends State<ScoreEditForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String userUid = '';
    String gameUid = '';
    String score = '';

    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Center(
            child: Text(
              'Add new Score',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Autocomplete(
            fieldViewBuilder: (
              BuildContext context,
              TextEditingController textEditingController,
              FocusNode focusNode,
              VoidCallback onFieldSubmitted,
            ) {
              return TextFormField(
                controller: textEditingController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                ),
                focusNode: focusNode,
                validator: (value) {
                  if (value.toString().isEmpty) {
                    return 'This field is required';
                  }
                  if (widget.users
                      .where(
                        (user) => user.username == value.toString(),
                      )
                      .isEmpty) {
                    return 'No user with this username found';
                  }
                },
                onSaved: (_selected) => setState(() {
                  userUid = widget.users
                      .firstWhere(
                        (user) => user.username == _selected.toString(),
                      )
                      .uid;
                }),
              );
            },
            optionsBuilder: getUsernameMatches,
            onSelected: (String _selected) => setState(() {
              userUid = widget.users
                  .firstWhere((user) => user.username == _selected)
                  .uid;
            }),
          ),
          Autocomplete(
            fieldViewBuilder: (
              BuildContext context,
              TextEditingController textEditingController,
              FocusNode focusNode,
              VoidCallback onFieldSubmitted,
            ) {
              return TextFormField(
                controller: textEditingController,
                decoration: const InputDecoration(
                  labelText: 'Game',
                ),
                focusNode: focusNode,
                validator: (value) {
                  if (value.toString().isEmpty) {
                    return 'This field is required';
                  }
                  if (widget.games
                      .where(
                        (game) => game.name == value.toString(),
                      )
                      .isEmpty) {
                    return 'No game with this name found';
                  }
                },
                onSaved: (_selected) => setState(() {
                  gameUid = widget.games
                      .firstWhere(
                        (game) => game.name == _selected.toString(),
                      )
                      .uid;
                }),
              );
            },
            optionsBuilder: getGamesMatches,
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(
                RegExp(r'[0-9]+[,.]{0,1}[0-9]*'),
              ),
              TextInputFormatter.withFunction(
                (oldValue, newValue) => newValue.copyWith(
                  text: newValue.text.replaceAll('.', ','),
                ),
              ),
            ],
            decoration: const InputDecoration(
              labelText: 'Score',
            ),
            onSaved: (_score) => setState(() => score = _score.toString()),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: ElevatedButton(
              child: const Text('Submit'),
              onPressed: () {
                final form = _formKey.currentState;
                if (form!.validate()) {
                  form.save();
                  ScoreService.instance.addScore(
                    userUid,
                    gameUid,
                    int.tryParse(score) ?? 0,
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Saving score...'),
                      backgroundColor: AppColors.accent,
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  FutureOr<Iterable<String>> getUsernameMatches(
    TextEditingValue textEditingValue,
  ) {
    if (textEditingValue.text == '') {
      return const Iterable<String>.empty();
    } else {
      List<String> matches = <String>[];
      matches.addAll(widget.users.map((e) => e.username));

      matches.retainWhere(
        (username) => username
            .toLowerCase()
            .contains(textEditingValue.text.toLowerCase()),
      );
      return matches;
    }
  }

  FutureOr<Iterable<String>> getGamesMatches(
    TextEditingValue textEditingValue,
  ) {
    if (textEditingValue.text == '') {
      return const Iterable<String>.empty();
    } else {
      List<String> matches = <String>[];
      matches.addAll(widget.games.map((e) => e.name));

      matches.retainWhere(
        (gamename) => gamename
            .toLowerCase()
            .contains(textEditingValue.text.toLowerCase()),
      );
      return matches;
    }
  }
}
