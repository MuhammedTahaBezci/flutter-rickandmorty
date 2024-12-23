import 'package:flutter/material.dart';
import 'package:rickandmorty/app/locator.dart';
import 'package:rickandmorty/models/characters_model.dart';
import 'package:rickandmorty/services/api_service.dart';

class CharactersViewmodel extends ChangeNotifier {
  final _apiService = locator<ApiService>();

  CharactersModel? _charactersModel;
  CharactersModel? get charactersModel => _charactersModel;

  void getCharacters() async {
    _charactersModel = await _apiService.getCharacters();
    notifyListeners();
    //print("geldi");

    bool loadMore = false;

    void getCharactersMore() async {
      if (loadMore) return;

      loadMore = true;
      final data =
          await _apiService.getCharacters(url: _charactersModel?.info.next);
      loadMore = false;
      _charactersModel!.info = data.info;
      _charactersModel!.characters.addAll(data.characters);

      notifyListeners();
    }
  }
}
