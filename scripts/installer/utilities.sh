#!/bin/bash

# Get the directory of the current script
BASE_DIR=$(realpath "$(dirname "${BASH_SOURCE[0]}")/../../")

# Source helper file
source $BASE_DIR/scripts/installer/helper.sh

log_message "Installation started for utilities section"
print_info "\nStarting utilities setup..."

# -------------------- Bar & Launcher --------------------
run_command "pacman -S --noconfirm waybar" "Install Waybar - Status Bar" "yes"
run_command "cp -r $BASE_DIR/configs/waybar /home/$SUDO_USER/.config/ && chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.config/waybar" "Copy Waybar config" "yes" "no"

run_command "yay -S --sudoloop --noconfirm tofi" "Install Tofi - Application Launcher" "yes" "no"
run_command "cp -r $BASE_DIR/configs/tofi /home/$SUDO_USER/.config/ && chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.config/tofi" "Copy Tofi config(s)" "yes" "no"

# -------------------- Clipboard --------------------
run_command "pacman -S --noconfirm cliphist" "Install Cliphist - Clipboard Manager" "yes"

# -------------------- Wallpapers --------------------
run_command "yay -S --sudoloop --noconfirm swww" "Install SWWW for wallpaper management" "yes" "no"
run_command "yay -S --sudoloop --noconfirm waypaper" "Install Waypaper - Wallpaper tool" "yes" "no"

# -------------------- Screenshot --------------------
run_command "yay -S --sudoloop --noconfirm grimblast" "Install Grimblast - Screenshot tool" "yes" "no"

# -------------------- Other utilities --------------------
run_command "yay -S --sudoloop --noconfirm qview" "Install qView - Image Viewer" "yes" "no"
run_command "pacman -S --noconfirm fastfetch" "Install fastfetch" "yes"

echo "------------------------------------------------------------------------"
