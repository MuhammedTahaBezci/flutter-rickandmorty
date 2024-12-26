import 'package:flutter/material.dart';
import 'package:rickandmorty/app/locator.dart';
import 'package:rickandmorty/models/characters_model.dart';
import 'package:rickandmorty/services/api_service.dart';

class CharactersViewmodel extends ChangeNotifier {
  final _apiService = locator<ApiService>();

  CharactersModel? _charactersModel;
  CharactersModel? get charactersModel => _charactersModel;
  bool loadMore = false;
  int currentPageIndex = 1;

  void clearCharacters() {
    _charactersModel = null;
    currentPageIndex = 1;
    notifyListeners();
  }

  void getCharacters() async {
    _charactersModel = await _apiService.getCharacters();
    notifyListeners();
    //print("geldi");
  }

  void setLoadMore(bool value) {
    loadMore = value;
    notifyListeners();
  }

  void getCharactersMore() async {
    //eğerki zaaten yükleniyorsa istek atma
    if (loadMore) return;

    //eğerki son saayfa ise istek yapma
    if (_charactersModel!.info.pages == currentPageIndex) return;

    setLoadMore(true);
    final data =
        await _apiService.getCharacters(url: _charactersModel?.info.next);
    setLoadMore(false);

    currentPageIndex++;

    _charactersModel!.info = data.info;
    _charactersModel!.characters.addAll(data.characters);

    notifyListeners();
  }

  void getCharactersByName(String name) async {
    clearCharacters();
    _charactersModel = await _apiService.getCharacters(args: {'name': name});
    notifyListeners();
  }
}
