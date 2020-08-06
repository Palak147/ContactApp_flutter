import 'package:flutter/material.dart';

import 'contact_bloc.dart';

class ContactBlocProvider extends InheritedWidget {
  final contactBloc = ContactBloc();
  ContactBlocProvider({Key key, Widget child}) : super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static ContactBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ContactBlocProvider>())
        .contactBloc;
  }
}
