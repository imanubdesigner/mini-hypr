#!/bin/bash

# Get the directory of the current script
BASE_DIR=$(realpath "$(dirname "${BASH_SOURCE[0]}")/../../")

# Source helper file
source $BASE_DIR/scripts/installer/helper.sh

log_message "Installation started for utilities section"
print_info "\nStarting utilities setup..."

# Waybar
run_command "pacman -S --noconfirm waybar" "Install Waybar - Status Bar" "yes"
run_command "cp -r $BASE_DIR/configs/waybar /home/$SUDO_USER/.config/ && chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.config/waybar" "Copy Waybar config" "yes" "no"

# Tofi
run_command "yay -S --sudoloop --noconfirm tofi" "Install Tofi - Application Launcher" "yes" "no"
run_command "cp -r $BASE_DIR/configs/tofi /home/$SUDO_USER/.config/ && chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.config/tofi" "Copy Tofi config(s)" "yes" "no"

# Clipboard manager
run_command "pacman -S --noconfirm cliphist" "Install Cliphist - Clipboard Manager" "yes"

# SWWW
run_command "yay -S --sudoloop --noconfirm swww" "Install SWWW for wallpaper management" "yes" "no"
run_command "sudo -u $SUDO_USER swww-daemon & disown" "Start swww daemon" "yes" "no"

# Hyprpicker
run_command "pacman -S --noconfirm hyprpicker" "Install Hyprpicker - Color Picker" "yes" "no"

# Hyprlock
run_command "pacman -S --noconfirm hyprlock" "Install Hyprlock - Screen Locker (Must)" "yes" "no"

# Grimblast
run_command "yay -S --sudoloop --noconfirm grimblast" "Install Grimblast - Screenshot tool" "yes" "no"

# Waypaper
run_command "yay -S --sudoloop --noconfirm waypaper" "Install Waypaper - Wallpaper tool" "yes" "no"

# Hypridle
run_command "pacman -S --noconfirm hypridle" "Install Hypridle for idle management (Must)" "yes" "no"

echo "------------------------------------------------------------------------"
