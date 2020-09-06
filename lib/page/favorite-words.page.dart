import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:tutorial_startup_namer/global-values.dart';

class FavoriteWordsPage extends StatefulWidget {
  @override
  _FavoriteWordsPageState createState() => _FavoriteWordsPageState();
}

class _FavoriteWordsPageState extends State<FavoriteWordsPage> {
  @override
  Widget build(BuildContext context) {
    final divided = ListTile.divideTiles(
      context: context,
      tiles: _buildTiles(),
    ).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Suggestions'),
      ),
      body: ListView(children: divided),
    );
  }

  _buildTiles() {
    return favoritesWordPair.map(
      (WordPair pair) {
        return ListTile(
          title: Text(
            pair.asPascalCase,
            style: biggerFont,
          ),
          trailing: Icon(
            Icons.delete,
            color: Colors.red,
          ),
          onTap: () {
            setState(() {
              favoritesWordPair.remove(pair);
              favoritesStorage.removeFavorite(pair);
            });
          },
        );
      },
    );
  }
}
