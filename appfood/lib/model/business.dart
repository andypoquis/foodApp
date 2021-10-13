import 'package:cloud_firestore/cloud_firestore.dart';

class BusinessDocument {
  final String? address, rubic, id, name;
  final GeoPoint? geoPoint;
  final Map? attentionHours;
  final List? categories;
  final List? contactNumber;
  final List? menu;
  final Map? plan;
  final String? rubicId;
  final String? clientId;

  final DateTime? createAt;
  BusinessDocument(
      {required this.address,
      required this.attentionHours,
      required this.categories,
      required this.clientId,
      required this.contactNumber,
      required this.geoPoint,
      required this.menu,
      required this.name,
      required this.plan,
      required this.rubic,
      required this.rubicId,
      // @required this.updateAt,
      this.createAt,
      this.id});

  BusinessDocument.fromJson(Map<String, Object?> data)
      : this(
            address: data['address']! as String,
            attentionHours: data['attentionHours']! as Map,
            categories: data['categories']! as List,
            clientId: data['clientId']! as String,
            contactNumber: data['contactNumber']! as List,
            geoPoint: data['geopoint']! as GeoPoint,
            menu: data['menu']! as List,
            name: data['name']! as String,
            plan: data['plan']! as Map,
            rubic: data['rubic']! as String,
            rubicId: data['rubicId']! as String,
            id: data['id']! as String);
  Map<String, Object?> toJson() {
    return {
      'address': address,
      'attentionHours': attentionHours,
      'categories': categories,
      'clientId': clientId,
      'contactNumbers': contactNumber,
      'createdAt': createAt,
      'deletedAt': null,
      'geopoint': geoPoint,
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
}
