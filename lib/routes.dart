enum AppRoute {
  randomWords,
  randomImgs,
  favoriteStartupIdea,
}

extension AppRouteValue on AppRoute {
  static const _values = {
    AppRoute.randomWords: '/random-words',
    AppRoute.randomImgs: '/random-imgs',
    AppRoute.favoriteStartupIdea: '/favorite-startup-idea',
  };

  String asString() {
    return _values[this];
  }
}
