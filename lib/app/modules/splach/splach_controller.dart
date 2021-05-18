import 'package:beach_service/app/app_controller.dart';
import 'package:mobx/mobx.dart';

part 'splach_controller.g.dart';

class SplachController = _SplachController with _$SplachController;

abstract class _SplachController with Store {
  final AppController appController;

  _SplachController(this.appController);

  @action
  Future<void> load() async => await appController.load();
}