import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class FavoriteContactsScreen extends StatelessWidget {
  static const routeName = '/FavoriteContactsScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Contacts'),
      ),
      body: Center(
        child: Text('Favorite Contact Screen'),
      ),
      drawer: MainDrawer(),
    );
  }
}
