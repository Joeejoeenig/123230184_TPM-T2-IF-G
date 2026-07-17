#!/bin/bash

flutter config --enable-web

if [ ! -f pubspec.yaml ]; then
    flutter create .
fi

flutter pub add provider
flutter pub add http
flutter pub add shared_preferences

flutter pub get