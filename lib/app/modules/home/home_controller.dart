import 'dart:async';
import 'package:beach_service/app/app_controller.dart';
import 'package:beach_service/app/modules/home/components/vendedor_dialog.dart';
import 'package:beach_service/app/modules/home/services/sincronizacao_service_interface.dart';
import 'package:beach_service/app/modules/user/dtos/user_prod_dto.dart';
import 'package:beach_service/app/modules/user/services/user_service_interface.dart';
import 'package:beach_service/app/modules/user/stores/user_store.dart';
import 'package:beach_service/app/shared/defaults/default_map.dart';
import 'package:beach_service/app/shared/interfaces/form_controller_interface.dart';
import 'package:flutter/cupertino.dart';
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
  UserStore userStore = UserStore();

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
  void setContext(BuildContext value) => context = value;

  @computed
  LatLng get latLng => LatLng(userStore?.lat ?? DefaultMap.lat, userStore?.lng ?? DefaultMap.lng);

  @override
  Future<void> load() async {
    try {
      loading = true;

      userStore = UserStoreFactory.fromDto(await userService.getById(appController.loginStore.id));

      users = await userService.getAllUserProd(userStore.toDto()).asObservable();
      users.removeWhere((element) => element.base.id == userStore.id);

      Position position = await getLocalization();

      userStore.setLat(position.latitude);
      userStore.setLng(position.longitude);

      getMyMarker();
      getUsersMakers();
      addMarkers();
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
    setEnabledLocalization(await Geolocator.isLocationServiceEnabled());

    if (!enabledLocalization) return Future.error('Os serviços de localização estão desativados.');

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) return Future.error('Permissões de localização negadas.');
    }

    if (permission == LocationPermission.deniedForever) return Future.error('As permissões de localização são negadas permanentemente, não podemos solicitar permissões.');
  }

  Future<Position> getLocalization() async {
    await _verificarPermissao();

    return await Geolocator.getCurrentPosition();
  }

  void getMyMarker() {
    setMyMarker(
      Marker(
        markerId: MarkerId(userStore.id.toString()),
        position: latLng,
        infoWindow: InfoWindow(title: "Você está aqui!"),
      ),
    );
  }

  void getUsersMakers() {
    userMarkers = ObservableList();

    users.forEach((element) {
      if (element.lat != null && element.lng != null) {
        userMarkers.add(
          Marker(
            markerId: MarkerId(element.base.id.toString()),
            position: LatLng(element.lat, element.lng),
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
  }

  void addMarkers() {
    markers.add(myMarker);
    markers.addAll(userMarkers);
  }
}
