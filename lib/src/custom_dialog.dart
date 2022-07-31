import 'package:flutter/material.dart';

enum AlertType { success, info, error, warning }

class Alerts {
  final BuildContext context;
  double h;
  double w;

  Alerts({required this.context})
      : h = MediaQuery.of(context).size.height,
        w = MediaQuery.of(context).size.width;

  void customDialog(
      {required AlertType type,
      String? message,
      String? description,
      bool? showButton,
      VoidCallback? onTap}) {
    IconData iconData;
    String defaultMessage;
    Color color;
    if (type == AlertType.success) {
      iconData = Icons.check_circle;
      defaultMessage = "SUCCESS";
      color = Colors.green;
    } else if (type == AlertType.error) {
      iconData = Icons.cancel;
      defaultMessage = "ERROR";
      color = Colors.red;
    } else if (type == AlertType.warning) {
      iconData = Icons.warning;
      defaultMessage = "WARNING";
      color = Colors.yellow;
    } else {
      iconData = Icons.info;
      defaultMessage = "INFO";
      color = Colors.blue;
    }
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context1) {
          return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              backgroundColor: Colors.transparent,
              child: Stack(
                children: [
                  Positioned(
                    child: Container(
                      width: w * 0.8,
                      padding: EdgeInsets.only(
                          left: w * .015,
                          top: h * .03,
                          right: w * .015,
                          bottom: h * .01),
                      margin: EdgeInsets.only(top: h * .05),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.white, width: 1.5),
                        // shape: BoxShape.rectangle,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black,
                            offset: Offset(0, 10),
                            blurRadius: 40,
                          )
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Icon(
                              iconData,
                              color: color,
                              size: 45,
                            ),
                          ),
                          SizedBox(
                            height: h * .02,
                          ),
                          Text(
                            message ?? defaultMessage,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context1).primaryColorDark,
                            ),
                          ),
                          SizedBox(
                            height: h * .02,
                          ),
                          (description == null)
                              ? const SizedBox()
                              : Flexible(
                                  child: ListView(
                                    shrinkWrap: true,
                                    children: [
                                      Center(
                                        child: Text(
                                          description,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                          SizedBox(
                            height: h * .02,
                          ),
                          (showButton == true)
                              ? Align(
                                  alignment: Alignment.bottomRight,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.green,
                                      side: const BorderSide(
                                          color: Colors.white, width: 1.0),
                                    ),
                                    onPressed: onTap ??
                                        () {
                                          Navigator.pop(context1);
                                        },
                                    child: const Text(
                                      'Ok',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )
                              : SizedBox(
                                  height: h * .03,
                                ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void showModalWithWidget({required Widget child}) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            backgroundColor: Colors.transparent,
            child: child,
          );
        });
  }
}
