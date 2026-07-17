#!/bin/bash

echo "===== Flutter Version ====="
flutter --version

if [ ! -f pubspec.yaml ]; then
    echo "Creating Flutter project..."
    flutter create .
fi

flutter pub add provider
flutter pub add http
flutter pub add shared_preferences
flutter pub add intl

flutter pub get

mkdir -p lib/models
mkdir -p lib/screens
mkdir -p lib/providers
mkdir -p lib/services
mkdir -p lib/widgets
mkdir -p lib/utils

mkdir -p assets/images
mkdir -p assets/icons

echo "===== DONE ====="