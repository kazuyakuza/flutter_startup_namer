import 'package:flutter/material.dart';
import 'package:tutorial_startup_namer/global-values.dart';
import 'package:tutorial_startup_namer/page/favorite-startup-idea.page.dart';
import 'package:tutorial_startup_namer/page/random-words.page.dart';
import 'package:tutorial_startup_namer/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: STORAGE.init(),
      builder: _builder,
    );
  }

  Widget _builder(context, snapshot) {
    if (snapshot.hasData && snapshot.data) {
      return _appWidget();
    } else {
      return _loadingWidget();
    }
  }

  Widget _appWidget() {
    STORAGE_CACHE = STORAGE.loadFavorties();
    return MaterialApp(
      title: APP_TITLE,
      theme: ThemeData(
        primaryColor: Colors.blueGrey,
      ),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      initialRoute: STORAGE_CACHE.length > 0
          ? AppRoute.randomWords.asString()
          : AppRoute.favoriteWords.asString(),
      routes: <String, WidgetBuilder>{
        AppRoute.randomWords.asString(): (BuildContext context) =>
            RandomWordsPage(),
        AppRoute.favoriteWords.asString(): (BuildContext context) =>
            FavoriteStartupIdeaPage(),
      },
    );
  }

  Widget _loadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 25),
          Text(
            'Plese wait...',
            textDirection: TextDirection.ltr,
          ),
        ],
      ),
    );
  }
}
