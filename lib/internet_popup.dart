library internet_popup;

import 'package:flutter/cupertino.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:internet_popup/src/custom_dialog.dart';

class InternetPopup {
  bool _isOnline = false;
  bool _isDialogOn = false;
  BuildContext? _dialogContext;

  final InternetConnection _internetConnection = InternetConnection.createInstance();

  static final InternetPopup _internetPopup = InternetPopup._internal();

  factory InternetPopup() {
    return _internetPopup;
  }

  InternetPopup._internal();

  void initialize({required BuildContext context, String? customMessage, String? customDescription, bool? onTapPop = false, Function? onChange}) {
    _internetConnection.hasInternetAccess.then((hasAccess) {
      _isOnline = hasAccess;
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

    _internetConnection.onStatusChange.listen((status) {
      _isOnline = status == InternetStatus.connected;
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
    _internetConnection.hasInternetAccess.then((hasAccess) {
      _isOnline = hasAccess;
      if (!context.mounted) return;
      if (_isOnline == true) {
        _dismissDialog();
      } else {
        _showCustomDialog(context: context, widget: widget);
      }
    });

    _internetConnection.onStatusChange.listen((status) {
      _isOnline = status == InternetStatus.connected;
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
    return await _internetConnection.hasInternetAccess;
  }

  Future<String> getConnectionType() async {
    bool hasInternet = await _internetConnection.hasInternetAccess;
    return hasInternet ? "wifi" : "mobile";
  }
}
