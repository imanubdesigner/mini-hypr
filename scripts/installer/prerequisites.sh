#!/bin/bash

# Get the directory of the current script
BASE_DIR=$(realpath "$(dirname "${BASH_SOURCE[0]}")/../../")

# Source helper file
source $BASE_DIR/scripts/installer/helper.sh

log_message "Installation started for prerequisites section"
print_info "\nStarting prerequisites setup..."

# -------------------- Base setup --------------------
run_command "pacman -Syyu --noconfirm" "Update package database and upgrade packages (Recommended)" "yes" 

# Install base tools for cloning/building
run_command "pacman -S --noconfirm --needed git base-devel" "Install git and base-devel (needed for AUR and configs)" "yes"

# Yay (AUR helper)
if command -v yay > /dev/null; then
    print_info "Skipping yay installation (already installed)."
else
    run_command "git clone https://aur.archlinux.org/yay.git && cd yay" "Clone YAY (Must)/Breaks the script" "no" "no" 
    run_command "makepkg --noconfirm -si && cd .." "Build YAY (Must)/Breaks the script" "no" "no" 
fi

# -------------------- Drivers --------------------
run_command "pacman -S --noconfirm linux-headers nvidia-open-dkms nvidia-utils libva libva-utils libva-nvidia-driver egl-wayland" "Install Nvidia Open DKMS" "yes"

# -------------------- Audio --------------------
run_command "pacman -S --noconfirm pipewire wireplumber pipewire-audio pipewire-alsa pipewire-pulse pipewire-jack alsa-utils alsa-plugins" "Configuring audio (Recommended)" "yes" 
run_command "pacman -S --noconfirm pamixer pavucontrol" "Install audio utilities (pamixer, pavucontrol)" "yes"

# -------------------- Fonts --------------------
run_command "pacman -S --noconfirm ttf-nerd-fonts-symbols-mono ttf-nerd-fonts-symbols noto-fonts ttf-jetbrains-mono-nerd ttf-jetbrains-mono ttf-fira-code ttf-droid ttf-iosevkaterm-nerd noto-fonts-emoji otf-font-awesome adobe-source-code-pro-fonts" "Installing Nerd Fonts and Symbols (Recommended)" "yes" 

# -------------------- Applications --------------------
run_command "pacman -S --noconfirm firefox" "Install Firefox" "yes"
run_command "pacman -S --noconfirm obsidian" "Install Obsidian" "yes"
run_command "pacman -S --noconfirm neovim" "Install Neovim" "yes"

# -------------------- Display manager & Network --------------------
run_command "pacman -S --noconfirm sddm && systemctl enable sddm.service" "Install and enable SDDM (Recommended)" "yes"
run_command "pacman -S --noconfirm networkmanager && systemctl enable NetworkManager.service" "Install and enable NetworkManager (Recommended)" "yes"
run_command "pacman -S --noconfirm network-manager-applet" "Install network manager applet" "yes"
run_command "pacman -S --noconfirm wpa_supplicant && systemctl enable wpa_supplicant.service" "Install and enable WPA supplicant" "yes"

# -------------------- Bluetooth --------------------
run_command "pacman -S --noconfirm bluez && systemctl enable bluetooth.service" "Install and enable Bluetooth (Recommended)" "yes"
run_command "pacman -S --noconfirm bluez-utils blueman" "Install Bluetooth tools" "yes"

# -------------------- Shell --------------------
run_command "pacman -S --noconfirm zsh zsh-completions" "Install zsh" "yes"
run_command "pacman -S --noconfirm zoxide fzf eza" "Install useful zsh plugins" "yes"

# -------------------- Terminal & CLI tools --------------------
run_command "pacman -S --noconfirm kitty" "Install Kitty (Recommended)" "yes"
run_command "pacman -S --noconfirm imagemagick" "Install Imagemagick (Recommended)" "yes"
run_command "pacman -S --noconfirm starship" "Install Starship (Recommended)" "yes"
run_command "pacman -S --noconfirm nano" "Install nano" "yes"

# -------------------- Launchers --------------------
run_command "pacman -S --noconfirm wofi rofi" "Install application launchers (wofi for wallp. changer, rofi for shutdown, reboot script)" "yes"
run_command "cp -r $BASE_DIR/configs/rofi /home/$SUDO_USER/.config/ && chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.config/rofi && find /home/$SUDO_USER/.config/rofi -name '*.sh' -type f -exec chmod +x {} +" "Copy Rofi config and set permissions" "yes" "no"

# -------------------- File manager --------------------
run_command "pacman -S --noconfirm thunar tumbler gvfs gvfs-mtp udisks2 xdg-user-dirs thunar-archive-plugin file-roller" "Install file manager and plugins" "yes"

# -------------------- System tools --------------------
run_command "pacman -S --noconfirm btop pacman-contrib" "Install btop and pacman-contrib" "yes"

# -------------------- Archive tools --------------------
run_command "pacman -S --noconfirm tar unzip unrar p7zip" "Install archive extraction tools (tar, zip, rar, 7z)" "yes"

echo "------------------------------------------------------------------------"
