import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

enum AlertType { success, info, error, warning }

class Alerts {
  final BuildContext context;

  Alerts({required this.context});

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
                borderRadius: BorderRadius.circular(4.sp),
              ),
              backgroundColor: Colors.transparent,
              child: Stack(
                children: [
                  Positioned(
                    child: Container(
                      width: 80.w,
                      padding: EdgeInsets.only(
                          left: 1.5.h, top: 6.w, right: 1.5.h, bottom: 2.5.w),
                      margin: EdgeInsets.only(top: 5.6.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.sp),
                        border: Border.all(color: Colors.white, width: 1.5.sp),
                        // shape: BoxShape.rectangle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            offset: const Offset(0, 10),
                            blurRadius: 20.sp,
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
                              size: 25.sp,
                            ),
                          ),
                          SizedBox(
                            height: 2.w,
                          ),
                          Text(
                            message ?? defaultMessage,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context1).primaryColorDark,
                            ),
                          ),
                          SizedBox(
                            height: 2.0.w,
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
                                          style: TextStyle(
                                            fontSize: 10.0.sp,
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
                            height: 2.7.w,
                          ),
                          (showButton == true)
                              ? Align(
                                  alignment: Alignment.bottomRight,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.green,
                                      side: BorderSide(
                                          color: Colors.white, width: 1.0.sp),
                                    ),
                                    onPressed: onTap ??
                                        () {
                                          Navigator.pop(context1);
                                        },
                                    child: Text(
                                      'Ok',
                                      style: TextStyle(
                                        fontSize: 8.5.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )
                              : SizedBox(
                                  height: 3.h,
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
              borderRadius: BorderRadius.circular(6.sp),
            ),
            backgroundColor: Colors.transparent,
            child: child,
          );
        });
  }
}
