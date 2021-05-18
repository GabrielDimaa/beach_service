import 'dart:async';
import 'dart:isolate';
import 'package:beach_service/app/modules/home/home_controller.dart';
import 'package:beach_service/app/modules/home/services/sincronizacao_service_interface.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

class SincronizacaoService implements ISincronizacaoService {
  static HomeController controller;

  static Timer _timer;

  @override
  Future<void> runner() async {
    ReceivePort isolateListener = ReceivePort();
    ReceivePort port = ReceivePort();

    await Isolate.spawn(_entryPoint, port.sendPort);
    SendPort newIsolate = await port.first;

    newIsolate.send({'isolate': isolateListener.sendPort});

    return await isolateListener.first;
  }

  @override
  Future<void> start() async {
    print("== Iniciando sincronização ==");

    controller = Modular.get<HomeController>();

    if (_timer == null || !_timer.isActive) {
      _timer = Timer.periodic(Duration(seconds: 10), (timer) async {
        print("## Início Timer ##");
        await runner();
      });
    }
  }

  @override
  void stop() {
    print("== Parando sincronização ==");
    _timer?.cancel();
  }

  static void _entryPoint(SendPort message) {
    ReceivePort _receivePort = ReceivePort();
    message.send(_receivePort.sendPort);

    _receivePort.listen((message) {
      SendPort externalIsolate = message['isolate'];
      externalIsolate.send(_getUsers());
    });
  }

  static Future _getUsers() async {
    print(controller.userStore.nome);
    controller.users = await controller.userService.getAll().asObservable();
    controller.users.removeWhere((element) => element.base.id == controller?.userStore?.id ?? 0);
  }
}


