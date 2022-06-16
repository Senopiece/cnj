import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkInfo {
  Connectivity connectivity;

  NetworkInfo(this.connectivity);

  /// checks internet is connected or not
  /// returns [true] if internet is connected
  /// else it will return [false]
  Future<bool> isConnected() async {
    final result = await connectivity.checkConnectivity();
    if (result != ConnectivityResult.none) {
      return true;
    }
    return false;
  }

  // to check type of internet connectivity
  Future<ConnectivityResult> get connectivityResult async {
    return connectivity.checkConnectivity();
  }

  // check the type on internet connection on changed of internet connection
  Stream<ConnectivityResult> get onConnectivityChanged =>
      connectivity.onConnectivityChanged;
}