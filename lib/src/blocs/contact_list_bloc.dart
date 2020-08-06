import 'package:ContactsApp/src/models/contact.dart';
import 'package:ContactsApp/src/resources/contact_db_provider.dart';
import 'package:rxdart/rxdart.dart';

class ContactListBloc {
  final _repository = ContactsDbProvider();
  final _contacts = BehaviorSubject<List<Contact>>();
  Stream<List<Contact>> get contacts => _contacts.stream;
  Function(List<Contact>) get changeContacts => _contacts.sink.add;

  ContactListBloc() {
    print('list bloc instance created');
  }
  fetchAllContacts() async {
    List<Contact> contacts = await _repository.fetchAllContacts();
    changeContacts(contacts);
  }

  dispose() {
    _contacts.close();
  }
}

final bloc = ContactListBloc();
