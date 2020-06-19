import 'package:flutter/material.dart';
import 'package:flutterapp/Models/ProductController.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:scoped_model/scoped_model.dart';

class MapProvider extends StatefulWidget {
  @override
  _MapProviderState createState() => _MapProviderState();
}

class _MapProviderState extends State<MapProvider> {
  TextEditingController _textController = TextEditingController();
  GoogleMapController mapController;
  bool map = false;

  static final LatLng _startingPoint = const LatLng(45.521563, -122.677433);

  Set<Marker> locationMarker = {
    Marker(markerId: MarkerId('Location'), position: _startingPoint)
  };

  void mapProvider(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    Future.delayed(Duration(seconds: 2)).then((_) {
      setState(() {
        map = true;
      });
      Future.delayed(Duration(seconds: 3)).then((_) => locationGetter(context));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextFormField(
          controller: _textController,
          decoration: InputDecoration(
            hintText: 'Cairo , Egypt',
            labelText: 'Address',
            suffixIcon: InkWell(
              child: Icon(Icons.location_searching),
              onTap: () => locationGetter(context),
            ),
          ),
          onFieldSubmitted: (data) => locationFromCity(data, context),
        ),
        Container(
          height: 200,
          width: MediaQuery.of(context).size.width * 0.9,
          child: Visibility(
            visible: map,
            child: GoogleMap(
              markers: locationMarker,
              zoomGesturesEnabled: false,
              onMapCreated: mapProvider,
              mapType: MapType.hybrid,
              initialCameraPosition: CameraPosition(
                target: _startingPoint,
                zoom: 17.0,
              ),
            ),
          ),
        ),
      ],
    );
  }

  locationGetter(BuildContext context) async {
    Position position = await Geolocator().getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    print(position);
    List<Placemark> placeMark = await Geolocator()
        .placemarkFromCoordinates(position.latitude, position.longitude);
    storeLocation(context, placeMark.first);
    showLocation(placeMark.first);
    animateLocation(placeMark.first.position);
  }

  locationFromCity(String city, BuildContext context) async {
    List<Placemark> placeMark = await Geolocator().placemarkFromAddress(city);
    print(placeMark.length);
    storeLocation(context, placeMark.first);
    showLocation(placeMark.first);
    animateLocation(placeMark.first.position);
  }

  showLocation(Placemark placeMark) {
    String value = placeMark.name +
        ' , ' +
        placeMark.subAdministrativeArea +
        ' , ' +
        placeMark.isoCountryCode;
    _textController.text = value;
  }

  animateLocation(Position position) async {
    LatLng _location = LatLng(position.latitude, position.longitude);
    CameraPosition cameraPosition =
        CameraPosition(target: _location, zoom: 16, tilt: 3);
    CameraUpdate cameraUpdate = CameraUpdate.newCameraPosition(cameraPosition);
    mapController.animateCamera(cameraUpdate);
    setState(() {
      locationMarker = {
        Marker(markerId: MarkerId('Your Location'), position: _location)
      };
    });
  }

  storeLocation(BuildContext context, Placemark placeMark) {
    ScopedModel.of<ProductModel>(context).currentProduct.location =
        placeMark.position;
    ScopedModel.of<ProductModel>(context).currentProduct.address =
        placeMark.name +
            ' , ' +
            placeMark.subAdministrativeArea +
            ' , ' +
            placeMark.isoCountryCode;
  }
}
