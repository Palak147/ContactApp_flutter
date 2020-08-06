import 'package:ContactsApp/src/blocs/contact_bloc.dart';
import 'package:ContactsApp/src/blocs/contact_bloc_provider.dart';
import 'package:ContactsApp/src/models/contact.dart';
import 'package:ContactsApp/src/widgets/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'contact_list_screen.dart';

class AddEditContactScreen extends StatefulWidget {
  static const routeName = '/AddEditContactScreen';
  final String id;
  AddEditContactScreen(this.id);
  @override
  _AddEditContactScreenState createState() =>
      _AddEditContactScreenState(this.id);
}

class _AddEditContactScreenState extends State<AddEditContactScreen> {
  final String contactId;
  final newContact = new Contact();
  var bloc;

  _AddEditContactScreenState(this.contactId);
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc = ContactBlocProvider.of(context);
  }

  @override
  void dispose() {
    super.dispose();
    // bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //nameController.addListener(() => bloc.changeName(nameController.text));
    final appBar = AppBar(
      title:
          contactId == null ? Text('Add New Contact') : Text('Update Contact'),
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.star_border), onPressed: () => print('pressed'))
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            cameraWidget(context, appBar),
            contactFormWidget(context, appBar, bloc, contactId),
          ],
        ),
      ),
      drawer: contactId == null ? MainDrawer() : null,
    );
  }

  Widget cameraWidget(BuildContext context, AppBar appBar) {
    return Container(
      width: double.infinity,
      height: (MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          0.3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 100,
            width: 100,
            padding: const EdgeInsets.all(2.0),
            decoration:
                new BoxDecoration(color: Colors.black, shape: BoxShape.circle),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 40,
              child: IconButton(
                icon: Icon(Icons.camera_alt),
                iconSize: 32,
                onPressed: _takePicture,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget contactFormWidget(
      BuildContext context, AppBar appBar, ContactBloc bloc, String contactId) {
    return contactId != null
        ? FutureBuilder(
            future: bloc.fetchContact(contactId),
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: <Widget>[
                          nameField(bloc, snapshot.data as Contact),
                          mobileField(bloc, snapshot.data as Contact),
                          landlineField(bloc, snapshot.data as Contact),
                          updateButton(bloc, snapshot.data as Contact),
                        ],
                      ),
                    )
                  : CircularProgressIndicator();
            },
          )
        : Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                nameField(bloc, newContact),
                mobileField(bloc, newContact),
                landlineField(bloc, newContact),
                saveButton(bloc)
              ],
            ),
          );
  }

  Widget nameField(ContactBloc bloc, Contact contact) {
    return StreamBuilder(
      stream: bloc.name,
      builder: (context, snapshot) {
        return TextFormField(
          initialValue: contact.name,
          onChanged: bloc.changeName,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            labelText: 'Name',
            errorText: snapshot.error,
          ),
        );
      },
    );
  }

  Widget mobileField(ContactBloc bloc, Contact contact) {
    return StreamBuilder(
      stream: bloc.mobile,
      builder: (context, snapshot) {
        return TextFormField(
          initialValue: contact.mobile,
          onChanged: bloc.changeMobile,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Mobile',
            errorText: snapshot.error,
          ),
        );
      },
    );
  }

  Widget landlineField(ContactBloc bloc, Contact contact) {
    return StreamBuilder(
      stream: bloc.landline,
      builder: (context, snapshot) {
        return TextFormField(
          initialValue: contact.landline,
          onChanged: bloc.changeLandline,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Landline',
            errorText: snapshot.error,
          ),
        );
      },
    );
  }

  Widget saveButton(ContactBloc bloc) {
    return StreamBuilder(
      stream: bloc.saveValid,
      builder: (context, snapshot) {
        return RaisedButton(
          child: Text('save'),
          color: Colors.blue,
          onPressed: snapshot.hasData
              ? () {
                  bloc.insertContact();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) {
                      return ContactListScreen();
                    },
                  ));
                }
              : null,
        );
      },
    );
  }

  Widget updateButton(ContactBloc bloc, Contact contact) {
    return StreamBuilder(
      stream: bloc.saveValid,
      builder: (context, snapshot) {
        return RaisedButton(
          child: Text('Update'),
          color: Colors.blue,
          onPressed: snapshot.hasData
              ? () {
                  bloc.updateContact(contact.id);
                  Navigator.of(context).pop(MaterialPageRoute(
                    builder: (context) {
                      return ContactListScreen();
                    },
                  ));
                }
              : null,
        );
      },
    );
  }

  Future<void> _takePicture() async {
    ImagePicker picker = ImagePicker();
    final imageFile = await picker.getImage(
      source: ImageSource.camera,
      maxWidth: 300,
    );
  }
}
