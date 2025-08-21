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

run_command "pacman -S --noconfirm ttf-cascadia-code-nerd ttf-cascadia-mono-nerd ttf-fira-code ttf-fira-mono ttf-fira-sans ttf-firacode-nerd ttf-iosevka-nerd ttf-iosevkaterm-nerd ttf-jetbrains-mono-nerd ttf-jetbrains-mono ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols-mono" "Installing Nerd Fonts and Symbols (Recommended)" "yes" 

run_command "pacman -S --noconfirm sddm && systemctl enable sddm.service" "Install and enable SDDM (Recommended)" "yes"

run_command "pacman -S --noconfirm networkmanager && systemctl enable NetworkManager.service" "Install and enable Network (Recommended)" "yes"

run_command "pacman -S --noconfirm wpa_supplicant && systemctl enable wpa_supplicant.service" "Install and enable Wpa (Recommended)" "yes"

run_command "pacman -S --noconfirm bluez && systemctl enable bluetooth.service" "Install and enable Bluetooth (Recommended)" "yes"

run_command "pacman -S --noconfirm kitty" "Install Kitty (Recommended)" "yes"

run_command "pacman -S --noconfirm nano" "Install nano" "yes"

run_command "pacman -S --noconfirm tar" "Install tar for extracting files (Must)/needed for copying themes" "yes"

echo "------------------------------------------------------------------------"
