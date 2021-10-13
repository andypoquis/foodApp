import 'dart:async';

import 'package:appfood/pages/utils/map_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationController extends ChangeNotifier {
  final Map<MarkerId, Marker> _markes = {};
  Set<Marker> get markers => _markes.values.toSet();

  final _markesController = StreamController<String>.broadcast();
  Stream<String> get onMarkerTap => _markesController.stream;

  Position? _initialPosition;
  String? _initialAddresString;
  String? get initialAddresString => _initialAddresString;
  Position? get initialPosition => _initialPosition;
  List<Placemark>? _initalAddress;
  List<Placemark>? get initalAddress => _initalAddress;

  late bool _gpsEnabled;
  bool get gpsEnabled => _gpsEnabled;

  bool _loading = true;
  bool get loading => _loading;

  StreamSubscription? _gpssubscription;

  LocationController() {
    _init();
  }

  void onMapCreated(GoogleMapController controller) {
    controller.setMapStyle(mapStyle);
  }

  Future<void> _init() async {
    _gpsEnabled = await Geolocator.isLocationServiceEnabled();
    _loading = false;
    _gpssubscription =
        Geolocator.getServiceStatusStream().listen((status) async {
      _gpsEnabled = status == ServiceStatus.enabled;
      await _getInitialPosition();
      notifyListeners();
    });
    await _getInitialPosition();

    notifyListeners();
  }

  Future<void> _getInitialPosition() async {
    if (_gpsEnabled && _initialPosition == null) {
      _initialPosition = await Geolocator.getCurrentPosition();
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _initialPosition!.latitude, _initialPosition!.longitude);

      _initialAddresString =
          '${placemarks[0].locality}  ${placemarks[0].subLocality}  ${placemarks[0].street}';
      notifyListeners();
    }
  }

  Future<void> turnOnGps() => Geolocator.openLocationSettings();

  void onTap(LatLng position) {
    final markerId = MarkerId(_markes.length.toString());
    final marker = Marker(
        markerId: markerId,
        position: position,
        onTap: () {
          print('UwU');
        });
    _markes[markerId] = marker;
    notifyListeners();
  }

  @override
  void dispose() {
    _gpssubscription!.cancel();
    _markesController.close();
    super.dispose();
  }
}
