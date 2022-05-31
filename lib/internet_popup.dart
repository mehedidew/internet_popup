library internet_popup;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:internet_popup/src/custom_dialog.dart';

class InternetPopup {
  bool _isOnline = false;
  bool _isDialogOn = false;

  final Connectivity _connectivity = Connectivity();

  static final InternetPopup _internetPopup = InternetPopup._internal();

  factory InternetPopup() {
    return _internetPopup;
  }

  InternetPopup._internal();

  void initialize({
    required BuildContext context,
    String? customMessage,
    String? customDescription,
    bool? onTapPop = false,
  }) {
    final navigator = Navigator.of(context);
    _connectivity.checkConnectivity().then((result) async {
      if (result != ConnectivityResult.none) {
        _isOnline = await DataConnectionChecker().hasConnection;
      } else {
        _isOnline = false;
      }
      if (_isOnline == true) {
        if (_isDialogOn == true) {
          _isDialogOn = false;
          navigator.pop();
        }
      } else {
        _isDialogOn = true;
        Alerts(context: context).customDialog(
            type: AlertType.warning,
            message: customMessage ?? 'No Internet Connection Found!',
            description: customDescription ?? 'Please enable your internet',
            showButton: onTapPop,
            onTap: () {
              _isDialogOn = false;
              navigator.pop();
            });
      }
    });

    _connectivity.onConnectivityChanged.listen((result) async {
      if (result != ConnectivityResult.none) {
        _isOnline = await DataConnectionChecker().hasConnection;
      } else {
        _isOnline = false;
      }

      if (_isOnline == true) {
        if (_isDialogOn == true) {
          _isDialogOn = false;
          navigator.pop();
        }
      } else {
        _isDialogOn = true;
        Alerts(context: context).customDialog(
            type: AlertType.warning,
            message: customMessage ?? 'No Internet Connection Found!',
            description: customDescription ?? 'Please enable your internet',
            showButton: onTapPop,
            onTap: () {
              _isDialogOn = false;
              navigator.pop();
            });
      }
    });
  }

  void initializeCustomWidget(
      {required BuildContext context, required Widget widget}) {
    final navigator = Navigator.of(context);

    _connectivity.checkConnectivity().then((result) async {
      if (result != ConnectivityResult.none) {
        _isOnline = await DataConnectionChecker().hasConnection;
      } else {
        _isOnline = false;
      }

      if (_isOnline == true) {
        if (_isDialogOn == true) {
          _isDialogOn = false;
          navigator.pop();
        }
      } else {
        _isDialogOn = true;

        Alerts(context: context).showModalWithWidget(child: widget);
      }
    });

    _connectivity.onConnectivityChanged.listen((result) async {
      if (result != ConnectivityResult.none) {
        _isOnline = await DataConnectionChecker().hasConnection;
      } else {
        _isOnline = false;
      }

      if (_isOnline == true) {
        if (_isDialogOn == true) {
          _isDialogOn = false;
          navigator.pop();
        }
      } else {
        _isDialogOn = true;

        Alerts(context: context).showModalWithWidget(child: widget);
      }
    });
  }
}
