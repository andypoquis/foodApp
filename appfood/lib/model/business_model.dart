import 'package:cloud_firestore/cloud_firestore.dart';

class Business {
  final String? address, rubic, id, name;
  final GeoPoint geoPoint;
  final Map attentionHours;
  final List categories;
  final List contactNumber;
  final DateTime createdAt;
  //final DateTime deletedAt;
  final List menu;
  final Map plan;
  final String imageUrl;
  final String rubicId;
  final String clientId;
  final DateTime updateAt;
  //final DateTime? createAt;

  Business(
      {required this.address,
      required this.attentionHours,
      required this.categories,
      required this.clientId,
      required this.contactNumber,
      required this.createdAt,
      //  required this.deletedAt,
      required this.geoPoint,
      required this.imageUrl,
      required this.menu,
      required this.name,
      required this.plan,
      required this.rubic,
      required this.rubicId,
      required this.updateAt,
      // @required this.updateAt,

      this.id});

  factory Business.fromMap(dynamic data) => Business(
      address: data['address'],
      attentionHours: data['attentionHours'],
      categories: data['categories'],
      clientId: data['clientId'],
      contactNumber: data['contactNumber'],
      createdAt: data['createdAt'],
      // deletedAt: data['deletedAt'],
      geoPoint: data['geopoint'],
      imageUrl: data['imageUrl'],
      menu: data['menu'],
      name: data['name'],
      plan: data['plan'],
      rubic: data['rubic'],
      rubicId: data['rubicId'],
      updateAt: data['updateAt'],
      id: data['id']);

  Map<String, dynamic> toJson() => {
        'address': address,
        'attentionHours': attentionHours,
        'categories': categories,
        'clientId': clientId,
        'contactNumbers': contactNumber,
        'createdAt': DateTime.now(),
        'deletedAt': null,
        'geopoint': geoPoint,
        'imageUrl': imageUrl,
        'menu': menu,
        'name': name,
        'plan': plan,
        'premiunPdfMenu': null,
        'premiunQrCode': null,
        'rubic': rubic,
        'rubicIcon': 'fa fa-user',
        'rubicId': rubicId,
        'status': true,
        'updateAt': DateTime.now(),
      };
}
