import 'package:ContactsApp/src/blocs/contact_bloc_provider.dart';
import 'package:ContactsApp/src/models/contact.dart';
import 'package:ContactsApp/src/screens/add_edit_contact_screen.dart';
import 'package:flutter/material.dart';

class ContactItem extends StatelessWidget {
  final Contact contact;

  ContactItem(this.contact);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
      leading: CircleAvatar(
        child: Text(contact.name[0]),
      ),
      title: Text(contact.name),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return ContactBlocProvider(
              child: AddEditContactScreen(contact.id),
            );
          }),
        );
      },
    );
  }
}
