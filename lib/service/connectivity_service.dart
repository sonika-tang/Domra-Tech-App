import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();
  final InternetConnectionChecker _internetConnectionChecker = InternetConnectionChecker.createInstance();

  Future<bool> get isConnected async {
    // Check if we have a network connection (WiFi, Mobile, etc.)
    final List<ConnectivityResult> connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      if (connectivityResult.length == 1) {
        return false;
      }
    }

    // Now check if the connection has actual internet access
    return await _internetConnectionChecker.hasConnection;
  }
}
