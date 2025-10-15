class MyUsers {
  static const collectionName = 'users';
  String id;
  String name;
  String email;

  MyUsers({required this.id, required this.name, required this.email});

  MyUsers.fromFireStore(Map<String, dynamic> data)
    : this(id: data['id'], name: data['name'], email: data['email']);

  Map<String, dynamic> toFireStore() {
    return {'id': id, 'name': name, 'email': email};
  }
}
