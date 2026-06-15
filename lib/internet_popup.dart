library internet_popup;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:internet_popup/src/custom_dialog.dart';

class InternetPopup {
  bool _isOnline = false;
  bool _isDialogOn = false;
  BuildContext? _dialogContext;

  final Connectivity _connectivity = Connectivity();

  static final InternetPopup _internetPopup = InternetPopup._internal();

  factory InternetPopup() {
    return _internetPopup;
  }

  InternetPopup._internal();

  void initialize({required BuildContext context, String? customMessage, String? customDescription, bool? onTapPop = false, Function? onChange}) {
    _connectivity.checkConnectivity().then((result) async {
      if (!result.contains(ConnectivityResult.none)) {
        _isOnline = await InternetConnectionChecker.instance.hasConnection;
      } else {
        _isOnline = false;
      }
      if (!context.mounted) return;
      if (_isOnline == true) {
        _dismissDialog();
      } else {
        _showDialog(
          context: context,
          customMessage: customMessage,
          customDescription: customDescription,
          onTapPop: onTapPop,
        );
      }
    });

    _connectivity.onConnectivityChanged.listen((result) async {
      if (!result.contains(ConnectivityResult.none)) {
        _isOnline = await InternetConnectionChecker.instance.hasConnection;
      } else {
        _isOnline = false;
      }

      if (!context.mounted) return;
      if (_isOnline == true) {
        _dismissDialog();
      } else {
        _showDialog(
          context: context,
          customMessage: customMessage,
          customDescription: customDescription,
          onTapPop: onTapPop,
        );
      }
      if (onChange != null) {
        onChange(_isOnline);
      }
    });
  }

  void initializeCustomWidget({required BuildContext context, required Widget widget}) {
    _connectivity.checkConnectivity().then((result) async {
      if (!result.contains(ConnectivityResult.none)) {
        _isOnline = await InternetConnectionChecker.instance.hasConnection;
      } else {
        _isOnline = false;
      }

      if (!context.mounted) return;
      if (_isOnline == true) {
        _dismissDialog();
      } else {
        _showCustomDialog(context: context, widget: widget);
      }
    });

    _connectivity.onConnectivityChanged.listen((result) async {
      if (!result.contains(ConnectivityResult.none)) {
        _isOnline = await InternetConnectionChecker.instance.hasConnection;
      } else {
        _isOnline = false;
      }

      if (!context.mounted) return;
      if (_isOnline == true) {
        _dismissDialog();
      } else {
        _showCustomDialog(context: context, widget: widget);
      }
    });
  }

  void _showDialog({
    required BuildContext context,
    String? customMessage,
    String? customDescription,
    bool? onTapPop,
  }) {
    if (_isDialogOn) return;
    _isDialogOn = true;

    Alerts(context: context).customDialog(
      type: AlertType.warning,
      message: customMessage ?? 'No Internet Connection Found!',
      description: customDescription ?? 'Please enable your internet',
      showButton: onTapPop,
      onBuild: (dialogCtx) {
        if (_isOnline) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (dialogCtx.mounted) {
              Navigator.pop(dialogCtx);
            }
          });
          _isDialogOn = false;
          _dialogContext = null;
        } else {
          _dialogContext = dialogCtx;
        }
      },
      onTap: () {
        _dismissDialog();
      },
    );
  }

  void _showCustomDialog({required BuildContext context, required Widget widget}) {
    if (_isDialogOn) return;
    _isDialogOn = true;

    Alerts(context: context).showModalWithWidget(
      child: widget,
      onBuild: (dialogCtx) {
        if (_isOnline) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (dialogCtx.mounted) {
              Navigator.pop(dialogCtx);
            }
          });
          _isDialogOn = false;
          _dialogContext = null;
        } else {
          _dialogContext = dialogCtx;
        }
      },
    );
  }

  void _dismissDialog() {
    _isDialogOn = false;
    if (_dialogContext != null && _dialogContext!.mounted) {
      Navigator.pop(_dialogContext!);
      _dialogContext = null;
    }
  }

  Future<bool> checkInternet() async {
    bool isConnected = false;
    List<ConnectivityResult> connectivityResult = await _connectivity.checkConnectivity();
    if (!connectivityResult.contains(ConnectivityResult.none)) {
      isConnected = await InternetConnectionChecker.instance.hasConnection;
    }
    return isConnected;
  }

  Future<String> getConnectionType() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.mobile)) {
      return "mobile";
    } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
      return "wifi";
    } else {
      return "mobile";
    }
  }
}
