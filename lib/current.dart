import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// class GooglMapsRoute extends StatefulWidget {
//   const GooglMapsRoute({ Key key }) : super(key: key);

//   @override
//   State<GooglMapsRoute> createState() => _GooglMapsRouteState();
// }

// class _GooglMapsRouteState extends State<GooglMapsRoute> {
  
// final LatLng dest_location = LatLng(37.42796133580664, -122.085749655962);
//   @override
//   Widget build(BuildContext context) {
//      Completer<GoogleMapController> _controllerGoogleMap = Completer();
//   GoogleMapController newGoogleMapController;
//   Position currentPosition;
//   var geoLocator = Geolocator();
//   Map<MarkerId, Marker> markers = {};
//   Map<PolylineId, Polyline> polylines = {};
//   List<LatLng> polylineCoordinates = [];
//   PolylinePoints polylinePoints = PolylinePoints();

      
//   void locatePosition() async {
//     Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//     currentPosition = position;
//   }

//    final CameraPosition _UserLocation = CameraPosition(
//     target: LatLng(37.42796133580664, -122.085749655962),
//     //target: LatLng(26.0667, 50.5577),
//     zoom: 16,
//   );
//   @override
//   void initState() {
//     super.initState();
//     locatePosition();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Google Maps'),
//         backgroundColor: Colors.redAccent,
        
//       ),
//       body: GoogleMap(
//         mapType: MapType.normal,
//         myLocationButtonEnabled: true,
//         initialCameraPosition: _UserLocation,
//         polylines: Set<Polyline>.of(polylines.values),
//         markers: Set<Marker>.of(markers.values),
//         myLocationEnabled: true,
//         zoomGesturesEnabled: true,
//         zoomControlsEnabled: true,
//         onMapCreated: (GoogleMapController controller) {
//           _controllerGoogleMap.complete(controller);
//           newGoogleMapController = controller;
         
//         getPolyline();
//           setState(() {});
//         },
//       ),
//     );
//   }
//  void getPolyline() async {
//     /// add origin marker origin marker
    
//   _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
//     MarkerId markerId = MarkerId(id);
//     Marker marker =
//         Marker(markerId: markerId, icon: descriptor, position: position);
//     markers[markerId] = marker;
//   }

//   _addPolyLine(List<LatLng> polylineCoordinates) {
//     PolylineId id = PolylineId("poly");
//     Polyline polyline = Polyline(
//       polylineId: id,
//       points: polylineCoordinates,
//       width: 8,
//     );
//     polylines[id] = polyline;
//     setState(() {});
//   }

//   void _getPolyline() async {
//     /// add origin marker origin marker
//     _addMarker(
//       LatLng(currentPosition.latitude, currentPosition.longitude),
//       "origin",
//       BitmapDescriptor.defaultMarker,
//     );

//     // Add destination marker
//     _addMarker(
//       LatLng(dest_location.latitude, dest_location.longitude),
//       "destination",
//       BitmapDescriptor.defaultMarkerWithHue(90),
//     );

//     List<LatLng> polylineCoordinates = [];

//     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//       "Your_key",
//       PointLatLng(currentPosition.latitude, currentPosition.longitude),
//       PointLatLng(dest_location.latitude, dest_location.longitude),
//       travelMode: TravelMode.walking,
//     );
//     if (result.points.isNotEmpty) {
//       result.points.forEach((PointLatLng point) {
//         polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//       });
//     } else {
//       print(result.errorMessage);
//     }
//     _addPolyLine(polylineCoordinates);
//   }
//   }
// }
// }
const LatLng dest_location = LatLng(28.2470,70.0979);
class NavPageScreenState extends StatefulWidget {
  static final CameraPosition _UserLocation = CameraPosition(
    target: LatLng(28.2470,70.0979),
    //target: LatLng(26.0667, 50.5577),
    zoom: 16,
  );

  @override
  __NavPageScreenStateState createState() => __NavPageScreenStateState();
}

class __NavPageScreenStateState extends State<NavPageScreenState> {
  Completer<GoogleMapController> _controllerGoogleMap = Completer();

  GoogleMapController newGoogleMapController;

  Position currentPosition;

  var geoLocator = Geolocator();

  Map<MarkerId, Marker> markers = {};

  Map<PolylineId, Polyline> polylines = {};

  List<LatLng> polylineCoordinates = [];

  PolylinePoints polylinePoints = PolylinePoints();

  String address="Search";

  void locatePosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;
    print("currentposition $currentPosition");
    // GetAddressFromLatLong(currentPosition);
    _getAddressFromLatLng(currentPosition);
  }

   _getCurrentLocation() {
    Geolocator
      .getCurrentPosition(desiredAccuracy: LocationAccuracy.best, forceAndroidLocationManager: true)
      .then((Position position) {
        setState(() {
          currentPosition = position;
          print(currentPosition);
          // GetAddressFromLatLong(currentPosition);
          _getAddressFromLatLng(currentPosition);
        });
      }).catchError((e) {
        print(e);
      });
  }

   _getAddressFromLatLng(Position position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        currentPosition.latitude,
        currentPosition.longitude
      );

      Placemark place = placemarks[0];

      setState(() {
        address = "${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}";
        print("address is $address");
      });
    } catch (e) {
      print(e);
    }
  }

  // Future<void> GetAddressFromLatLong(Position position)async {
  //   List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
  //   print(placemarks);
  //   Placemark place = placemarks[0];
  //   address = ' ${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
  //   setState(() {
  //     print('address is = $address');
  //   });
  // }

  @override
  void initState() {
    // Position position = Geolocator.getCurrentPosition(
    //     desiredAccuracy: LocationAccuracy.high) as Position;
    //  _getCurrentLocation();
     
    // _getAddressFromLatLng(currentPosition);
    super.initState();
    // locatePosition();
    _getCurrentLocation();
    // GetAddressFromLatLong(currentPosition);
    _getAddressFromLatLng(currentPosition);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          print("currentr userr ${currentPosition}");
          // GetAddressFromLatLong(currentPosition);
          _getAddressFromLatLng(currentPosition);
          print('address $address');

        },
        
        ),
      appBar: AppBar(
        title: Text('Google Maps'),
        backgroundColor: Colors.redAccent,
        leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
               Navigator.pop(context);
            }),
      ),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            initialCameraPosition: NavPageScreenState._UserLocation,
            polylines: Set<Polyline>.of(polylines.values),
            markers: Set<Marker>.of(markers.values),
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              _controllerGoogleMap.complete(controller);
              newGoogleMapController = controller;
              _getPolyline();

              setState(() {});
            },
          ),
          
          Text('${address}',style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold),),
        ],
      ),
    );
  }

  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker =
        Marker(markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;
  }

  _addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      points: polylineCoordinates,
      width: 8,
    );
    polylines[id] = polyline;
    setState(() {});
  }

  void _getPolyline() async {
    /// add origin marker origin marker
    _addMarker(
      LatLng(currentPosition.latitude, currentPosition.longitude),
      "origin",
      BitmapDescriptor.defaultMarker,
    );

    // Add destination marker
    _addMarker(
      LatLng(dest_location.latitude, dest_location.longitude),
      "destination",
      BitmapDescriptor.defaultMarkerWithHue(90),
    );

    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyDG3J4GwEl8gZ4RR7sh26rZcNyrjdliPsc",
      PointLatLng(currentPosition.latitude, currentPosition.longitude),
      PointLatLng(dest_location.latitude, dest_location.longitude),
      travelMode: TravelMode.walking,
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }
    _addPolyLine(polylineCoordinates);
  }
}