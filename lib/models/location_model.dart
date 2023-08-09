class LocationModel {
  double? altitude;
  double? heading;
  double? latitude;
  double? accuracy;
  double? speedAccuracy;
  double? floor;
  bool? isMocked;
  double? speed;
  double? longitude;
  int? timestamp;

  LocationModel({
    this.altitude,
    this.heading,
    this.latitude,
    this.accuracy,
    this.speedAccuracy,
    this.floor,
    this.isMocked,
    this.speed,
    this.longitude,
    this.timestamp,
  });

  LocationModel.fromJson(Map<String, dynamic> json) {
    altitude = json['altitude'];
    heading = json['heading'];
    latitude = json['latitude'];
    accuracy = json['accuracy'];
    speedAccuracy = json['speed_accuracy'];
    floor = json['floor'];
    isMocked = json['is_mocked'];
    speed = json['speed'];
    longitude = json['longitude'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['altitude'] = this.altitude;
    data['heading'] = this.heading;
    data['latitude'] = this.latitude;
    data['accuracy'] = this.accuracy;
    data['speed_accuracy'] = this.speedAccuracy;
    data['floor'] = this.floor;
    data['is_mocked'] = this.isMocked;
    data['speed'] = this.speed;
    data['longitude'] = this.longitude;
    data['timestamp'] = this.timestamp;
    return data;
  }
}
