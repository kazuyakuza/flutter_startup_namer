import 'package:english_words/english_words.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial_startup_namer/model/start-up-idea.model.dart';

class IdeaStorageService {
  SharedPreferences _storage;

  Future<bool> init() async {
    if (_storage == null) {
      _storage = await SharedPreferences.getInstance();
    }
    return true;
  }

  saveFavorite(StartUpIdea idea) async {
    final String key = idea.getKey();
    if (!_storage.containsKey(key)) {
      await _storage.setString(key, idea.toJson());
    }
  }

  removeFavorite(StartUpIdea idea) async {
    await removeFavoriteByKey(idea.getKey());
  }

  removeFavoriteByKey(String key) async {
    await _storage.remove(key);
  }

  Set<StartUpIdea> loadFavorties() {
    final Set<String> _keys = _storage.getKeys();
    if (_keys.length > 0) {
      Set<StartUpIdea> _values = new Set<StartUpIdea>();
      for (String ideaKey in _keys) {
        _values.add(StartUpIdea.fromJson(_storage.getString(ideaKey)));
      }
      return _values;
    } else {
      return new Set<StartUpIdea>();
    }
  }

  clear() async => await _storage.clear();
}
