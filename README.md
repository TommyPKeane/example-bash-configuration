# `bash` Configuration

https://www.gnu.org/software/bash/

<!-- MarkdownTOC -->

- macOS \(Apple\)
    - Reset macOS to use `bash` instead of `zsh`
    - Install macOS Commandline Utilities
    - Install `brew` and Other Tools
    - `bash` Configuration Files
    - `bash` Profile and `.bashrc` File
- Linux \(Desktop, VM, or Docker\)

<!-- /MarkdownTOC -->

## macOS (Apple)

In macOS, they've switched away from `bash` to `zsh`, but I ain't dealin' with all that, so I prefer to switch it back, and to use the latest version of `bash` from `brew` ([Homebrew](https://brew.sh)) for best compatibility with Linux systems (which is very relevant to contemporary Cloud-based development and deployments).

So, first, you'd have to follow these steps on how to switch back to `bash`, and _then_ you can use the configuration files provided here as examples.

Note that for all of this, I also strongly prefer to use [iTerm2](https://iterm2.com/) as a Terminal Emulator (instead of the built-in `terminal` App).

### Reset macOS to use `bash` instead of `zsh`

You can change the shell for yourself by running this command in the terminal, and this will set a permanent change:

```bash
chsh -s /bin/bash
```

However, if you've installed the latest version of `bash` through `brew`, that will only set you to use the default (old) install of `bash` that comes with macOS, which you don't want. So you'll want to come back here and use this command _after_ you get `brew` installed and install the latest version of `bash`:

```bash
chsh -s /opt/homebrew/bin/bash
```

However, that command won't work, because for safety/design reasons, the core Unix system will not allow arbitrary executables to be treated as a Shell (`chsh` meaning "<b>ch</b>ange <b>sh</b>ell"), so you'll have to edit the `/etc/shells` plaintext file to make that executable available:

```bash
sudo -E vim /etc/shells
```

For convenience, you can copy the following code to fill in the new file contents, and here is a quick _exact_ series of key-presses (and I ___mean___ _exact!!!_) to quickly paste in the new contents using <tt>vim</tt>.

New Contents for `/etc/shells` that has now added `/opt/homebrew/bin/bash` to the top of the file:

```bash
# List of acceptable shells for chpass(1).
# Ftpd will not allow users to connect who are not using
# one of these shells.

/opt/homebrew/bin/bash
/bin/bash
/bin/csh
/bin/dash
/bin/ksh
/bin/sh
/bin/tcsh
/bin/zsh
```

Commands to overwrite the contents of the file with the new above contents, as long as you've pressed no other keys except to copy the above text from this file:

1. `ESC`
1. `g` then `g` (Move to Start of File)
1. `d` (Begin Delete)
1. `SHIFT` + `g` (End Delete at End of File)
1. `SHIFT` + `a` (Enter into Append Mode)
1. `CMD` + `v` (Paste new Contents)

### Install macOS Commandline Utilities

There's kind of a Catch-22 with macOS, that in order to install `brew`, you're going to also need to install the macOS Commandline Utilities so that you can get `git` and `curl` to be available, along with `gcc` (GNU Compiler Collection) for building and linking any relevant binaries during the `brew` setup and install.

To install these tools, you may get a prompt when you go to install `brew`, but you can also force the install by running the command:

```bash
xcode-select --install
```

### Install `brew` and Other Tools

To install `brew`, you can refer the to [Homebrew Website](https://brew.sh/) to make sure this is the latest command, or copy and run this command, here:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Once that installs, you can now start installing tools from `brew`, and here is a list of tools for various purposes that I like to install, but you certainly should do whatever you want, as some of these may be more or less interesting than others, but I'll provide a small blurb to mention the purpose of each:

- `brew install git` -- Distributed Version Control System (DVCS) / Version Control Software (VCS)
- `brew install bash` -- GNU Bash latest version (installs to `/opt/homebrew/bin/bash`, so see above about using instead of default, old `/bin/bash` executable)
- `brew install fzf` -- Bash History Fuzzy-Finder (Updates functionality of `CTRL`+`r` command in terminal)
- `brew install make` -- GNU Make ⚠️ Note that you'll have to refer to this by the command of `gmake`
- `brew install cmake` -- CMake (a tool that provides a user alternative to GNU Make)
- `brew install rust` -- Rust Compiler Tools
- `brew install rustup` -- Rust Package Management Tools (`cargo`)
- `brew install minikube` -- Local Kubernetes Cluster Running and Management
- `brew install kubectl` -- Kubernetes Controls (Commandline Interface)
- `brew install warrensbox/tap/tfswitch` -- Terraform Version Manage (`brew` Cask)
- `brew install nvm` -- Node.js Version Manager
- `brew install pyenv` -- Python Version Manager
- `brew install direnv` -- Directory Environment Manager
- `brew install rsync` -- Remote File Synchronization
- `brew install ack` -- Patern Matching Tool
- `brew install jq` -- JSON Query Tools
- `brew install yq` -- YAML Query Tools
- `brew install jless` -- Interactive JSON Viewer/Navigation in the Terminal
- `brew install pkgconfig` -- Package Config Tool for Library and Binary Installs
- `brew install gcc` -- GNU Compiler Collection (C, C++, Fortran, etc. Compilers and Debuggers)
- `brew install glib` -- `glibc` for macOS

### `bash` Configuration Files

### `bash` Profile and `.bashrc` File

## Linux (Desktop, VM, or Docker)

You can use most of these configuration files with Linux, as well, and similar tools exist, but you won't have access to `brew`, and you may need to install some of the tools directly.
