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
    markers.add(_MyMarker());
    markers.addAll(_VendedoresMakers());
  }

  CameraPosition _cameraPositionInitial() {
    return CameraPosition(
      target: controller.latLng,
      zoom: DefaultMap.zoom,
    );
  }

  Marker _MyMarker() {
    return Marker(
      markerId: MarkerId("1234"),
      position: controller.latLng,
      infoWindow: InfoWindow(title: "Você está aqui"),
    );
  }

  List<Marker> _VendedoresMakers() {
    return [
      Marker(
        markerId: MarkerId("1245345334"),
        position: LatLng(-29.338411, -49.722292),
        infoWindow: InfoWindow(
          title: controller.userStore.nome ?? "Testando 1",
          snippet: "Ver perfil",
          onTap: () {},
        ),
      ),
      Marker(
        markerId: MarkerId("534"),
        position: LatLng(-29.337892, -49.722017),
        infoWindow: InfoWindow(
          title: controller.userStore.nome ?? "Testando 2",
          snippet: "Ver perfil",
          onTap: () {},
        ),
      )
    ];
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
            Visibility(
              visible: controller.loading,
              child: LoadingWidget(description: "Aguarde...\nEstamos buscando sua localização."),
            ),
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
