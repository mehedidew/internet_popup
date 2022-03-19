import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

enum AlertType { success, info, error, warning }

class Alerts {
  final BuildContext context;
  Alerts({required this.context});

  void floatingLoading({String? message}) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(4.sp)),
            height: 25.w,
            width: 10.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Center(
                  child: CircularProgressIndicator(
                    color: Colors.red,
                  ),
                ),
                SizedBox(
                  height: 2.w,
                ),
                Padding(
                  padding: EdgeInsets.all(3.sp),
                  child: Text(
                    message ?? "Loading",
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  // void showAlert({required AlertType type, String? message, String? confirmButton, VoidCallback? onPressed}) {
  //   IconData iconData;
  //   String defaultMessage;
  //   Color color;
  //   if (type == AlertType.success) {
  //     iconData = Icons.check_circle;
  //     defaultMessage = "SUCCESS";
  //     color = Colors.green;
  //   } else if (type == AlertType.error) {
  //     iconData = Icons.cancel;
  //     defaultMessage = "ERROR";
  //     color = Colors.red;
  //   } else {
  //     iconData = Icons.info;
  //     defaultMessage = "INFO";
  //     color = Colors.blueAccent;
  //   }
  //
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return Dialog(
  //         backgroundColor: Colors.transparent,
  //         child: Container(
  //           decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4.sp)),
  //           height: 20.h,
  //           width: 30,
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             children: [
  //               Center(
  //                   child: Icon(
  //                 iconData,
  //                 color: color,
  //                 size: 40,
  //               )),
  //               const SizedBox(
  //                 height: 5,
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.all(10.0),
  //                 child: Text(
  //                   message ?? defaultMessage,
  //                   style: message != null ? TextStyle(fontSize: 8.sp) : TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
  //                 ),
  //               ),
  //               Align(
  //                 alignment: Alignment.bottomRight,
  //                 child: MaterialButton(
  //                   onPressed: onPressed ??
  //                       () {
  //                         Navigator.of(context).pop();
  //                       },
  //                   child: Text(
  //                     confirmButton ?? "OK",
  //                     style: TextStyle(color: color),
  //                   ),
  //                 ),
  //               )
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  void showModalWithWidget({required Widget child, bool dismissible = false}) {
    showDialog(
        context: context,
        barrierDismissible: dismissible,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.sp)),
            child: child,
          );
        });
  }

  // void showChoice({
  //   required AlertType type,
  //   String? message,
  //   required String confirmButton,
  //   required VoidCallback onConfirm,
  //   String? cancelButton,
  //   VoidCallback? onCancel,
  // }) {
  //   IconData iconData;
  //   String defaultMessage;
  //   Color color;
  //   if (type == AlertType.success) {
  //     iconData = Icons.check_circle;
  //     defaultMessage = "SUCCESS";
  //     color = Colors.green;
  //   } else if (type == AlertType.error) {
  //     iconData = Icons.cancel;
  //     defaultMessage = "ERROR";
  //     color = Colors.red;
  //   } else {
  //     iconData = Icons.info;
  //     defaultMessage = "INFO";
  //     color = Colors.blue;
  //   }
  //
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return Dialog(
  //         backgroundColor: Colors.transparent,
  //         child: Container(
  //           decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
  //           height: 20.h,
  //           width: 30,
  //           child: Column(
  //             // mainAxisAlignment: MainAxisAlignment.center,
  //             // crossAxisAlignment: CrossAxisAlignment.center,
  //             children: [
  //               // const SizedBox(height:15,),
  //               Expanded(
  //                 child: Column(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   children: [
  //                     Center(
  //                         child: Icon(
  //                       iconData,
  //                       color: color,
  //                       size: 40,
  //                     )),
  //                     const SizedBox(
  //                       height: 5,
  //                     ),
  //                     Padding(
  //                       padding: const EdgeInsets.all(5.0),
  //                       child: Text(
  //                         message ?? defaultMessage,
  //                         style: message != null ? TextStyle(fontSize: 8.sp) : TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               Container(
  //                 padding: const EdgeInsets.only(top: 10, bottom: 10),
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.end,
  //                   children: [
  //                     MaterialButton(
  //                       onPressed: onConfirm,
  //                       child: Text(
  //                         confirmButton,
  //                         style: TextStyle(fontWeight: FontWeight.bold, color: color),
  //                       ),
  //                     ),
  //                     MaterialButton(
  //                       onPressed: onCancel ??
  //                           () {
  //                             Navigator.of(context).pop();
  //                           },
  //                       child: Text(
  //                         cancelButton ?? "Cancel",
  //                         style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               )
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  void customDialog({
    required AlertType type,
    String? message,
    String? description,
    String? button1,
    String? button2,
    bool twoButtons = false,
    VoidCallback? onTap1,
    VoidCallback? onTap2,
  }) {
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
        builder: (context) {
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
                      width: 40.h,
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
                              color: Theme.of(context).primaryColorDark,
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
                          Align(
                            alignment: Alignment.bottomRight,
                            child: (twoButtons == false)
                                ? ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.green,
                                      side: BorderSide(
                                          color: Colors.white, width: 1.0.sp),
                                    ),
                                    onPressed: onTap1 ??
                                        () {
                                          Navigator.pop(context);
                                        },
                                    child: Text(
                                      button1 ?? 'Done',
                                      style: TextStyle(
                                        fontSize: 8.5.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.green,
                                          side: BorderSide(
                                              color: Colors.white,
                                              width: 1.0.sp),
                                        ),
                                        onPressed: onTap1 ??
                                            () {
                                              Navigator.pop(context);
                                            },
                                        child: Text(
                                          button1 ?? 'Yes',
                                          style: TextStyle(
                                            fontSize: 8.5.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 2.0.w,
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.red,
                                          side: BorderSide(
                                              color: Colors.white,
                                              width: 1.0.sp),
                                        ),
                                        onPressed: onTap2 ??
                                            () {
                                              Navigator.pop(context);
                                            },
                                        child: Text(
                                          button2 ?? 'No',
                                          style: TextStyle(
                                            fontSize: 8.5.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
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
}
