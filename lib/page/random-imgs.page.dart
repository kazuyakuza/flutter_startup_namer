import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tutorial_startup_namer/global-values.dart';
import 'package:tutorial_startup_namer/model/picture.model.dart';
import 'package:tutorial_startup_namer/model/start-up-idea.model.dart';
import 'package:tutorial_startup_namer/routes.dart';
import 'package:http/http.dart' as http;

class RandomImgsPage extends StatefulWidget {
  @override
  _RandomImgsPageState createState() => _RandomImgsPageState();
}

class _Suggestion {
  Uri img;
  bool saved = false;
  _Suggestion(this.img, {bool saved}) : this.saved = saved;
  @override
  String toString() {
    return {
      'img': img.toString(),
      'saved': saved.toString(),
    }.toString();
  }
}

class _RandomImgsPageState extends State<RandomImgsPage> {
  final _suggestions = <_Suggestion>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Found a cool image!'),
        actions: _appBarActions(),
      ),
      body: _buildSuggestions(),
    );
  }

  List<Widget> _appBarActions() {
    List<Widget> actions = [
      IconButton(
        icon: Icon(Icons.list),
        onPressed: _pushBack,
      ),
      IconButton(
        icon: Icon(Icons.list),
        onPressed: _pushSaved,
      ),
    ];
    return actions;
  }

  Widget _buildSuggestions() {
    return ListView.builder(
      padding: EdgeInsets.all(16.0),
      itemBuilder: _SuggestionsBuilder,
    );
  }

  Widget _SuggestionsBuilder(context, i) {
    if (i.isOdd) return Divider();

    final index = i ~/ 2;
    if (index >= _suggestions.length) {
      return _generateNewSuggestions(index);
    }
    return _buildRow(_suggestions[index]);
  }

  Widget _generateNewSuggestions(int index) => FutureBuilder<List<Uri>>(
        future: generateRandomImg(),
        builder: (buildContext, suggestionsData) {
          // TODO handle suggestionsData errors
          _suggestions.addAll(
            suggestionsData.data
                .map<_Suggestion>((Uri uri) => _Suggestion(uri, saved: false)),
          );
          return _buildRow(_suggestions[index]);
        },
      );

  Widget _buildRow(_Suggestion suggestion) {
    if (suggestion.saved) {
      // TODO to implement
      // suggestion.saved = STORAGE_CACHE.firstWhere(
      //         (StartUpIdea idea) =>
      //             idea.getKey() ==
      //             StartUpIdea.generateKeyFrom(suggestion.wordPair),
      //         orElse: () => null) !=
      //     null;
    }
    return ListTile(
      title: Image.network(suggestion.img.toString()),
      trailing: Icon(
        suggestion.saved ? Icons.favorite : Icons.favorite_border,
        color: suggestion.saved ? Colors.red : null,
      ),
      onTap: _onTapSave(suggestion),
    );
  }

  Function _onTapSave(_Suggestion suggestion) {
    return () => setState(() {
          // TODO implement
          // if (suggestion.saved) {
          //   final _pairAsKey = StartUpIdea.generateKeyFrom(suggestion.wordPair);
          //   STORAGE_CACHE
          //       .removeWhere((StartUpIdea idea) => idea.getKey() == _pairAsKey);
          //   STORAGE.removeFavoriteByKey(_pairAsKey);
          //   suggestion.saved = false;
          // } else {
          //   final StartUpIdea idea = new StartUpIdea(suggestion.wordPair);
          //   STORAGE_CACHE.add(idea);
          //   STORAGE.saveFavorite(idea);
          //   suggestion.saved = true;
          // }
        });
  }

  Future<List<Uri>> generateRandomImg() async {
    List<Uri> imgs = [];
    var client = http.Client();
    Uri uri = Uri(
        scheme: 'https',
        host: 'picsum.photos',
        path: '/v2/list',
        queryParameters: {'limit': '5'});
    try {
      var res = await client.get(uri);
      if (res.statusCode != 200 || res.contentLength <= 0) {
        throw Exception([
          "Can't get random images from ${uri.toString()} => status code: ${res.statusCode}",
          res.body,
        ]);
      }
      List<dynamic> bodyParsed = jsonDecode(res.body);
      for (Map<String, dynamic> picture in bodyParsed) {
        imgs.add(Picture.fromMap(picture).downloadUrl);
      }
    } finally {
      client.close();
    }

    // var response =
    //     await http.post(uri, body: {'name': 'doodle', 'color': 'blue'});
    // print('Response status: ${response.statusCode}');
    // print('Response body: ${response.body}');

    // print(await http.read('https://example.com/foobar.txt'));

    return imgs;
  }

  void _pushSaved() {
    Navigator.pushNamed(context, AppRoute.favoriteStartupIdea.asString());
  }

  void _pushBack() {
    Navigator.pushNamed(context, AppRoute.randomWords.asString());
  }
}
