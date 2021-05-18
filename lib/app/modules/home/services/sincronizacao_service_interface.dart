import 'dart:async';

abstract class ISincronizacaoService {
  Future<void> runner();
  Future<void> start();
  void stop();
}