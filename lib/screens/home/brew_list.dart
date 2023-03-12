import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/brew.dart';
import '../../services/app_service.dart';
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

    return Column(
      children: [
        ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: brews.length,
          itemBuilder: (context, index) {
            return BrewTile(brew: brews[index]);
          },
        ),
        ListTile(
          contentPadding: EdgeInsets.all(0),
          leading: const CircleAvatar(
            backgroundColor: Colors.blueAccent,
            radius: 18,
            child: Icon(
              Icons.lock,
              size: 18,
              color: Colors.white,
            ),
          ),
          title: Text(
            'privacy policy',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.primary),
          ),
          trailing: Icon(Icons.chevron_right),
          onTap: () => AppService().openLinkWithCustomTab(context, "https://github.com/"),
        ),
      ],
    );
  }
}
