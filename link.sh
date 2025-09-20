#!/bin/bash

# Function to detect package manager and OS
detect_package_manager() {
    if command -v apt &> /dev/null; then
        echo "apt"
    elif command -v dnf &> /dev/null; then
        echo "dnf"
    elif command -v yum &> /dev/null; then
        echo "yum"
    elif command -v pacman &> /dev/null; then
        echo "pacman"
    elif command -v zypper &> /dev/null; then
        echo "zypper"
    elif command -v apk &> /dev/null; then
        echo "apk"
    else
        echo "unknown"
    fi
}

# Function to install stow based on package manager
install_stow() {
    local pm="$1"

    case $pm in
        "apt")
            echo "Installing stow using apt..."
            sudo apt update && sudo apt install -y stow
            ;;
        "dnf"|"yum")
            echo "Installing stow using $pm..."
            sudo $pm install -y stow
            ;;
        "pacman")
            echo "Installing stow using pacman..."
            sudo pacman -S --noconfirm stow
            ;;
        "zypper")
            echo "Installing stow using zypper..."
            sudo zypper install -y stow
            ;;
        "apk")
            echo "Installing stow using apk..."
            sudo apk add stow
            ;;
        *)
            echo "Error: Unsupported package manager. Please install stow manually."
            exit 1
            ;;
    esac
}

# Function to check if stow is installed
check_stow() {
    if ! command -v stow &> /dev/null; then
        echo "stow is not installed."
        local pm=$(detect_package_manager)
        echo "Detected package manager: $pm"

        if [ "$pm" = "unknown" ]; then
            echo "Cannot detect package manager. Please install stow manually and run the script again."
            exit 1
        fi

        read -p "Would you like to install stow automatically? (y/N): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            install_stow "$pm"
        else
            echo "Please install stow manually and run the script again."
            exit 1
        fi
    else
        echo "stow is already installed."
    fi
}

# Check if stow is installed and install if necessary
check_stow

# Directories to stow
directories=(
    "alacritty"
    "aria2"
    "bash"
    "bspwm"
    "dunst"
    "fastfetch"
    "gammastep"
    "git"
    "gtk-theme"
    "hypr"
    "i3"
    "kitty"
    "moc"
    "paru"
    "picom"
    "polybar"
    "qalculate"
    "ranger"
    "rofi"
    "scripts"
    "sxhkd"
    "theme"
    "tmux"
    "waybar"
    "wezterm"
    "xdg-desktop-portal"
    "xresources"
    "yazi"
    "zathura"
    "zsh"
)

# Base directory for dotfiles
DOTFILES_DIR="$HOME/dotfile"

# Navigate to dotfiles directory
cd "$DOTFILES_DIR" || exit

# Stow each directory
for dir in "${directories[@]}"; do
    if [ -d "$dir" ]; then
        echo "Stowing $dir..."
        # stow -R --override="*" "$dir"
        stow "$dir"
    else
        echo "Directory $dir not found, skipping..."
    fi
done

echo "Dotfiles linking completed!"
