#!/bin/bash

SWAP_SIZE=8G
SWAP_FILE=/swapfile

echo "🔹 Bắt đầu tạo swap $SWAP_SIZE..."

# Bước 1: Tạo file swap
sudo fallocate -l $SWAP_SIZE $SWAP_FILE || sudo dd if=/dev/zero of=$SWAP_FILE bs=1M count=$((8*1024))

# Bước 2: Phân quyền swap
sudo chmod 600 $SWAP_FILE

# Bước 3: Định dạng swap
sudo mkswap $SWAP_FILE

# Bước 4: Kích hoạt swap
sudo swapon $SWAP_FILE

# Bước 5: Thêm vào /etc/fstab để bật swap khi reboot
if ! grep -q "$SWAP_FILE" /etc/fstab; then
    echo "$SWAP_FILE none swap sw 0 0" | sudo tee -a /etc/fstab
fi

# Kiểm tra swap
echo "✅ Swap 8GB đã được tạo thành công!"
swapon --show
free -h
