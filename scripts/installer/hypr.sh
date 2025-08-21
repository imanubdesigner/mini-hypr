#!/bin/bash

# Get the directory of the current script
BASE_DIR=$(realpath "$(dirname "${BASH_SOURCE[0]}")/../../")

# Source helper file
source $BASE_DIR/scripts/installer/helper.sh

log_message "Installation started for hypr section"
print_info "\nStarting hypr setup..."
print_info "\nEverything is recommended to INSTALL"

run_command "pacman -S --noconfirm hyprland hyprpicker hypridle hyprlock" "Install Hyprland (Must)" "yes"
run_command "cp -r $BASE_DIR/configs/hypr /home/$SUDO_USER/.config/ && chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.config/hypr" "Copy entire hypr config folder (Must)" "yes" "no" 

run_command "pacman -S --noconfirm uwsm" "Install the Universal Window Session Manager (Must)" "yes"
run_command "cp -r $BASE_DIR/configs/uwsm /home/$SUDO_USER/.config/ && chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.config/uwsm" "Copy entire uwsm config folder (Must)" "yes" "no"

run_command "pacman -S --noconfirm xdg-desktop-portal-hyprland" "Install XDG desktop portal for Hyprland" "yes"

run_command "pacman -S --noconfirm hyprsunset" "Install blue-filter (Night Light)" "yes"

run_command "pacman -S --noconfirm hyprpolkitagent" "Install Hyprpolkitagent for authentication dialog like open external SSD" "yes"

run_command "pacman -S --noconfirm dunst" "Install Dunst notification daemon" "yes"
run_command "cp -r $BASE_DIR/configs/dunst /home/$SUDO_USER/.config/ && chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.config/dunst" "Copy Dunst config" "yes" "no"

run_command "pacman -S --noconfirm qt5-wayland qt6-wayland" "Install QT support on wayland" "yes"

echo "------------------------------------------------------------------------"
