import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:native_features_demo/helpers/db_helper.dart';
import 'package:native_features_demo/helpers/location_helper.dart';
import 'package:native_features_demo/models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Future<void> addPlace(String pickedTitle, File pickedImage,
      PlaceLocation pickedLocation) async {
    final address = await LocationHelper.getPlaceAddress(
        pickedLocation.latitude, pickedLocation.longitude);
    final updatedLocation = PlaceLocation(
      latitude: pickedLocation.latitude,
      longitude: pickedLocation.longitude,
      address: address,
    );
    final newPlace = Place(
        id: DateTime.now().toString(),
        image: pickedImage,
        title: pickedTitle,
        location: updatedLocation);

    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat': newPlace.location.latitude,
      'loc_lng': newPlace.location.longitude,
      'address': newPlace.location.address,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    _items = dataList
        .map((item) => Place(
            id: item['id'],
            title: item['title'],
            location: PlaceLocation(
                latitude: item['loc_lat'],
                longitude: item['loc_lng'],
                address: item['address']),
            image: File(item['image'])))
        .toList();
    notifyListeners();
  }
}
