import 'dart:developer';

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteStorageService {
  SharedPreferences _storage;

  Future<bool> init() async {
    if (_storage == null) {
      _storage = await SharedPreferences.getInstance();
    }
    return true;
  }

  saveFavorite(WordPair wordPair) async {
    final String wp = wordPair.first + '-' + wordPair.second;
    if (!_storage.containsKey(wp)) {
      _storage.setBool(wp, true);
    }
  }

  removeFavorite(WordPair wordPair) async {
    final String wp = wordPair.first + '-' + wordPair.second;
    _storage.remove(wp);
  }

  Set<WordPair> loadFavorties() {
    var _r = _storage.getKeys();
    if (_r.length > 0) {
      return _r.map((wordPair) {
        List<String> part = wordPair.split('-');
        return new WordPair(part[0], part[1]);
      }).toSet();
    } else {
      return new Set<WordPair>();
    }
  }
}
