import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:tutorial_startup_namer/global-values.dart';
import 'package:tutorial_startup_namer/model/start-up-idea.model.dart';
import 'package:tutorial_startup_namer/routes.dart';

class RandomWordsPage extends StatefulWidget {
  @override
  _RandomWordsPageState createState() => _RandomWordsPageState();
}

class _RandomWordsPageState extends State<RandomWordsPage> {
  final _suggestions = <WordPair>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Found a cool name!'),
        actions: _appBarActions(),
      ),
      body: _buildSuggestions(),
    );
  }

  List<Widget> _appBarActions() {
    List<Widget> actions = [
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
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider();

          final index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = STORAGE_CACHE.firstWhere((StartUpIdea idea) =>
            idea.getKey() == StartUpIdea.generateKeyFrom(pair)) !=
        null;
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: BIGGER_FONT,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            final _pairAsKey = StartUpIdea.generateKeyFrom(pair);
            STORAGE_CACHE
                .removeWhere((StartUpIdea idea) => idea.getKey() == _pairAsKey);
            STORAGE.removeFavoriteByKey(_pairAsKey);
          } else {
            final StartUpIdea idea = new StartUpIdea(pair);
            STORAGE_CACHE.add(idea);
            STORAGE.saveFavorite(idea);
          }
        });
      },
    );
  }

  void _pushSaved() {
    Navigator.pushNamed(context, AppRoute.favoriteWords.asString());
  }
}
