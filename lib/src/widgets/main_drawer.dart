import 'package:ContactsApp/src/screens/add_edit_contact_screen.dart';
import 'package:flutter/material.dart';

import '../screens/contact_list_screen.dart';
import '../screens/favorite_contacts_screen.dart';

class MainDrawer extends StatelessWidget {
  Widget buildListTile(String title, IconData icon, Function tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              height: 120,
              width: double.infinity,
              padding: EdgeInsets.all(20),
              alignment: Alignment.centerLeft,
              color: Theme.of(context).accentColor,
              child: Text(
                'Phone Book',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            buildListTile(
              'Contacts',
              Icons.contacts,
              () {
                Navigator.of(context)
                    .pushReplacementNamed(ContactListScreen.routeName);
              },
            ),
            buildListTile(
              'Favorite Contacts',
              Icons.favorite,
              () {
                Navigator.of(context)
                    .pushReplacementNamed(FavoriteContactsScreen.routeName);
              },
            ),
            buildListTile(
              'Add new contact',
              Icons.person_add,
              () {
                Navigator.of(context)
                    .pushReplacementNamed(AddEditContactScreen.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
