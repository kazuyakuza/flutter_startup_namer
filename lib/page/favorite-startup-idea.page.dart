import 'package:flutter/material.dart';
import 'package:tutorial_startup_namer/global-values.dart';
import 'package:tutorial_startup_namer/model/start-up-idea.model.dart';

class FavoriteStartupIdeaPage extends StatefulWidget {
  @override
  _FavoriteStartupIdeaPageState createState() =>
      _FavoriteStartupIdeaPageState();
}

class _FavoriteStartupIdeaPageState extends State<FavoriteStartupIdeaPage> {
  @override
  Widget build(BuildContext context) {
    final divided = ListTile.divideTiles(
      context: context,
      tiles: _buildTiles(),
    ).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Ideas'),
      ),
      body: ListView(children: divided),
    );
  }

  _buildTiles() {
    final List<Widget> _tiles = new List<Widget>();
    for (StartUpIdea idea in STORAGE_CACHE) {
      _tiles.add(ListTile(
        title: Text(
          idea.wordPair.asPascalCase,
          style: BIGGER_FONT,
        ),
        trailing: Icon(
          Icons.delete,
          color: Colors.red,
        ),
        onTap: () {
          setState(() {
            STORAGE_CACHE.remove(idea);
            STORAGE.removeFavorite(idea);
          });
        },
      ));
    }
    return _tiles;
  }
}
