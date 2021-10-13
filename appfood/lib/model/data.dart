import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class DataModel extends ChangeNotifier {
//   User _user;
//   final List<int> _itemIds = [];
//   final List<String> _itemLocation = [];

//   User get user => _user;
//   set user(User newUser) {
//     _user = newUser;
//     notifyListeners();
//   }

//   String _location;
//   String get location => _location;
//   set location(String newlocation) {
//     _location = newlocation;
//     notifyListeners();
//   }

//   void addLocation(String location) {
//     _itemLocation.add(location);
//     notifyListeners();
//   }

//   void removeLocation(String location) {
//     _itemLocation.remove(location);
//     notifyListeners();
//   }

//   List<UserItem> get items => _itemIds.map((e) => _user.getById(e)).toList();
//   int get locations => items.fold(0, (total, current) => 1);

// //Guarda el ID
//   void add(UserItem item) {
//     _itemIds.add(item.id);
//     notifyListeners();
//   }

//   void remove(UserItem item) {
//     _itemIds.remove(item.id);
//     notifyListeners();
//   }
// }

class DataModel extends ChangeNotifier {
  final List<String> _itemsLocation = [];
  String ?_longitude;


  set longitude(String newLongitude) {
    _longitude = newLongitude;
    addAddress(_longitude!);
    notifyListeners();
  }

  void add(String longitude) {
    _itemsLocation.add(longitude);
    notifyListeners();
  }

  addAddress(String address) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('address', address);
  }

  Future<String?> getAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? address = await prefs.getString('address');
    return address;
  }

  void removeAll() {
    _itemsLocation.clear();
  }
}
