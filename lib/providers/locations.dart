import 'package:check_in/models/models.dart';
import 'package:flutter/material.dart';

class Locations with ChangeNotifier {
  final List<Location> _items = const [
    Location(
      nama: 'Hashmicro',
      latitude: -6.170182632685421,
      longitude: 106.8133758,
    ),
    Location(
      nama: 'Googleplex',
      latitude: 37.42221043046431,
      longitude: -122.08408970205251,
    ),
    Location(
      nama: 'Monas',
      latitude: -6.174373736239097,
      longitude: 106.827184983857,
    ),
    Location(
      nama: 'Masjid Istiqlal',
      latitude: -6.169828661518816,
      longitude: 106.83136853992966,
    ),
    Location(
      nama: 'Gereja Katedral Jakarta',
      latitude: -6.169019591221655,
      longitude: 106.83308597124454,
    ),
    Location(
      nama: 'Museum Nasional Indonesia',
      latitude: -6.176248487412215,
      longitude: 106.8215689669407,
    ),
    Location(
      nama: 'Galeri Nasional Indonesia',
      latitude: -6.177875522576055,
      longitude: 106.83276632363074,
    ),
  ];

  List<Location> get items {
    return [..._items];
  }
}
