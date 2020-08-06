class Contact {
  final String id;
  final String name;
  final String mobile;
  final String landline;
  final bool isFav;

  Contact({
    this.id,
    this.name,
    this.mobile,
    this.landline,
    this.isFav,
  });

  Contact.fromDb(Map<String, dynamic> dbVal)
      : id = dbVal['id'],
        name = dbVal['name'],
        mobile = dbVal['mobile'],
        landline = dbVal['landline'],
        isFav = dbVal['isFav'] == 1;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "name": name,
      "mobile": mobile,
      "landline": landline,
      "isFav": isFav ? 1 : 0
    };
  }
}
