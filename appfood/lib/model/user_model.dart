class User {
  final String? cellphone, email, names, id;
  final DateTime createdAt;

  User(
      {required this.cellphone,
      required this.createdAt,
      required this.email,
      required this.names,
      this.id});

  factory User.fromMap(dynamic data) => User(
      cellphone: data['cellphone'].toString(),
      createdAt: data['createdAt'],
      email: data['email'].toString(),
      names: data['anames'].toString(),
      id: data['id']);

  Map<String, dynamic> toJson() => {
        'cellphone': cellphone,
        'createAt': createdAt,
        'names': names,
        'id': id,
      };
}
