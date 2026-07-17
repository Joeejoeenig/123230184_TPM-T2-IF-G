#!/bin/bash
set -e

echo "Installing Flutter..."

sudo apt-get update
sudo apt-get install -y git curl unzip xz-utils zip libglu1-mesa

# Install Flutter jika belum ada
if [ ! -d "$HOME/flutter" ]; then
    git clone https://github.com/flutter/flutter.git -b stable "$HOME/flutter"
fi

# Tambahkan ke PATH jika belum ada
if ! grep -q 'flutter/bin' ~/.bashrc; then
    echo 'export PATH="$HOME/flutter/bin:$PATH"' >> ~/.bashrc
fi

export PATH="$HOME/flutter/bin:$PATH"

flutter config --enable-web
flutter doctor

echo ""
echo "====================================="
echo " Flutter siap digunakan!"
echo ""
echo "Untuk membuat project baru:"
echo "flutter create nama_project"
echo ""
echo "Atau:"
echo "mkdir nama_project"
echo "cd nama_project"
echo "flutter create ."
echo "====================================="