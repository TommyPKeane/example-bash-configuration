#!/usr/bin/env bash
# Installation Script for macOS (or Linux with `brew`) of all recommended tools
#
# References:
#   - https://github.com/TommyPKeane/example-bash-configuration
#   - https://stackoverflow.com/questions/394230/how-to-detect-the-os-from-a-bash-script
#   - https://stackoverflow.com/questions/23424783/ostype-not-available-in-shell-script
#   - https://www.redhat.com/en/blog/exit-codes-demystified
#   - https://stackoverflow.com/questions/2421586/what-is-the-bash-equivalent-of-pythons-pass-statement

set -eu

# OS-specific Installations
#
#   - macOS: XCode Utilities need to be installed
#   - Linux: N/A
#   - Windows: N/A

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    : # pass
elif [[ "$OSTYPE" == "darwin"* ]]; then
    if ! xcode-select --version >/dev/null 2>&1; then
        xcode-select --install
    else
        echo "✅ xcode-select Tools Already Installed"
    fi
elif [[ "$OSTYPE" == "cygwin" ]]; then
    : # pass
elif [[ "$OSTYPE" == "msys" ]]; then
    : # pass
elif [[ "$OSTYPE" == "win32" ]]; then
    : # pass
elif [[ "$OSTYPE" == "freebsd"* ]]; then
    : # pass
else
    if [[ $(uname) == "Darwin" ]]; then
        if ! xcode-select --version >/dev/null 2>&1; then
            xcode-select --install
        else
            echo "✅ xcode-select Tools Already Installed"
        fi
    else
        >&2 echo "⚠️ Could not determine Operating System | Exiting"
        exit 1
    fi
fi


# brew Install
if ! command -v brew >/dev/null 2>&1; then
    echo "⬇️ Installing brew ..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "✅ brew Already Installed"
fi
brew update
brew upgrade


# Code Building and Management
brew install gcc
brew install glib
brew install pkgconfig
brew install git
brew install bash-completion
brew install git-svn
brew install git-gui
brew install make  # Installs to alias `gmake`
brew install cmake


# Basic Utilities
brew install rsync
brew install ack
brew install jq
brew install yq
brew install jless
brew install direnv
brew install fzf
brew install tree
brew install grep  # Installs to alias `ggrep`


# Unix Libraries
brew install openssl
brew install readline
brew install zlib


# Shell Customization
brew install starship


# Image Processing Utilities
brew install exiftool
brew install imagemagick
brew install graphicsmagick


# Video Processing Utilities
brew install mkvtoolnix
brew install ffmpeg
brew install yt-dlp


# Python Utilities
brew install pyenv
brew install pyenv-virtualenv
brew install uv
mkdir -p ~/.local/bin/


# Rust Utilities
brew install rust
brew install rustup


# Node.js Utilities
brew install nvm
brew install nodejs

# Java (JVM)
$ brew install java
$ sudo ln -sfn $(brew --prefix java)/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk

# Kubernetes Utilities
brew install kubectl
brew install minikube


# Terraform Utilities
brew install warrensbox/tap/tfswitch


# Docker and Containerization Utilities
brew install dive


# vim Utilities
brew install bat ripgrep the_silver_searcher perl universal-ctags  # Dependencies for fzf in vim
brew install pylsp  # lsp (Language Server Protocol) for Python for vim


# End of Script
echo "💻 Run \`./overwrite_bash_configs.sh\` to update your bash Configuration..."
echo "(Note that Linux or Cloud VM users may want to check their current configuration and make the changes manually instead of running the overwrite script)"
