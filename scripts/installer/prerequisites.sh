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

run_command "pacman -S --noconfirm pipewire wireplumber pipewire-audio pipewire-alsa pipewire-pulse pipewire-jack alsa-utils alsa-plugins" "Configuring audio (Recommended)" "yes" 

# Audio utilities
run_command "pacman -S --noconfirm pamixer pavucontrol" "Install audio utilities (pamixer, pavucontrol)" "yes"

run_command "pacman -S --noconfirm ttf-nerd-fonts-symbols-mono ttf-nerd-fonts-symbols noto-fonts ttf-jetbrains-mono-nerd ttf-jetbrains-mono ttf-fira-code ttf-droid ttf-iosevkaterm-nerd noto-fonts-emoji otf-font-awesome adobe-source-code-pro-fonts" "Installing Nerd Fonts and Symbols (Recommended)" "yes" 

run_command "pacman -S --noconfirm firefox" "Install firefox" "yes"

run_command "pacman -S --noconfirm obsidian" "Install obsidian" "yes"

# Install Neovim
run_command "pacman -S --noconfirm neovim" "Install Neovim" "yes"

# Clone LazyVim starter
run_command "git clone https://github.com/LazyVim/starter /home/$SUDO_USER/.config/nvim" "Clone LazyVim starter for Neovim" "yes" "no"

# Remove .git folder and set right perm.
run_command "rm -rf /home/$SUDO_USER/.config/nvim/.git && chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.config/nvim" "Remove git metadata and fix permissions for Neovim config" "yes" "no"

run_command "pacman -S --noconfirm sddm && systemctl enable sddm.service" "Install and enable SDDM (Recommended)" "yes"

run_command "pacman -S --noconfirm networkmanager && systemctl enable NetworkManager.service" "Install and enable Network (Recommended)" "yes"

# Network utilities
run_command "pacman -S --noconfirm network-manager-applet" "Install network manager applet" "yes"

run_command "pacman -S --noconfirm wpa_supplicant && systemctl enable wpa_supplicant.service" "Install and enable Wpa (Recommended)" "yes"

run_command "pacman -S --noconfirm bluez && systemctl enable bluetooth.service" "Install and enable Bluetooth (Recommended)" "yes"

# Bluetooth utilities
run_command "pacman -S --noconfirm bluez-utils blueman" "Install Bluetooth tools" "yes"

run_command "pacman -S --noconfirm zsh zsh-completions" "Install zsh" "yes"

run_command "pacman -S --noconfirm zoxide fzf eza" "Install userful zsh plugin" "yes"

run_command "pacman -S --noconfirm kitty" "Install Kitty (Recommended)" "yes"

run_command "pacman -S --noconfirm imagemagick" "Install imagemagick (Recommended)" "yes"

run_command "pacman -S --noconfirm nano" "Install nano" "yes"

# Launchers and application menus
run_command "pacman -S --noconfirm wofi rofi" "Install application launchers (wofi for wallp. changer, rofi for shutdown, reboot script)" "yes"
run_command "cp -r $BASE_DIR/configs/rofi /home/$SUDO_USER/.config/ && chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.config/rofi" "Copy entire Rofi config folder (Must)" "yes" "no"

# File manager and file utilities
run_command "pacman -S --noconfirm thunar tumbler gvfs-mtp udisks2 xdg-user-dirs gvfs thunar-archive-plugin file-roller" "Install file manager and important plugin" "yes"

# System and performance tools
run_command "pacman -S --noconfirm btop pacman-contrib" "Install btop and pacman-contrib)" "yes"

run_command "pacman -S --noconfirm tar unzip unrar p7zip" "Install archive extraction tools (tar, zip, rar, 7z) - needed for copying themes" "yes"

echo "------------------------------------------------------------------------"
