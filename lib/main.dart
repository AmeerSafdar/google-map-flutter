import 'package:flutter/material.dart';
import 'package:google_maps/current.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:NavPageScreenState(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Set<Marker> _markers={};
 void _onMapCreated(GoogleMapController controller){
   setState(() {
     _markers.add(
       Marker(
         markerId: MarkerId('id-1'),
         position: LatLng(28.708378,70.775554),
         infoWindow: InfoWindow(
           title: 'Aslam Town',
           snippet: "vey beautifull street,Bilal Live there "
         )
       )
     ); 

   });

 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body:SafeArea(
        child: GoogleMap(
          onMapCreated: _onMapCreated,
          markers: _markers,
          initialCameraPosition: (
          
          CameraPosition(
          target: LatLng(28.2470,70.0979),
          zoom: 10,
          tilt: 80,
          bearing: 30
          )
        )),
      ) 
      ,
      
    );
  }
}
