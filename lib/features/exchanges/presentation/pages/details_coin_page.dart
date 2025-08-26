import 'package:flutter/material.dart';

class DetailsCoinPage extends StatelessWidget {
  const DetailsCoinPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Detail Coin'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[const Text('Detail Coin Page')],
        ),
      ),
    );
  }
}
