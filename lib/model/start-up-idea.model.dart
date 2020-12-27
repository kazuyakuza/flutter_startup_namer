import 'dart:convert';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class StartUpIdea {
  final WordPair _wordPair;
  WordPair get wordPair => _wordPair;

  final String _img;
  String get img => _img;

  StartUpIdea(this._wordPair, {String img}) : _img = img;

  String getKey() => generateKeyFrom(_wordPair);

  static String generateKeyFrom(WordPair wordPair) {
    return (wordPair.first + '-' + wordPair.second).toString().toLowerCase();
  }

  static StartUpIdea fromJson(String json) {
    Map<String, dynamic> parsedJson = jsonDecode(json);
    try {
      return StartUpIdea(
        WordPair(
            parsedJson['wordPair']['first'], parsedJson['wordPair']['second']),
        img: parsedJson['img'],
      );
    } catch (e) {
      debugPrint("exception: " + e.toString());
      return null; // TODO handle exception
    }
  }

  String toJson() {
    return jsonEncode({
      'wordPair': {'first': wordPair.first, 'second': wordPair.second}
    });
    // TODO add img property
  }
}
