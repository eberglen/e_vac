import 'package:google_maps_flutter/google_maps_flutter.dart';

class evacCenters {
  String evacName;
  String address;
  String description;
  String thumbnail;
  LatLng loclatlng;

  evacCenters({
    this.address,
    this.description,
    this.evacName,
    this.loclatlng,
    this.thumbnail});
}

final List<evacCenters> evacList = [
  evacCenters(
    evacName: 'Bagong Ilog Elementary School',
    address: 'Sgt. Pascual St.',
    description: 'Phone: (02) 8671 0722',
    loclatlng: LatLng(14.5637,121.0712),
    thumbnail: 'https://i0.wp.com/josephfeeding.org/wp-content/uploads/2015/03/150114-WEB-BAGONG-ILOG-ELEMENTARY-SCHOOL-012.jpg?fit=1024%2C575'
  ),
  evacCenters(
      evacName: 'Caniogan Elementary School',
      address: 'Kalinangan St. Caniogan',
      description: 'Phone: (02) 8641 2582',
      loclatlng: LatLng(14.5718,121.0785),
      thumbnail: 'https://lh5.googleusercontent.com/p/AF1QipNvbUhAedAWwe0mjV5x_A-JKcEh1YkAZaPdqYJS=w213-h160-k-no'
  ),
  evacCenters(
      evacName: 'Rizal High School',
      address: 'Dr. Sixto Antonio Avenue',
      description: 'Phone: 0976 947 2375',
      loclatlng: LatLng(14.5680,121.0761),
      thumbnail: 'https://lh5.googleusercontent.com/p/AF1QipNWhhHh34b8EXa8kxRojndaugQIuFf61xHRYPGX=w238-h160-k-no'
  ),
];
