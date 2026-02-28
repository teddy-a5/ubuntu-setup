# 🚀 Ubuntu Setup Script

This repository contains a **one-click setup script** (`run.sh`) to install and configure my favorite apps, developer tools, and desktop customizations on a fresh Ubuntu installation.

## 📦 Features

The script will:

* ✅ Update & upgrade system
* ✅ Install favorite apps:

  * VS Code
  * Postman
  * Brave (default browser)
  * Obsidian
  * OnlyOffice
  * Warp terminal
  * Telegram
  * Kitty terminal
  * Neovim
  * Jupyter Notebook
* ✅ Customize GNOME desktop:

  * Dash-to-Panel extension
  * Disable animations (for snappier performance)
  * Enable Dark Mode
  * Set fonts: **Roboto** (UI & documents), **JetBrains Mono** (monospace/dev font)

---

## ⚡ Usage

1. Clone this repo after a fresh Ubuntu install:

   ```bash
   git clone https://github.com/teddy-a5/ubuntu-setup.git
   cd ubuntu-setup
   ```

2. Make the script executable:

   ```bash
   chmod +x run.sh
   ```

3. Run it:

   ```bash
   ./run.sh
   ```

---

## 🔧 Notes

* Some GNOME extensions (like **Dash-to-Panel**) may require you to log in once, then enable via the **Extensions** app if not auto-enabled.
* Fonts and dark mode are applied automatically via `gsettings`.
* To make **Kitty** or **Warp** your default terminal, you can run:

  ```bash
  sudo update-alternatives --config x-terminal-emulator
  ```
* Reboot after installation to ensure all settings take effect.

---

## 📷 Result

After running the script, you’ll have:

* A clean Ubuntu dev setup with all your favorite tools
* A fast, minimal GNOME desktop (dark mode, no animations, custom fonts)
* Everything reproducible in minutes after a fresh install 🎉
