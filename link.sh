#!/bin/bash

install_stow() {
    echo "stow not found. Detecting distribution..."
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        case "$ID" in
            arch|manjaro|endeavouros)
                sudo pacman -S --noconfirm stow ;;
            debian|ubuntu|pop|mint)
                sudo apt-get update && sudo apt-get install -y stow ;;
            fedora|rhel|centos)
                sudo dnf install -y stow ;;
            opensuse*|suse)
                sudo zypper install -y stow ;;
            alpine)
                sudo apk add stow ;;
            void)
                sudo xbps-install -y stow ;;
            *)
                case "$ID_LIKE" in
                    *arch*)
                        sudo pacman -S --noconfirm stow ;;
                    *debian*|*ubuntu*)
                        sudo apt-get update && sudo apt-get install -y stow ;;
                    *rhel*|*fedora*)
                        sudo dnf install -y stow ;;
                    *)
                        echo "Unsupported distribution: $ID ($ID_LIKE). Please install GNU stow manually."
                        exit 1 ;;
                esac
                ;;
        esac
    else
        echo "Unable to detect OS (/etc/os-release not found). Please install GNU stow manually."
        exit 1
    fi
}

if ! command -v stow &> /dev/null; then
    install_stow
fi

# Base directory for dotfiles
DOTFILES_DIR="$HOME/dotfile"

# Navigate to dotfiles directory
cd "$DOTFILES_DIR" || exit 1

# Stow all subdirectories, excluding metadata and non-stow folders
for dir in */; do
    dir=${dir%/}
    # Skip standard non-stowed directories
    if [[ "$dir" != "kde" && "$dir" != "output" ]]; then
        echo "Stowing $dir..."
        if ! stow -R "$dir" 2>/dev/null; then
            echo "Adopting and linking existing files for $dir..."
            stow --adopt "$dir"
            # Keep repo's version if conflict was adopted
            git restore "$dir" 2>/dev/null || true
        fi
    fi
done

echo "Dotfiles linking completed!"
