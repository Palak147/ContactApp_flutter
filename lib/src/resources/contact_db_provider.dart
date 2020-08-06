import 'package:ContactsApp/src/blocs/contact_list_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';
import '../models/contact.dart';

class ContactsDbProvider {
  final String columnId = 'id';
  final String columnName = 'name';
  final String columnMobile = 'mobile';
  final String columnLandline = 'landline';
  final String columnImage = 'image';
  final bool columnIsFav = false;
  Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await init();

    return _db;
  }

  init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, "contacts.db");
    var db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database newDb, int version) {
        newDb.execute("""
        CREATE TABLE Contacts(
          id TEXT PRIMARY KEY,
          name TEXT,
          mobile TEXT,
          landline TEXT,
          isFav INTEGER
        )

        """);
      },
    );
    return db;
  }

  Future<Contact> fetchContact(String id) async {
    var dbClient = await db;
    final maps = await dbClient.query(
      "Contacts",
      columns: null,
      where: "id = ?",
      whereArgs: [id],
    );

    if (maps.length > 0) {
      return Contact.fromDb(maps.first);
    }
    return null;
  }

  addContact(Contact contact) async {
    var dbClient = await db;
    dbClient.insert("Contacts", contact.toMap());
  }

  updateContact(Contact contact) async {
    var dbClient = await db;
    dbClient.update("Contacts", contact.toMap(),
        where: "id = ?",
        whereArgs: [contact.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Contact>> fetchAllContacts() async {
    var dbClient = await db;
    final maps = await dbClient.query(
      "Contacts",
      columns: null,
    );
    if (maps.length > 0) {
      return List<Contact>.from(maps.map((contact) => Contact.fromDb(contact)));
    }
    return null;
  }
}
