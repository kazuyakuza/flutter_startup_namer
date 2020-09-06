import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:tutorial_startup_namer/service/favorite-storage.service.dart';

const biggerFont = TextStyle(fontSize: 18.0);

var favoritesWordPair = Set<WordPair>();
var favoritesStorage = FavoriteStorageService();
