import 'package:flutter/material.dart';
import 'package:tutorial_startup_namer/global-values.dart';
import 'package:tutorial_startup_namer/model/start-up-idea.model.dart';

import '../routes.dart';

class FavoriteStartupIdeaPage extends StatefulWidget {
  @override
  _FavoriteStartupIdeaPageState createState() =>
      _FavoriteStartupIdeaPageState();
}

class _FavoriteStartupIdeaPageState extends State<FavoriteStartupIdeaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Ideas'),
      ),
      body: _body(context),
    );
  }

  _body(BuildContext context) {
    final _savedIdeasTiles = ListTile.divideTiles(
      context: context,
      tiles: _buildTiles(),
    ).toList();

    if (STORAGE_CACHE.length == 0) {
      return Center(
        child: Text(
          'Empty',
          style: BIGGER_FONT,
        ),
      );
    } else {
      return ListView(children: _savedIdeasTiles);
    }
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
        onTap: _onTapDelete(idea),
      ));
    }
    return _tiles;
  }

  _onTapDelete(StartUpIdea idea) {
    return () => setState(() {
          STORAGE_CACHE.remove(idea);
          STORAGE.removeFavorite(idea);
          if (STORAGE_CACHE.length == 0) {
            Navigator.pushNamed(context, AppRoute.randomWords.asString());
          }
        });
  }
}
