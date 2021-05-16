import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

abstract class BaseViewmodel {
  final _loaderState = BehaviorSubject<bool>.seeded(false);

  Stream<bool> get stream => _loaderState.stream;

  void setLoading(bool isLoading) => _loaderState.isClosed ? null : _loaderState.add(isLoading);

  bool get isLoading => _loaderState.value;

  void updateState() => setLoading(isLoading);

  @mustCallSuper
  void dispose() {
    _loaderState.close();
  }

  forceClose() {
    GetIt.I.resetLazySingleton(instance: this);
  }
}
