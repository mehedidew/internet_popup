library internet_popup;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:internet_popup/custom_loading.dart';

class MyConnectivity {
  bool isOnline = false;
  bool isDialogOn = false;
  // final BuildContext context;

  // MyConnectivity._internal();
  // static final MyConnectivity _instance = MyConnectivity._internal();
  //
  // factory MyConnectivity() {
  //   return _instance;
  // }

  Connectivity connectivity = Connectivity();
  // StreamController controller = StreamController.broadcast();

  // MyConnectivity(this.context);
  // Stream get myStream => controller.stream;

  void initialize({required BuildContext context}) async {
    connectivity.onConnectivityChanged.listen((result) async {
      if (result != ConnectivityResult.none) {
        isOnline = await DataConnectionChecker().hasConnection;
      } else {
        isOnline = false;
      }
      // controller.sink.add(isOnline);

      if (isOnline == true) {
        if (isDialogOn == true) {
          isDialogOn = false;

          Navigator.of(context).pop();
        }
      } else {
        isDialogOn = true;

        Alerts(context: context).customDialog(
          type: AlertType.warning,
          message: 'No Internet Connection Found!',
          description: 'Please enable your internet first and press OK',
          onTap1: () {
            if (isOnline == true) {
              Navigator.of(context).pop();
            }
          },
        );
      }
    });
  }
}
