import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:rickandmorty/views/screens/characters_view/characters_viewmodel.dart';
import 'package:rickandmorty/views/widgets/character_card_listview.dart';
import 'package:rickandmorty/views/widgets/character_cardview.dart';

class CharactersView extends StatefulWidget {
  const CharactersView({super.key});

  @override
  State<CharactersView> createState() => _CharactersViewState();
}

class _CharactersViewState extends State<CharactersView> {
  @override
  void initState() {
    super.initState();
    context.read<CharactersViewmodel>().getCharacters();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<CharactersViewmodel>();
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 9),
          child: Column(
            children: [
              const SizedBox(height: 12),
              _searchInputWidget(context, viewModel: viewModel),
              viewModel.charactersModel == null
                  ? const CircularProgressIndicator.adaptive()
                  : CharacterCardListview(
                      characters: viewModel.charactersModel!.characters,
                      onLoadMore: () => viewModel.getCharactersMore,
                      loadMore: viewModel.loadMore,
                    )
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchInputWidget(BuildContext context,
      {required CharactersViewmodel viewModel}) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 16),
      child: TextFormField(
        textInputAction: TextInputAction.search,
        onFieldSubmitted: viewModel.getCharactersByName,
        decoration: InputDecoration(
          labelText: 'Karakter Ara',
          labelStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          border: const OutlineInputBorder(),
          prefixIcon: const Icon(Icons.search),
          suffixIcon: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ),
      ),
    );
  }
}
