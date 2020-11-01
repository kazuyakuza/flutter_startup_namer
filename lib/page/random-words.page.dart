import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:tutorial_startup_namer/global-values.dart';
import 'package:tutorial_startup_namer/model/start-up-idea.model.dart';
import 'package:tutorial_startup_namer/routes.dart';

class RandomWordsPage extends StatefulWidget {
  @override
  _RandomWordsPageState createState() => _RandomWordsPageState();
}

class _Suggestion {
  WordPair wordPair;
  bool saved = false;
  _Suggestion(this.wordPair, {bool saved}) : this.saved = saved;
  @override
  String toString() {
    return '''{
  "wordPair": $wordPair,
  "saved": $saved,
}''';
  }
}

class _RandomWordsPageState extends State<RandomWordsPage> {
  final _suggestions = <_Suggestion>[];

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
            _suggestions.addAll(generateWordPairs().take(5).map<_Suggestion>(
                (WordPair wordPair) => _Suggestion(wordPair, saved: false)));
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(_Suggestion suggestion) {
    // debugPrint(suggestion.toString());
    if (suggestion.saved) {
      suggestion.saved = STORAGE_CACHE.firstWhere(
              (StartUpIdea idea) =>
                  idea.getKey() ==
                  StartUpIdea.generateKeyFrom(suggestion.wordPair),
              orElse: () => null) !=
          null;
    }
    return ListTile(
      title: Text(
        suggestion.wordPair.asPascalCase,
        style: BIGGER_FONT,
      ),
      trailing: Icon(
        suggestion.saved ? Icons.favorite : Icons.favorite_border,
        color: suggestion.saved ? Colors.red : null,
      ),
      onTap: _onTapSave(suggestion),
    );
  }

  Function _onTapSave(_Suggestion suggestion) {
    return () => setState(() {
          if (suggestion.saved) {
            final _pairAsKey = StartUpIdea.generateKeyFrom(suggestion.wordPair);
            STORAGE_CACHE
                .removeWhere((StartUpIdea idea) => idea.getKey() == _pairAsKey);
            STORAGE.removeFavoriteByKey(_pairAsKey);
            suggestion.saved = false;
          } else {
            final StartUpIdea idea = new StartUpIdea(suggestion.wordPair);
            STORAGE_CACHE.add(idea);
            STORAGE.saveFavorite(idea);
            suggestion.saved = true;
          }
        });
  }

  void _pushSaved() {
    Navigator.pushNamed(context, AppRoute.favoriteStartupIdea.asString());
  }
}
