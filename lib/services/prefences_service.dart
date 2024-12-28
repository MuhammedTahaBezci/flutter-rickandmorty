import 'package:shared_preferences/shared_preferences.dart';

class PrefencesService {
  final SharedPreferences prefs;

  PrefencesService({required this.prefs});

  final String _characterKey = 'characters';

  void storeCharacters(List<String> characters) async {
    await prefs.setStringList(_characterKey, characters);
  }

  void saveCharacter(int id) async {
    final charactersList = prefs.getStringList(_characterKey) ?? [];
    charactersList.add(id.toString());
    storeCharacters(charactersList);
  }

  void removeCharacter(int id) async {
    final charactersList = prefs.getStringList(_characterKey) ?? [];
    charactersList.remove(id.toString());
    storeCharacters(charactersList);
  }

  List<int> getSavedCharacter() {
    final characterList = prefs.getStringList(_characterKey) ?? [];
    return characterList.map((e) => int.parse(e)).toList();
  }
}
