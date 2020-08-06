import 'package:ContactsApp/src/blocs/validators.dart';
import 'package:ContactsApp/src/models/contact.dart';
import 'package:ContactsApp/src/resources/contact_db_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

class ContactBloc extends Object with Validators {
  ContactBloc() {
    print("instance created");
  }

  var uuid = Uuid();
  final _repository = ContactsDbProvider();

  final _name = BehaviorSubject<String>();
  final _mobile = BehaviorSubject<String>();
  final _landline = BehaviorSubject<String>();
  //final _contacts = BehaviorSubject<List<Contact>>();

  //Get data
  Stream<String> get name => _name.stream.transform(validateName);
  Stream<String> get mobile => _mobile.stream.transform(validateMobile);
  Stream<String> get landline => _landline.stream.transform(validateLandline);
  //Stream<List<Contact>> get contacts => _contacts.stream;
  Stream<bool> get saveValid =>
      Rx.combineLatest3(name, mobile, landline, (n, m, l) => true);

  //Add data
  Function(String) get changeName => _name.sink.add;
  Function(String) get changeMobile => _mobile.sink.add;
  Function(String) get changeLandline => _landline.sink.add;
  // Function(List<Contact>) get changeContacts => _contacts.sink.add;

  // fetchAllContacts() async {
  //   List<Contact> contacts = await _repository.fetchAllContacts();
  //   changeContacts(contacts);
  // }

  insertContact() {
    Contact contact = new Contact(
      id: uuid.v1(),
      name: _name.value,
      mobile: _mobile.value,
      landline: _landline.value,
      isFav: false,
    );

    _repository.addContact(contact);
    //bloc.fetchAllContacts();
  }

  updateContact(String id) {
    Contact contact = new Contact(
      id: id,
      name: _name.value,
      mobile: _mobile.value,
      landline: _landline.value,
      isFav: false,
    );
    _repository.updateContact(contact);
    //bloc.fetchAllContacts();
  }

  Future<Contact> fetchContact(String contactId) async {
    var dbContact = await _repository.fetchContact(contactId);
    return dbContact;
  }

  dispose() async {
    _name.close();
    _mobile.close();
    _landline.close();
    // _contacts.close();
  }
}
