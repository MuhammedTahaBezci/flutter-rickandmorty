import 'package:get_it/get_it.dart';
import 'package:rickandmorty/services/api_service.dart';
import 'package:rickandmorty/services/prefences_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;

Future<void> setUpLocator() async {
  final prefs = await SharedPreferences.getInstance();
  locator.registerLazySingleton<PrefencesService>(() => PrefencesService(prefs: prefs));
  locator.registerLazySingleton<ApiService>(() => ApiService());
}
