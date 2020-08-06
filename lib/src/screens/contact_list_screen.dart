import 'package:ContactsApp/src/blocs/contact_bloc_provider.dart';
import 'package:ContactsApp/src/blocs/contact_list_bloc.dart';
import 'package:ContactsApp/src/screens/add_edit_contact_screen.dart';
import 'package:ContactsApp/src/widgets/contact_item.dart';

import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class ContactListScreen extends StatefulWidget {
  static const routeName = '/ContactListScreen';
  @override
  _ContactListScreenState createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  //ContactListBloc bloc;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    print('didChangeDepenceies called');
    bloc.fetchAllContacts();
  }

  @override
  void initState() {
    super.initState();
    print('init state called');
  }

  @override
  Widget build(BuildContext context) {
    print('biuld called');
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact List'),
      ),
      body: StreamBuilder(
          stream: bloc.contacts,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return ContactItem(snapshot.data[index]);
                },
                itemCount: snapshot.data.length,
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              // bloc.contacts.listen((event) {
              //   ContactBlocProvider.of(context).updateContact(null);
              // });
              return ContactBlocProvider(
                child: AddEditContactScreen(null),
              );
            }),
          );
        },
        child: Icon(Icons.add),
      ),
      drawer: MainDrawer(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }
}
