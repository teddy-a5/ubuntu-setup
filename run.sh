#!/bin/bash
set -e

# -------------------------------
# Ubuntu Minimalist Developer Setup Script
# -------------------------------
# This script automates the installation of essential apps and tweaks
# for a minimalist Ubuntu desktop environment, enhanced for developers.
# -------------------------------

# Check architecture
if ! [ "$(uname -m)" = "x86_64" ]; then
    echo "❌ This script is designed for x86_64 architecture only."
    exit 1
fi

echo "👋 Starting Ubuntu developer setup..."
sleep 2

echo "🚀 Updating system..."
sudo apt update && sudo apt upgrade -y

echo "📦 Installing essentials..."
sudo apt install -y curl wget git build-essential software-properties-common apt-transport-https ca-certificates gnupg lsb-release

# -------------------------------
# 1. Visual Studio Code
# -------------------------------
echo "📝 Installing VS Code..."
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt update && sudo apt install -y code
rm -f packages.microsoft.gpg

# -------------------------------
# 2. Postman
# -------------------------------
echo "📮 Installing Postman..."
wget https://dl.pstmn.io/download/latest/linux64 -O postman.tar.gz
sudo tar -xzf postman.tar.gz -C /opt
sudo ln -s /opt/Postman/Postman /usr/bin/postman
rm postman.tar.gz

# -------------------------------
# 3. Brave Browser
# -------------------------------
echo "🌐 Installing Brave..."
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update && sudo apt install -y brave-browser
# Set Brave as default browser
xdg-settings set default-web-browser brave-browser.desktop

# -------------------------------
# 4. Obsidian
# -------------------------------
echo "🗒️ Installing Obsidian..."
wget https://github.com/obsidianmd/obsidian-releases/releases/latest/download/obsidian_amd64.deb
sudo apt install -y ./obsidian_amd64.deb
rm obsidian_amd64.deb

# -------------------------------
# 5. SoftMaker FreeOffice
# -------------------------------
echo "📄 Installing SoftMaker FreeOffice..."
wget https://www.softmaker.net/down/softmaker-freeoffice-2024_1228-01_amd64.deb -O softmaker-freeoffice.deb
sudo apt install -y ./softmaker-freeoffice.deb
rm softmaker-freeoffice.deb

# -------------------------------
# 6. Warp (Terminal)
# -------------------------------
echo "💻 Installing Warp..."
wget https://releases.warp.dev/stable/v0.2024.09.17.08.02.stable_amd64.deb -O warp.deb
sudo apt install -y ./warp.deb
rm warp.deb

# -------------------------------
# 7. Telegram
# -------------------------------
echo "✈️ Installing Telegram..."
sudo add-apt-repository ppa:atareao/telegram -y
sudo apt update && sudo apt install -y telegram

# -------------------------------
# 8. Kitty Terminal
# -------------------------------
echo "🐱 Installing Kitty..."
sudo apt install -y kitty


# -------------------------------
# 9. Neovim & LazyVim
# -------------------------------
echo "🔮 Installing Neovim and dependencies..."

sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update
sudo apt install -y neovim ripgrep fd-find

echo "💤 Setting up LazyVim..."

rm -rf ~/.config/nvim ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim

git clone https://github.com/LazyVim/starter ~/.config/nvim

rm -rf ~/.config/nvim/.git

echo "✅ LazyVim installed! It will download its plugins the first time you run 'nvim'."

# -------------------------------
# 10. Jupyter Notebook
# -------------------------------
echo "📓 Installing Jupyter Notebook..."
sudo apt install -y python3-pip python3-dev python3-venv
pip3 install --upgrade pip
pip3 install jupyter virtualenv

# -------------------------------
# 11. Docker
# -------------------------------
echo "🐳 Installing Docker..."
sudo apt install -y docker.io docker-compose
sudo usermod -aG docker $USER
echo "ℹ️ Log out and back in to use Docker without sudo."

# -------------------------------
# 12. Node.js (LTS)
# -------------------------------
echo "🔧 Installing Node.js LTS..."
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt install -y nodejs

echo "✅ All apps installed successfully!"
echo "🔄 Please reboot or log out/in for everything to take effect."

# -------------------------------
# 13. GNOME Tweaks + Extensions
# -------------------------------
echo "⚙️ Installing GNOME Tweaks & Extensions..."
sudo apt install -y gnome-tweaks gnome-shell-extensions

# -------------------------------
# fzf and eza
# -------------------------------
echo "🛠️ Installing modern CLI tools (fzf, eza)..."

sudo apt install -y fzf

sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://apt.fury.io/eza/ /" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo apt update
sudo apt install -y eza

echo "📝 Setting up eza aliases in ~/.bashrc..."
if ! grep -q "alias ls='eza" ~/.bashrc; then
  echo "" >> ~/.bashrc
  echo "# Eza aliases" >> ~/.bashrc
  echo "alias ls='eza --color=always --icons=always'" >> ~/.bashrc
  echo "alias ll='eza -al --color=always --icons=always --group-directories-first'" >> ~/.bashrc
  echo "alias tree='eza --tree --color=always --icons=always'" >> ~/.bashrc
fi

# -------------------------------
# Dash to Panel
# -------------------------------
echo "📌 Installing Dash-to-Panel..."
git clone https://github.com/home-sweet-gnome/dash-to-panel.git
cd dash-to-panel
make install
cd ..
rm -rf dash-to-panel

# Enable Dash-to-Panel extension
gnome-extensions enable dash-to-panel@jderose9.github.com || echo "⚠️ Please enable Dash-to-Panel manually from Extensions app."

# -------------------------------
# Turn off GNOME animations
# -------------------------------
echo "🎛️ Disabling GNOME animations..."
gsettings set org.gnome.desktop.interface enable-animations false

# -------------------------------
# Dark Mode
# -------------------------------
echo "🌙 Enabling Dark Mode..."
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.desktop.interface gtk-theme 'Yaru-dark'

# -------------------------------
# Fonts: Roboto + JetBrains Mono
# -------------------------------
echo "🔤 Installing Roboto & JetBrains Mono fonts..."
sudo apt install -y fonts-roboto fonts-jetbrains-mono

# Apply fonts
gsettings set org.gnome.desktop.interface font-name 'Roboto 11'
gsettings set org.gnome.desktop.interface document-font-name 'Roboto 11'
gsettings set org.gnome.desktop.interface monospace-font-name 'JetBrains Mono 12'
gsettings set org.gnome.desktop.wm.preferences titlebar-font 'Roboto Bold 11'

echo "🎉 Setup complete! Enjoy your Ubuntu developer setup!"
reboot