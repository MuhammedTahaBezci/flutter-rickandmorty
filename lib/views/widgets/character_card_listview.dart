import 'package:flutter/material.dart';
import 'package:rickandmorty/models/characters_model.dart';
import 'package:rickandmorty/views/widgets/character_cardview.dart';

class CharacterCardListview extends StatefulWidget {
  final List<CharacterModel> characters;
  final VoidCallback onLoadMore;
  final bool loadMore;
  
  const CharacterCardListview({
    super.key,
    required this.characters,
    required this.onLoadMore,
    this.loadMore = false,
  });

  @override
  State<CharacterCardListview> createState() => _CharacterCardListviewState();
}

class _CharacterCardListviewState extends State<CharacterCardListview> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    _detectScrollBottom();
    super.initState();
  }

  void _detectScrollBottom() {
    _scrollController.addListener(() {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentPosition = _scrollController.position.pixels;
      const int delta = 200;

      if (maxScroll - currentPosition <= delta) {
        widget.onLoadMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.builder(
        itemCount: widget.characters.length,
        controller: _scrollController,
        itemBuilder: (context, index) {
          final characterModel = widget.characters[index];
          return Column(
            children: [
              CharacterCardview(characterModel: characterModel),
              if (widget.loadMore && index == widget.characters.length - 1)
                const CircularProgressIndicator.adaptive()
            ],
          );
        },
      ),
    );
  }
}
