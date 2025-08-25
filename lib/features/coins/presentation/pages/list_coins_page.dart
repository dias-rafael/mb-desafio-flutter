import 'package:flutter/material.dart';

class ListCoinsPage extends StatelessWidget {
  const ListCoinsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('List Coins'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[const Text('List Coins Page')],
        ),
      ),
    );
  }
}
