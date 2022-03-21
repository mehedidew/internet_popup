library internet_popup;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:internet_popup/custom_dialog.dart';

class InternetPopup {
  final BuildContext context;

  bool _isOnline = false;
  bool _isDialogOn = false;

  final Connectivity _connectivity = Connectivity();

  InternetPopup({required this.context});

  void initialize({
    String? customMessage,
    String? customDescription,
    bool? onTapPop,
  }) async {
    _connectivity.onConnectivityChanged.listen((result) async {
      if (result != ConnectivityResult.none) {
        _isOnline = await DataConnectionChecker().hasConnection;
      } else {
        _isOnline = false;
      }

      if (_isOnline == true) {
        if (_isDialogOn == true) {
          _isDialogOn = false;

          Navigator.of(context).pop();
        }
      } else {
        _isDialogOn = true;

        Alerts(context: context).customDialog(
          type: AlertType.warning,
          message: customMessage ?? 'No Internet Connection Found!',
          description: customDescription ?? 'Please enable your internet first and press OK',
          showButton: onTapPop,
          onTap: onTapPop == true
              ? () {
                  Navigator.of(context).pop();
                }
              : () {
                  if (_isOnline == true) {
                    Navigator.of(context).pop();
                  }
                },
        );
      }
    });
  }
}
