/// A lightweight package that shows a popup dialog when the device
/// loses internet connectivity, and automatically dismisses it once
/// the connection is restored.
library internet_popup;

import 'package:flutter/cupertino.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:internet_popup/src/custom_dialog.dart';

/// Singleton controller that monitors internet connectivity and shows
/// a warning dialog whenever the device is offline.
///
/// Call [initialize] once (typically from the `initState` of your
/// app's root widget) to start listening for connectivity changes.
class InternetPopup {
  bool _isOnline = false;
  bool _isDialogOn = false;
  BuildContext? _dialogContext;
  String? customMessage;
  String? customDescription;
  bool? onTapPop = false;
  Function? onChange;

  final InternetConnection _internetConnection = InternetConnection.createInstance();

  static final InternetPopup _internetPopup = InternetPopup._internal();

  /// Returns the single shared [InternetPopup] instance.
  factory InternetPopup() {
    return _internetPopup;
  }

  InternetPopup._internal();

  /// Starts monitoring connectivity and shows a built-in warning dialog
  /// whenever the device has no internet access.
  ///
  /// - [context] is used to display the dialog and must belong to a
  ///   widget high enough in the tree to remain mounted for the app's
  ///   lifetime.
  /// - [customMessage] overrides the default dialog title.
  /// - [customDescription] overrides the default dialog body text.
  /// - [onTapPop] controls whether a dismiss button is shown.
  /// - [onChange] is called with the new connectivity state (`true`
  ///   when online) whenever it changes.
  void initialize({required BuildContext context, String? customMessage, String? customDescription, bool? onTapPop = false, Function? onChange}) {
    _internetConnection.hasInternetAccess.then((hasAccess) {
      _isOnline = hasAccess;
      if (!context.mounted) return;
      this.customMessage = customMessage;
      this.customDescription = customDescription;
      this.onTapPop = onTapPop;
      this.onChange = onChange;

      if (_isOnline == true) {
        _dismissDialog();
      } else {
        _showDialog(context: context);
      }
    });

    _internetConnection.onStatusChange.listen((status) {
      _isOnline = status == InternetStatus.connected;
      if (!context.mounted) return;
      if (_isOnline == true) {
        _dismissDialog();
      } else {
        _showDialog(context: context);
      }
      if (onChange != null) {
        onChange(_isOnline);
      }
    });
  }

  /// Same as [initialize], but displays your own [widget] instead of
  /// the built-in dialog when the device is offline.
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

  /// Returns `true` if the device currently has internet access.
  Future<bool> checkInternet() async {
    return await _internetConnection.hasInternetAccess;
  }

  /// Returns a rough description of the current connection type:
  /// `"wifi"` if online, `"mobile"` otherwise.
  ///
  /// Note: this is a coarse heuristic, not an actual network-type check.
  Future<String> getConnectionType() async {
    bool hasInternet = await _internetConnection.hasInternetAccess;
    return hasInternet ? "wifi" : "mobile";
  }
}
