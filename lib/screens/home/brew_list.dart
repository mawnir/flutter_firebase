import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/brew.dart';
import 'brew_tile.dart';

class BrewList extends StatefulWidget {
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    // final brews = Provider.of<QuerySnapshot>(context);
    // if (brews != null) {
    //   for (var doc in brews.docs) {
    //     print('doc.data');
    //     print(doc.data());
    //   }
    // }

    final brews = Provider.of<List<Brew>>(context);
    // if (brews != null) {
    //   brews.forEach((brew) {
    //     print(brew.name);
    //     print(brew.sugars);
    //   });
    // }

    return ListView.builder(
      itemCount: brews.length,
      itemBuilder: (context, index) {
        return BrewTile(brew: brews[index]);
      },
    );
  }
}
