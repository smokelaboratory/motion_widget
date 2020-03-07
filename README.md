# motion_widget

A simple, powerful widget to build cool transitions

## Features

- Fine-grained control with Interval
- Lightweight & fully customizable
- No boilerplate code
- Works with Row & Column
- Support for Translate & Fade modes
- Provides Exit transitions
- No code clean-up required

### Screenshots

![Screenshot](motion.gif)

## Usage

To use this plugin :

* Add the dependency

```yaml
  dependencies:
    flutter:
      sdk: flutter
    motion_widget:
```

* Use the widget as a Row or a Column

```dart
Motion<Row>(
    children: <Widget>[]
)
```

* Wrap its child with **MotionElement**

```dart
MotionElement(
    interval: Interval(0.3, 0.9)
    mode: MotionMode.FADE
    child: Container()
    orientation: MotionOrientation.HORIZONTAL_LEFT
)
```

* Provide **exitConfigurations** for exit transitions

```dart
Motion(
    exitConfigurations: MotionExitConfigurations(
        displacement: 200,
        orientation: MotionOrientation.HORIZONTAL_LEFT,
        durationMs: 400
    )
)
```

# Pull Requests

All the pull requests are welcomed. Please feel free to make valuable additions in the code.

### Created by

[Sumeet Rukeja](https://github.com/smokelaboratory) ([LinkedIn](https://in.linkedin.com/in/sumeet-rukeja-7a9b5711b))

# License

    Copyright 2020 Sumeet Rukeja

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.