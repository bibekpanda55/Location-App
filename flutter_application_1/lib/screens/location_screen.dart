import 'package:flutter/material.dart';
import 'package:flutter_application_1/api/api.dart';
import 'package:flutter_application_1/model/destination.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);
  static const routeName = '/location-screen';

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final Location location = Location();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            minimum: EdgeInsets.all(20),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              FutureBuilder(
                future: destination(),
                builder: (ctxt, snapshot) {
                  if (snapshot.hasData) {
                    //print(snapshot.data);
                    final data = snapshot.data as Destination;
                    final lat = double.parse(data.destination.latitude);
                    final long = double.parse(data.destination.longitude);
                    // print(lat);
                    // print(long);

                    return FutureBuilder(
                      future: location.getLocation(),
                      builder: ((context, snapshot) {
                        if (snapshot.hasData) {
                          final LocationData ld = snapshot.data as LocationData;
                          final double distance = Geolocator.distanceBetween(
                              lat, long, ld.latitude!, ld.longitude!);
                          // print(ld.latitude.toString() +
                          //     ',' +
                          //     ld.longitude.toString());
                          return FutureBuilder(
                              future: getTime(
                                  lat, long, ld.latitude!, ld.longitude!),
                              builder: (c, s) {
                                if (snapshot.hasData) {
                                  print(snapshot.data);
                                  return Text(
                                    'Distance From User Location ${ld.latitude}, ${ld.longitude} To Destination $lat,$long is ' +
                                        distance.toString() +
                                        ' m or ' +
                                        (distance / 1000).toString() +
                                        ' km',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 25),
                                  );
                                } else if (snapshot.data == null) {
                                  return Text('Noooo Time!');
                                } else {
                                  return Text('Time not estimated!');
                                }
                              });
                        } else if (snapshot.data == null) {
                          return Text('Noooo!');
                        } else {
                          return Text('Allow location service!');
                        }
                      }),
                    );
                  } else if (snapshot.data == null) {
                    return Text('No data to show');
                  } else {
                    return Text('Error');
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              // FutureBuilder(

              //   builder: builder)
            ])));
  }
}
