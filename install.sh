#!/bin/bash

# Update package lists and upgrade packages
echo "Updating package lists and upgrading packages..."
sudo apt update && sudo apt upgrade -y

# Install packages: nala, vlc, mpv, build-essential
echo "Installing packages: nala, vlc, mpv, build-essential..."
sudo apt install -y nala vlc mpv build-essential

# Remove existing Firefox snap
echo "Removing existing Firefox snap..."
sudo snap remove firefox

# Install Firefox
echo "Installing Firefox..."
if [ -d "/opt/firefox" ]; then
    echo "Firefox installation directory already exists."
    read -p "Do you want to remove the existing Firefox installation? (y/n): " remove_existing
    if [ "$remove_existing" == "y" ]; then
        sudo rm -rf /opt/firefox
        sudo rm -f /usr/local/bin/firefox
        sudo rm -f /usr/share/icons/firefox.png
    else
        echo "Skipping Firefox installation."
        exit 1
    fi
fi

wget -O firefox.tar.bz2 https://download-installer.cdn.mozilla.net/pub/firefox/releases/126.0/linux-x86_64/en-US/firefox-126.0.tar.bz2
tar -xvf firefox.tar.bz2
sudo mv firefox /opt/
sudo ln -s /opt/firefox/firefox /usr/local/bin/firefox
sudo ln -s /opt/firefox/browser/chrome/icons/default/default48.png /usr/share/icons/firefox.png

# Install nvim
echo "Installing nvim..."
wget -O nvim.tar.gz https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
tar -xvf nvim.tar.gz
sudo mv nvim-linux64/bin/nvim /usr/local/bin/

# Download and install font
echo "Downloading and installing font..."
wget -O CascadiaCode.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/CascadiaCode.zip
unzip -o CascadiaCode.zip -d ~/.fonts
fc-cache -f -v

# Install TLP
echo "Installing TLP..."
sudo apt install -y tlp tlp-rdw

# Enable TLP
echo "Enabling TLP..."
sudo tlp start

# Install nvchad
echo "Installing nvchad..."
git clone https://github.com/NvChad/starter ~/.config/nvim && nvim

# Install Visual Studio Code
echo "Installing Visual Studio Code..."
wget -O vscode.deb https://vscode.download.prss.microsoft.com/dbazure/download/stable/dc96b837cf6bb4af9cd736aa3af08cf8279f7685/code_1.89.1-1715060508_amd64.deb
sudo apt install -y ./vscode.deb

echo "All tasks completed."

