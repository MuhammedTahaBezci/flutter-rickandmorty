import 'package:flutter/material.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarWidget(),
      bottomNavigationBar: NavigationBar(destinations: const [
        NavigationDestination(icon: Icon(Icons.face), label: 'Karakterler'),
        NavigationDestination(icon: Icon(Icons.bookmark), label: 'Favorilerim'),
        NavigationDestination(icon: Icon(Icons.location_on), label: 'Konumlar'),
        NavigationDestination(icon: Icon(Icons.menu), label: 'Bölümler'),
      ]),
    );
  }

  AppBar _appBarWidget() {
    return AppBar(
      title: const Text("Rick and Mort",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
      actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.settings))],
    );
  }
}
