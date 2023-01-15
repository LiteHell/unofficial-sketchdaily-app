# unofficial-sketchdaily-app
**DEVELOPMENT IN PROGRESS**

**unofficial-sketchdaily-app** is an mobile app of [SketchDaily reference](http://reference.sketchdaily.net/), developed in [Flutter](https://flutter.dev/)

Currently, this app is targeting Android only.

## How to build
1. [Install Flutter](https://docs.flutter.dev/get-started/install)
1. Clone this repository
1. Run these commands in cloned repository directory
    ```bash
    flutter pub get
    flutter pub run build_runner build
    ```
1. Run build command
    - To generate app bundle
        1. Run command `flutter build appbundle`
        1. Generated app bundle will be found on `/build/app/outputs/bundle/release/app-release.aeb`.
    - To generate apk file
        1. Run command `flutter build apk --split-per-abi` (If you want only one apk file targeting all abis, omit `--split-per-abi` parameter)
        1. Generated apk bundle files will be found in `/build/app/outputs/apk/release/` directory.

## License
Copyright (C) 2022 ~ 2023 Yeonjin Shin

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.

### Notice on advertisements or selling
Although this application is free software, You need permissions from [artomizer](mailto:artomizer@sketchdaily.net) if you want to put (an) advertisement(s) into the app or to sell it while using resources from [SketchDaily reference](http://reference.sketchdaily.net/).