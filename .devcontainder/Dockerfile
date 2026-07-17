FROM mcr.microsoft.com/devcontainers/base:ubuntu

RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    xz-utils \
    zip \
    libglu1-mesa \
    wget \
    clang \
    cmake \
    ninja-build \
    pkg-config \
    libgtk-3-dev \
    && apt-get clean

ENV FLUTTER_HOME=/opt/flutter

RUN git clone https://github.com/flutter/flutter.git $FLUTTER_HOME

ENV PATH="$FLUTTER_HOME/bin:$PATH"

RUN flutter doctor