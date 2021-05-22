import 'dart:async';

import 'package:flutter/cupertino.dart';

abstract class ISincronizacaoService {
  Future<void> runner();
  Future<void> start({BuildContext context});
  void stop();
}