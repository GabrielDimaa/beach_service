import 'package:beach_service/app/shared/interfaces/form_controller_interface.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobx/mobx.dart';

part 'home_controller.g.dart';

class HomeController = _HomeController with _$HomeController;

abstract class _HomeController with Store implements IFormController {
  @observable
  double lat;

  @observable
  double lng;

  @observable
  bool loading = false;

  @observable
  bool enabledLocalization = false;

  @action
  void setLat(double value) => lat = value;

  @action
  void setLng(double value) => lng = value;

  @action
  void setLoading(bool value) => loading = value;

  @computed
  String get latLng => "$lat, $lng";

  @override
  Future<void> load() async {
    try {
      loading = true;

      Position position = await getLocalization();

      setLat(position.latitude);
      setLng(position.longitude);
    } catch (e) {
      print(e);
    } finally {
      loading = false;
    }
  }

  @override
  Future<void> save() async {}

  @override
  Future<void> delete() async {}

  Future<void> _verificarPermissao() async {
    enabledLocalization = await Geolocator.isLocationServiceEnabled();

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
}
