#!/bin/bash

# Tentukan direktori penyimpanan
BACKUP_DIR="$HOME/HyprlandSessionBackup"
CONFIG_DIR="$HOME/.config"

# Daftar folder yang akan dipulihkan (bisa ditambah nanti jika ada aplikasi lain)
FOLDERS=("hypr" "caelestia" "fastfetch")

echo "==========================================="
echo "  Memulai Pemulihan Konfigurasi Sistem...  "
echo "==========================================="

# Cek apakah folder backup benar-benar ada
if [ ! -d "$BACKUP_DIR" ]; then
    echo "⚠️ Error: Folder $BACKUP_DIR tidak ditemukan!"
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

    # Buat symlink baru dari brankas ke sistem
    echo "    - Memasang symlink baru..."
    ln -s "$BACKUP_DIR/$folder" "$CONFIG_DIR/$folder"
    
    echo "    - Berhasil! ✔️"
done

echo "==========================================="
echo " 🎉 Selesai! Semua sistem berhasil dipulihkan."
echo "==========================================="