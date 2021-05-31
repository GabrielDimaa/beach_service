import 'dart:async';
import 'package:beach_service/app/app_widget.dart';
import 'package:beach_service/app/modules/home/home_controller.dart';
import 'package:beach_service/app/modules/user/dtos/user_dto.dart';
import 'package:beach_service/app/shared/components/dialog/alert_dialog_widget.dart';
import 'package:beach_service/app/shared/components/drawer/drawer_widget.dart';
import 'package:beach_service/app/shared/components/loading/loading.dart';
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

  @override
  void initState() {
    super.initState();

    controller.setContext(context);
    _init();
  }

  Future<void> _init() async {
    try {
      await controller.load();

      _cameraPosition = _cameraPositionInitial();
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

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Observer(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: Text("Home"),
          iconTheme: theme.appBarTheme.iconTheme.copyWith(color: PaletaCores.primaryLight),
          elevation: 1,
        ),
        drawer: !controller.loading ? DrawerWidget() : null,
        body: Observer(
          builder: (_) => Stack(
            children: [
              Visibility(
                visible: controller.loading,
                child: LoadingWidget(description: "Aguarde...\nBuscando sua localização."),
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
                    markers: controller.markers,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
