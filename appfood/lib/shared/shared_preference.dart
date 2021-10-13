import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesData {
  //Save data

  addAddress(String address) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('address', address);
  }

  addLatitude(String latitude) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('latitude', latitude);
  }

  addLongitude(String longitude) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('longitude', longitude);
  }

  addIsLogin(bool isLogin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLogin', isLogin);
  }

  //Read data

  Future<String?> getAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? address = prefs.getString('address');
    return address;
  }

  Future<bool?> getisLocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool? isLocation = prefs.getBool('isLocation');
    return isLocation;
  }

  getLatitude() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? latitude = prefs.getString('latitude');
    return latitude;
  }

  Future<List<String>> getDataClient() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String>? latitude = await prefs.getStringList('data_client');
    return latitude!;
  }

  getLongitude() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? longitude = prefs.getString('longitude');
    return longitude;
  }
}
