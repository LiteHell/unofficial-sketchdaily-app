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
    flutter pub run intl_translation:generate_from_arb --output-dir=lib/i18n --no-use-deferred-loading lib/i18n/messages.dart assets/i18n/intl_*.arb
    flutter pub run build_runner build
    ```
1. Run build command
    - To generate app bundle
        1. Run command `flutter build appbundle`
        1. Generated app bundle will be found on `/build/app/outputs/bundle/release/app-release.aeb`.
    - To generate apk file
        1. Run command `flutter build apk --split-per-abi` (If you want only one apk file targeting all abis, omit `--split-per-abi` parameter)
        1. Generated apk bundle files will be found in `/build/app/outputs/apk/release/` directory.

## How to translate
1. Do step 1~3 in "How to build" section.
1. Run `flutter pub run intl_translation:extract_to_arb --output-dir=assets/i18n lib/i18n/messages.dart`
1. Copy `assets/i18n/intl_messages.arb` to `assets/i18n/intl_[locale-code].arb`. For example, `asset/i18n/intl_ko.arb` for korean.
1. If you're adding new language, Add new locale in these fields and methods.
    - `supportedLocales` property in lib/main.dart
    - `isSupported` method of `AppLocalizationDelegate` class in lib/i18n/localizations.dart
1. Build and test

## License
Copyright (C) 2022 ~ 2023 Yeonjin Shin

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.

### Notice on advertisements or selling
Although this application is free software, You need permissions from [artomizer](mailto:artomizer@sketchdaily.net) if you want to put (an) advertisement(s) into the app or to sell it while using resources from [SketchDaily reference](http://reference.sketchdaily.net/).