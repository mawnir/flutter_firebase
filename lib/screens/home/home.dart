import 'package:flutter/material.dart';
import 'package:flutter_firebase/screens/home/my_webview.dart';
import 'package:flutter_firebase/screens/home/settings_form.dart';
import 'package:provider/provider.dart';

import '../../models/brew.dart';
import '../../services/auth.dart';
import '../../services/database.dart';
import 'brew_list.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: SettingsForm(),
            );
          });
    }

    return StreamProvider<List<Brew>?>.value(
      initialData: [],
      value: DatabaseService(uid: '').brews,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Brew Crew'),
          backgroundColor: Color.fromARGB(255, 0, 0, 0),
          elevation: 0.0,
          actions: <Widget>[
            TextButton.icon(
              icon: const Icon(Icons.person),
              label: const Text('logout'),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
            TextButton.icon(
              icon: Icon(Icons.settings),
              label: Text('settings'),
              onPressed: () => _showSettingsPanel(),
            ),
            TextButton.icon(
              icon: Icon(Icons.web),
              label: Text('Web'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyWebView()),
                );
              },
            )
          ],
        ),
        body: BrewList(),
      ),
    );
  }
}
