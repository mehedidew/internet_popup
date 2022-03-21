
# internet_popup

A package that shows a pop up alert when the internet connection is lost


![App Screenshot](https://github.com/mehedidew/internet_popup/blob/master/Screenshot_20220321-162325.png)


# Installation
initialize InternetPopup class and add context inside `initState()` funtion of the top of your widget tree.
```bash
 InternetPopup().initialize(context: context);
```

when the widget is popped from widget tree, initialize it again on next page. 

If you want your own widget to popUp, use
```bash
 InternetPopup().initializeCustomWidget(context: context, widget: /*** your custom widget ***/);
```