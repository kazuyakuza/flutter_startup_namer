// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:tutorial_startup_namer/global-values.dart';
import 'package:tutorial_startup_namer/page/random-words.page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: favoritesStorage.init(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data) {
            favoritesWordPair = favoritesStorage.loadFavorties();
            return MaterialApp(
              title: 'Startup Name Generator',
              theme: ThemeData(
                primaryColor: Colors.blueGrey,
              ),
              home: RandomWordsPage(),
              debugShowCheckedModeBanner: false,
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
