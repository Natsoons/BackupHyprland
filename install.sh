#!/bin/bash

# Tentukan direktori penyimpanan
BACKUP_DIR="$HOME/BackupHyprland"
CONFIG_DIR="$HOME/.config"
PICTURES_DIR="$HOME/Pictures"
VIDEOS_DIR="$HOME/Videos"
WALL_DIR="$HOME/BackupHyprland/Wallpaper, GIF, dan lainnya"

# Daftar folder yang akan dipulihkan (bisa ditambah nanti jika ada aplikasi lain)
FOLDERS=("caelestia" "fastfetch")

echo "==========================================="
echo "  Memulai Pemulihan Konfigurasi Sistem...  "
echo "==========================================="

# Cek apakah folder backup benar-benar ada
if [ ! -d "$BACKUP_DIR" ] || [ ! -d "$WALL_DIR" ]; then
    echo "⚠️ Error: Folder $BACKUP_DIR  atau Folder $WALL_DIR tidak ditemukan!"
    echo "Pastikan kamu sudah mengunduhnya dari GitHub."
    exit 1
fi

# Looping (perulangan) untuk memproses setiap folder
for folder in "${FOLDERS[@]}"; do
    echo "[*] Memproses konfigurasi: $folder"

    # Hapus folder atau symlink lama jika sistem sedang rusak/bentrok
    if [ -e "$CONFIG_DIR/$folder" ] || [ -L "$CONFIG_DIR/$folder" ]; then
        echo "    - Menghapus folder/pengaturan lama yang rusak..."
        rm -rf "$CONFIG_DIR/$folder"
    fi
    
    # Menyalin folder fisik dari repo hasil clone ke dalam sistem
    echo "    + Mengganti folder dengan yang baru..."
    cp -r "$BACKUP_DIR/$folder" "$CONFIG_DIR/$folder"

done

ASSETS=(
"Wallpapers:$PICTURES_DIR"
"Fetch:$PICTURES_DIR"
"GIF:$VIDEOS_DIR"
)

for item in "${ASSETS[@]}"; do
    folder="${item%%:*}"
    tujuan="${item##*:}"
    
    echo "[*] Memindahkan folder $folder ke $tujuan..."
    cp -r "$WALL_DIR/$folder/" "$tujuan"
done

echo "==========================================="
echo " 🎉 Selesai! Semua sistem berhasil dipulihkan."
echo "==========================================="