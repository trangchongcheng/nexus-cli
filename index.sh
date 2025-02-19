#!/bin/bash

# Cập nhật hệ thống
echo "🔄 Đang cập nhật hệ thống..."
sudo apt update && sudo apt upgrade -y

# Cài đặt các gói cần thiết
echo "📦 Cài đặt các gói cần thiết..."
sudo apt install -y screen curl libssl-dev pkg-config build-essential git-all protobuf-compiler unzip

# Cài đặt Protobuf (protoc)
PROTOC_VERSION=29.3
echo "⬇️ Tải và cài đặt protoc ${PROTOC_VERSION}..."
cd /usr/local
sudo wget -q https://github.com/protocolbuffers/protobuf/releases/download/v${PROTOC_VERSION}/protoc-${PROTOC_VERSION}-linux-x86_64.zip
sudo unzip -o protoc-${PROTOC_VERSION}-linux-x86_64.zip
sudo chmod +x /usr/local/bin/protoc

# Cài đặt Rust
echo "🦀 Cài đặt Rust..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source $HOME/.cargo/env

echo "✅ Hoàn thành cài đặt, hãy chạy lênh screen"
