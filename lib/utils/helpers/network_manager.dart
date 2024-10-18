import 'dart:async';
import 'package:decordashapp/utils/logging/logger.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';

/// Manages the network connectivity status and provides methods to check and handle connectivity changes.
class NetworkManager extends GetxService {
  static NetworkManager get instance => Get.find();
  final RxList<ConnectivityResult> _connectionStatus =
      [ConnectivityResult.none].obs;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  final RxBool isOnline = false.obs;

  @override
  void onInit() {
    super.onInit();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void onClose() {
    _connectivitySubscription.cancel();
    super.onClose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    late List<ConnectivityResult> result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      LoggerHelper.error('Couldn\'t check connectivity status', e.toString());
      return;
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    _connectionStatus.value = result;
    isConnected();
  }

  /// Checks if the device is connected to any network.
  Future<void> isConnected() async {
    await initConnectivity();
    isOnline.value = _connectionStatus.isNotEmpty &&
        _connectionStatus.any((status) => status != ConnectivityResult.none);
  }
}
