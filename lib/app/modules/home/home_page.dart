import 'dart:async';
import 'package:beach_service/app/modules/home/home_controller.dart';
import 'package:beach_service/app/modules/user/dtos/user_dto.dart';
import 'package:beach_service/app/shared/components/loading.dart';
import 'package:beach_service/app/shared/defaults/default_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  final UserDto dto;

  const HomePage({Key key, this.dto}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  Completer<GoogleMapController> _controllerMap = Completer<GoogleMapController>();
  CameraPosition _cameraPosition;
  Set<Marker> markers = Set<Marker>();

  @override
  void initState() {
    super.initState();

    _init();
  }

  Future<void> _init() async {
    await controller.load();

    _cameraPosition = _cameraPositionInitial();
    markers.add(_createMarker());
  }

  CameraPosition _cameraPositionInitial() {
    return CameraPosition(
      target: LatLng(controller.lat ?? DefaultMap.lat, controller.lng ?? DefaultMap.lng),
      zoom: DefaultMap.zoom,
    );
  }

  Marker _createMarker() {
    return Marker(
      markerId: MarkerId("1234"),
      position: LatLng(controller.lat, controller.lng),
      infoWindow: InfoWindow(title: "My Location"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      drawer: Drawer(),
      body: Observer(
        builder: (_) => Stack(
          children: [
            Visibility(visible: controller.loading, child: LoadingWidget(description: "Aguarde...\nEstamos buscando sua localização.",)),
            Visibility(
              visible: !controller.loading,
              child: Observer(
                builder: (_) => GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: _cameraPosition,
                  onTap: (LatLng latLng) {},
                  onMapCreated: (GoogleMapController controllerMap) {
                    if (controller.enabledLocalization) _controllerMap.complete(controllerMap);
                  },
                  markers: markers,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
