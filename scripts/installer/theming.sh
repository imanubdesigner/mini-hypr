#!/bin/bash

# Get the directory of the current script
BASE_DIR=$(realpath "$(dirname "${BASH_SOURCE[0]}")/../../")

# Source helper file
source $BASE_DIR/scripts/installer/helper.sh

log_message "Installation started for theming section"
print_info "\nStarting theming setup..."

run_command "pacman -S --noconfirm nwg-look" "Install nwg-look for GTK theme management" "yes" 

run_command "pacman -S --noconfirm qt5ct qt6ct kvantum" "Install Qt5, Qt6 Settings, and Kvantum theme engines" "yes"

run_command "mkdir -p /home/$SUDO_USER/.themes && unzip -o $BASE_DIR/assets/themes/Catppuccin-Dark-BL-MB.zip -d /home/$SUDO_USER/.themes && chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.themes" "Install Catppuccin Dark BL MB GTK theme" "yes" "no"

run_command "mkdir -p /home/$SUDO_USER/.icons && tar -xvf $BASE_DIR/assets/icons/Tela-circle-dracula.tar.xz -C /home/$SUDO_USER/.icons && chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.icons" "Install Tela Circle Dracula icon theme in user .icons folder" "yes" "no"

run_command "unzip -o $BASE_DIR/assets/hyprcursor/catppuccin-mocha-light-cursors.zip -d /home/$SUDO_USER/.icons && chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.icons" "Install Catppuccin Hyprcursor" "yes" "no"

run_command "yay -S --sudoloop --noconfirm kvantum-theme-catppuccin-git" "Install Catppuccin theme for Kvantum" "yes" "no"

run_command "cp -r $BASE_DIR/configs/kitty /home/$SUDO_USER/.config/ && chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.config/kitty" "Copy Kitty config folder (Catppuccin theme)" "yes" "no"



# Add instructions to configure theming
print_info "\nPost-installation instructions:"
print_bold_blue "Set themes and icons:"
echo "   - Run 'nwg-look' and  set the global GTK and icon theme"
echo "   - Open 'kvantummanager' (run with sudo for system-wide changes) to select and apply the Catppuccin theme"
echo "   - Open 'qt6ct' to set the icon theme"

echo "------------------------------------------------------------------------"
