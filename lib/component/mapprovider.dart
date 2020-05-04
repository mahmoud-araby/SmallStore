import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapProvider extends StatefulWidget {
  @override
  _MapProviderState createState() => _MapProviderState();
}

class _MapProviderState extends State<MapProvider> {
  // Uri _mapuri;

  bool map = false;

  GoogleMapController mapController;
  static final LatLng _center = const LatLng(45.521563, -122.677433);

  final Marker location =
      Marker(markerId: MarkerId('Location'), position: _center);

//  void mapprovider() {
//    final StaticMapProvider staticmapProvider =
//        StaticMapProvider('AIzaSyBHyq_cQeTMyjOIeR0Og8gAx_Zs0nuP93U');
//    final Uri newmapuri = staticmapProvider.getStaticUriWithMarkers(
//      [Marker('position', 'position', 41.40338, 2.17403)],
//      height: 200,
//      width: 500,
//      maptype: StaticMapViewType.roadmap,
//    );
//    setState(() {
//      _mapuri = newmapuri;
//    });
//  }

  void mapprovider(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    Future.delayed(Duration(seconds: 2)).then((value) {
      setState(() {
        map = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextFormField(
          decoration:
              InputDecoration(hintText: 'Cairo , Egypt', labelText: 'Address'),
          focusNode: FocusNode(
            onKey: (focusnode, action) {
              if (focusnode.hasFocus) return true;
              else      return null ;

            },
          ),
        ),
        //Image.network(_mapuri.toString()),
        Container(
          height: 200,
          width: MediaQuery.of(context).size.width * 0.9,
          child: Visibility(
            visible: map,
            child: GoogleMap(
              zoomGesturesEnabled: false,
              markers: {location},
              onMapCreated: mapprovider,
              mapType: MapType.hybrid,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 17.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
