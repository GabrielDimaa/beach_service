import 'dart:async';
import 'package:beach_service/app/modules/home/home_controller.dart';
import 'package:beach_service/app/modules/user/dtos/user_dto.dart';
import 'package:beach_service/app/shared/components/dialog/alert_dialog_widget.dart';
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
    try {
      await controller.load();

      _cameraPosition = _cameraPositionInitial();
      markers.add(_myMarker());
      markers.addAll(_vendedoresMakers());
    } catch (e) {
      AlertDialogWidget.show(context, content: e.toString());
    }
  }

  CameraPosition _cameraPositionInitial() {
    return CameraPosition(
      target: controller.latLng,
      zoom: DefaultMap.zoom,
    );
  }

  Marker _myMarker() {
    return Marker(
      markerId: MarkerId(controller.userStore.id.toString()),
      position: controller.latLng,
      infoWindow: InfoWindow(title: "Você está aqui!"),
    );
  }

  List<Marker> _vendedoresMakers() {
    List<Marker> listMakers = [];

    controller.users.forEach((element) {
      if (element.lat != null && element.lng != null) {
        listMakers.add(
          Marker(
            markerId: MarkerId(element.base.id.toString()),
            position: LatLng(element.lat, element.lng),
            infoWindow: InfoWindow(
              title: element.nome,
              snippet: "Ver perfil",
              onTap: () {print(element.nome);},
            ),
          ),
        );
      }
    });

    return listMakers;
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
