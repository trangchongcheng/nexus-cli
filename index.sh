#!/bin/bash

set -e  # Dừng script nếu có lỗi xảy ra

echo "🔄 Đang cập nhật hệ thống..."
sudo apt update && sudo DEBIAN_FRONTEND=noninteractive apt upgrade -y

echo "📦 Cài đặt các gói cần thiết..."
sudo apt install -y screen curl libssl-dev pkg-config build-essential git-all protobuf-compiler unzip

# Cài đặt Protobuf (protoc)
PROTOC_VERSION=29.3
PROTOC_ZIP="protoc-${PROTOC_VERSION}-linux-x86_64.zip"

echo "⬇️ Tải và cài đặt protoc ${PROTOC_VERSION}..."
cd /usr/local
sudo wget -q https://github.com/protocolbuffers/protobuf/releases/download/v${PROTOC_VERSION}/${PROTOC_ZIP}
sudo unzip -o ${PROTOC_ZIP}
sudo chmod +x /usr/local/bin/protoc
rm -f ${PROTOC_ZIP}  # Xóa file zip sau khi cài đặt

# Kiểm tra protoc
if ! command -v protoc &> /dev/null; then
    echo "❌ Lỗi: protoc chưa được cài đặt đúng, kiểm tra lại!"
    exit 1
else
    echo "✅ Protoc đã được cài đặt: $(protoc --version)"
fi

# Cài đặt Rust
echo "🦀 Cài đặt Rust..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source "$HOME/.cargo/env"

echo "✅ Hoàn thành cài đặt, hãy chạy lệnh 'screen -S nexus'"
