
# internet_popup

A package that shows a pop up alert when the internet connection is lost
[![MIT License](https://img.shields.io/apm/l/atomic-design-ui.svg?)](https://github.com/tterb/atomic-design-ui/blob/master/LICENSEs)



![App Screenshot](https://github.com/mehedidew/internet_popup/blob/master/Screenshot_20220321-162325.png?raw=true)



## Features

- auto popUp
- option to fix or pop the warning
- one line implementation




## Installation

In your pubspec.yaml

```bash
 dependencies:
    internet_popup: ^1.0.0
```


```bash
 import 'package:internet_popup/internet_popup.dart';
```


## Usage
initialize InternetPopup class and add context inside `initState()` funtion of the top of your widget tree.
```bash
 InternetPopup().initialize(context: context);
```

when the widget is popped from widget tree, initialize it again on next page.

If you want your own widget to popUp, use
```bash
 InternetPopup().initializeCustomWidget(context: context, widget: /*** your custom widget ***/);
```

You can write custom message title and description using `customMessage` and `customDescription` parameter inside initialize.

use `onTapPop` parameter to decide if the box can be removed before internet connection is back online.




## Example

```dart
import 'package:flutter/material.dart';
import 'package:internet_popup/internet_popup.dart';

class Example extends StatefulWidget {
  const Example({Key? key}) : super(key: key);

  @override
  _ExampleState createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  @override
  void initState() {
    super.initState();
    InternetPopup().initialize(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


```

