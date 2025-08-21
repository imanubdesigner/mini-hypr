#!/bin/bash

# Get the directory of the current script
BASE_DIR=$(realpath "$(dirname "${BASH_SOURCE[0]}")/../../")

# Source helper file
source $BASE_DIR/scripts/installer/helper.sh

log_message "Installation started for prerequisites section"
print_info "\nStarting prerequisites setup..."

run_command "pacman -Syyu --noconfirm" "Update package database and upgrade packages (Recommended)" "yes" # no

if command -v yay > /dev/null; then
    print_info "Skipping yay installation (already installed)."
elif run_command "pacman -S --noconfirm --needed git base-devel" "Install YAY (Must)/Breaks the script" "yes"; then # 
    run_command "git clone https://aur.archlinux.org/yay.git && cd yay" "Clone YAY (Must)/Breaks the script" "no" "no" 
    run_command "makepkg --noconfirm -si && cd .. # builds with makepkg" "Build YAY (Must)/Breaks the script" "no" "no" 
fi
run_command "pacman -S --noconfirm linux-headers nvidia-open-dkms nvidia-utils libva libva-utils libva-nvidia-driver egl-wayland" "Install Nvidia Open DKMS" "yes"

run_command "pacman -S --noconfirm pipewire pipewire-audio pipewire-alsa pipewire-jack wireplumber pamixer" "Configuring audio (Recommended)" "yes" 

run_command "pacman -S --noconfirm ttf-cascadia-code-nerd ttf-cascadia-mono-nerd ttf-fira-code ttf-fira-mono ttf-fira-sans ttf-firacode-nerd ttf-iosevka-nerd ttf-iosevkaterm-nerd noto-fonts-emoji ttf-jetbrains-mono-nerd ttf-jetbrains-mono ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols-mono" "Installing Nerd Fonts and Symbols (Recommended)" "yes" 

run_command "pacman -S --noconfirm firefox" "Install nano" "yes"

run_command "pacman -S --noconfirm sddm && systemctl enable sddm.service" "Install and enable SDDM (Recommended)" "yes"

run_command "pacman -S --noconfirm networkmanager && systemctl enable NetworkManager.service" "Install and enable Network (Recommended)" "yes"

run_command "pacman -S --noconfirm wpa_supplicant && systemctl enable wpa_supplicant.service" "Install and enable Wpa (Recommended)" "yes"

run_command "pacman -S --noconfirm bluez && systemctl enable bluetooth.service" "Install and enable Bluetooth (Recommended)" "yes"

run_command "pacman -S --noconfirm zsh zsh-completions" "Install zsh" "yes"

run_command "pacman -S --noconfirm kitty" "Install Kitty (Recommended)" "yes"

run_command "pacman -S --noconfirm nano" "Install nano" "yes"

run_command "pacman -S --noconfirm neovim" "Install nano" "yes"

# Launchers and application menus
run_command "pacman -S --noconfirm wofi rofi" "Install application launchers (wofi, rofi)" "yes"

# File manager and file utilities
run_command "pacman -S --noconfirm thunar gvfs thunar-archive-plugin file-roller" "Install file manager and archive tools (Thunar, GVFS, File Roller)" "yes"

# Audio utilities
run_command "pacman -S --noconfirm pamixer pavucontrol" "Install audio utilities (pamixer, pavucontrol)" "yes"

# Bluetooth utilities
run_command "pacman -S --noconfirm bluez-utils blueman" "Install Bluetooth tools" "yes"

# Network utilities
run_command "pacman -S --noconfirm network-manager-applet" "Install network manager applet" "yes"

# System and performance tools
run_command "pacman -S --noconfirm btop pacman-contrib" "Install system monitoring and package tools (btop, pacman-contrib)" "yes"

# Appearance and theming
run_command "pacman -S --noconfirm starship lxappearance xfce4-settings" "Install appearance and theme configuration tools" "yes"

# Python utilities
run_command "pacman -S --noconfirm python-requests" "Install Python Requests library" "yes"

run_command "pacman -S --noconfirm tar unzip unrar p7zip" "Install archive extraction tools (tar, zip, rar, 7z) - needed for copying themes" "yes"

echo "------------------------------------------------------------------------"
