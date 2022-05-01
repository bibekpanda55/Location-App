import 'dart:convert';

class Destination {
  Destination({
    required this.status,
    required this.destination,
  });

  int status;
  DestinationClass destination;

  factory Destination.fromJson(Map<String, dynamic> json) => Destination(
        status: json["status"],
        destination: DestinationClass.fromJson(json["destination"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "destination": destination.toJson(),
      };
  static Destination destinationFromJson(String str) =>
      Destination.fromJson(json.decode(str));

  static String destinationToJson(Destination data) =>
      json.encode(data.toJson());
}

class DestinationClass {
  DestinationClass({
    required this.latitude,
    required this.longitude,
  });

  String latitude;
  String longitude;

  factory DestinationClass.fromJson(Map<String, dynamic> json) =>
      DestinationClass(
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}
