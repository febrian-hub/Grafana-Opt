#!/bin/bash
# setup-optimaxx.sh

# 1. Pastikan file branding ada
if [ ! -f "grafana_icon.svg" ] || [ ! -f "fav32.png" ]; then
    echo "[!] ERROR: File grafana_icon.svg atau fav32.png tidak ditemukan!"
    echo "[*] Letakkan file branding kamu dulu di folder ini."
    exit 1
fi

# 2. Buat background login jika belum ada (dari langkah sebelumnya)
if [ -f "bg-login.jpg" ]; then
    echo "[*] Membuat wrapper SVG untuk background..."
    echo "<svg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' width='1920' height='1080'><image xlink:href='data:image/jpeg;base64,$(base64 -w 0 bg-login.jpg)' width='1920' height='1080'/></svg>" > bg-login.svg
fi

# 3. Pastikan folder data punya izin yang benar
mkdir -p ./data
sudo chown -R 1000:1000 ./data

# 4. Jalankan Docker
sudo docker compose down
sudo docker compose up -d

echo "[✔] Optimaxx Platform Berhasil Dijalankan!"
