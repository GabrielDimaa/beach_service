import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:beach_service/app/app_controller.dart';
import 'package:beach_service/app/modules/home/components/vendedor_dialog.dart';
import 'package:beach_service/app/modules/home/services/sincronizacao_service_interface.dart';
import 'package:beach_service/app/modules/user/dtos/user_prod_dto.dart';
import 'package:beach_service/app/modules/user/services/user_service_interface.dart';
import 'package:beach_service/app/modules/user/stores/user_store.dart';
import 'package:beach_service/app/shared/defaults/default_map.dart';
import 'package:beach_service/app/shared/interfaces/form_controller_interface.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobx/mobx.dart';

part 'home_controller.g.dart';

class HomeController = _HomeController with _$HomeController;

abstract class _HomeController with Store implements IFormController{
  final IUserService userService;
  final ISincronizacaoService sincronizacaoService;
  final AppController appController;

  _HomeController(this.userService, this.sincronizacaoService, this.appController);

  @observable
  List<UserProdDto> users = ObservableList<UserProdDto>();

  @observable
  bool loading = false;

  @observable
  bool enabledLocalization = false;

  @observable
  Set<Marker> markers = Set<Marker>().asObservable();

  @observable
  Marker myMarker;

  @observable
  List<Marker> userMarkers = ObservableList();

  @observable
  BuildContext context;

  @action
  void setLoading(bool value) => loading = value;

  @action
  void setEnabledLocalization(bool value) => enabledLocalization = value;

  @action
  void setMyMarker(Marker value) => myMarker = value;

  @action
  void setUserMarkers(List<Marker> value) => userMarkers.addAll(value);

  @action
  void setMarkers(List<Marker> value) => markers.addAll(value);

  @action
  void removeMarkers() => markers = Set<Marker>().asObservable();

  @action
  void setContext(BuildContext value) => context = value;

  @computed
  LatLng get latLng => LatLng(appController.userStore?.lat ?? DefaultMap.lat, appController.userStore?.lng ?? DefaultMap.lng);

  @override
  Future<void> load() async {
    try {
      loading = true;

      appController.userStore = UserStoreFactory.fromDto(await userService.getById(appController.loginStore.id));

      await getLocalization();

      users = await userService.getAllUserProd(appController.userStore.toDto()).asObservable();
      users.removeWhere((element) => element.base.id == appController.userStore.id);

      appController.userStore.setIsOnline(true);
      await updateMarkers();
    } catch (e) {
      rethrow;
    } finally {
      loading = false;

      await sincronizacaoService.start();
    }
  }

  @override
  Future<void> save() async {}

  @override
  Future<void> delete() async {}

  Future<void> _verificarPermissao() async {
    while(!enabledLocalization) {
      bool enabled = await Geolocator.isLocationServiceEnabled();

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();

        if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
          enabled = false;
        }
      }

      setEnabledLocalization(enabled);
    }
  }

  Future<void> getLocalization() async {
    await _verificarPermissao();
    Position position = await Geolocator.getCurrentPosition();

    appController.userStore.setLat(position.latitude);
    appController.userStore.setLng(position.longitude);
  }

  Future<void> updateMarkers() async {
    final Uint8List markerIconLocal = await _getBytesFromAsset('assets/images/local-marker.png', 70);
    final Uint8List markerIconUsers = await _getBytesFromAsset('assets/images/user-marker.png', 100);

    setMyMarker(
      Marker(
        markerId: MarkerId(appController.userStore.id.toString()),
        position: latLng,
        icon: BitmapDescriptor.fromBytes(markerIconLocal),
        infoWindow: InfoWindow(title: "Você está aqui!"),
      ),
    );

    userMarkers = ObservableList();
    users.forEach((element) async {
      if (element.lat != null && element.lng != null) {
        userMarkers.add(
          Marker(
            markerId: MarkerId(element.base.id.toString()),
            position: LatLng(element.lat, element.lng),
            icon: BitmapDescriptor.fromBytes(markerIconUsers),
            infoWindow: InfoWindow(
                title: element.nome,
                snippet: "Ver perfil",
                onTap: () {
                  VendedorDialog.show(context, userProdDto: element);
                }
            ),
          ),
        );
      }
    });

    removeMarkers();
    setMarkers([myMarker]);
    setMarkers(userMarkers);
  }

  Future<Uint8List> _getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png)).buffer.asUint8List();
  }
}
