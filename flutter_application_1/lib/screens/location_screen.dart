import 'package:flutter/material.dart';
import 'package:flutter_application_1/api/api.dart';
import 'package:flutter_application_1/model/destination.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);
  static const routeName = '/location-screen';

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final Location location = Location();
  late GoogleMapController _mapController;
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPiKey = 'AIzaSyBl4Dk9K_-hdpnlTxyMFUNcRwxMznWHwPo';
  Set<Marker> markers = Set(); //markers for google map
  Map<PolylineId, Polyline> polylines = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final wh = MediaQuery.of(context).size.width;
    final ht = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SafeArea(
            minimum: EdgeInsets.all(20),
            child: FutureBuilder(
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
                        markers.add(Marker(
                          //add start location marker
                          markerId: MarkerId('Start'),
                          position: LatLng(
                              ld.latitude!, ld.longitude!), //position of marker
                          infoWindow: InfoWindow(
                            //popup info
                            title: 'Starting Point ',
                            snippet: 'Start Marker',
                          ),
                          icon:
                              BitmapDescriptor.defaultMarker, //Icon for Marker
                        ));

                        markers.add(Marker(
                          //add distination location marker
                          markerId: MarkerId('End'),
                          position: LatLng(lat, long), //position of marker
                          infoWindow: InfoWindow(
                            //popup info
                            title: 'Destination Point ',
                            snippet: 'Destination Marker',
                          ),
                          icon:
                              BitmapDescriptor.defaultMarker, //Icon for Marker
                        ));

                        getDirections(LatLng(ld.latitude!, ld.longitude!),
                            LatLng(lat, long));
                        return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  height: ht * 0.3,
                                  width: wh,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1, color: Colors.grey[300]!),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                            child: ClipRRect(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                                child: GoogleMap(

                                                    //circles: {Circle(circleId: circleId)},
                                                    zoomControlsEnabled: false,
                                                    markers: markers,
                                                    polylines: Set<Polyline>.of(
                                                        polylines.values),
                                                    initialCameraPosition:
                                                        CameraPosition(
                                                            zoom: 15,
                                                            target: LatLng(
                                                                20.275965139259988,
                                                                85.77611047380825)),
                                                    onMapCreated: (controller) {
                                                      setState(() {
                                                        _mapController =
                                                            controller;
                                                      });
                                                    }))),
                                        Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 10),
                                            child: Text(
                                              'Tap on the map for complete address',
                                            ))
                                      ])),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Distance From User Location ${ld.latitude}, ${ld.longitude} To Destination $lat,$long is ' +
                                    distance.toString() +
                                    ' m or ' +
                                    (distance / 1000).toString() +
                                    ' km',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 25),
                              ),
                            ]);
                        // return
                      } else if (snapshot.data == null) {
                        return Text('No Data To Show!');
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
            )));

    // FutureBuilder(

    //   builder: builder)
  }

  getDirections(LatLng startLocation, LatLng endLocation) async {
    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPiKey,
      PointLatLng(startLocation.latitude, startLocation.longitude),
      PointLatLng(endLocation.latitude, endLocation.longitude),
      travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }
    addPolyLine(polylineCoordinates);
  }

  addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.deepPurpleAccent,
      points: polylineCoordinates,
      width: 8,
    );
    polylines[id] = polyline;
    setState(() {});
  }
}
