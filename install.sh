#!/bin/bash

# Tentukan direktori penyimpanan
BACKUP_DIR="$HOME/BackupHyprland"
CONFIG_DIR="$HOME/.config"
PICTURES_DIR="$HOME/Pictures"
VIDEOS_DIR="$HOME/Videos"
WALL_DIR="$HOME/BackupHyprland/Wallpaper, GIF, dan lainnya"

# Daftar folder yang akan dipulihkan (bisa ditambah nanti jika ada aplikasi lain)
FOLDERS=("caelestia" "fastfetch")
FOLDERS1=("Wallpapers" "Fetch")
FOLDERS2=( "GIF" )

echo "==========================================="
echo "  Memulai Pemulihan Konfigurasi Sistem...  "
echo "==========================================="

# Cek apakah folder backup benar-benar ada
if [ ! -d "$BACKUP_DIR" ] && [ ! -d "$WALL_DIR" ]; then
    echo "⚠️ Error: Folder $BACKUP_DIR  dan Folder $WALL_DIR tidak ditemukan!"
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

for folder1 in "${FOLDERS1[@]}"; do
    echo "[*] Memindahkan folder $folder1"
    
    cp -r "$WALL_DIR/$folder1" "$PICTURES_DIR/"
done

for folder2 in "${FOLDERS2[@]}"; do
    echo "[*] Memindahkan folder $folder2"
    
    cp -r "$WALL_DIR/$folder2" "$VIDEOS_DIR/"
done

echo "==========================================="
echo " 🎉 Selesai! Semua sistem berhasil dipulihkan."
echo "==========================================="