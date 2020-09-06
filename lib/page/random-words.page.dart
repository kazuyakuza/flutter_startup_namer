import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:tutorial_startup_namer/global-values.dart';
import 'package:tutorial_startup_namer/page/favorite-words.page.dart';

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
        title: Text('Startup Name Generator'),
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
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return Divider(); /*2*/

          final index = i ~/ 2; /*3*/
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10)); /*4*/
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = favoritesWordPair.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            favoritesWordPair.remove(pair);
            favoritesStorage.removeFavorite(pair);
          } else {
            favoritesWordPair.add(pair);
            favoritesStorage.saveFavorite(pair);
          }
        });
      },
    );
  }

  void _pushSaved() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FavoriteWordsPage()),
    );
  }
}
