# `bash` Configuration

https://www.gnu.org/software/bash/

<!-- MarkdownTOC -->

- [macOS \(Apple\)](#macos-apple)
    - [Reset macOS to use `bash` instead of `zsh`](#reset-macos-to-use-bash-instead-of-zsh)
    - [Install macOS Commandline Utilities](#install-macos-commandline-utilities)
    - [Install `brew` and Other Tools](#install-brew-and-other-tools)
    - [`bash` Configuration Files](#bash-configuration-files)
    - [`bash` Profile and `.bashrc` File](#bash-profile-and-bashrc-file)
- [Linux \(Desktop, VM, or Docker\)](#linux-desktop-vm-or-docker)
- [`_other-configs/` Directory](#_other-configs-directory)
- [References](#references)

<!-- /MarkdownTOC -->

<a id="macos-apple"></a>
## macOS (Apple)

In macOS, they've switched away from `bash` to `zsh`, but I ain't dealin' with all that, so I prefer to switch it back, and to use the latest version of `bash` from `brew` ([Homebrew](https://brew.sh)) for best compatibility with Linux systems (which is very relevant to contemporary Cloud-based development and deployments).

So, first, you'd have to follow these steps on how to switch back to `bash`, and _then_ you can use the configuration files provided here as examples.

Note that for all of this, I also strongly prefer to use [iTerm2](https://iterm2.com/) as a Terminal Emulator (instead of the built-in `terminal` App).

<a id="reset-macos-to-use-bash-instead-of-zsh"></a>
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

1. `ESC` (Make sure you're in Command Mode)
1. `g` then `g` (Move to Start of File)
1. `d` (Begin Delete)
1. `SHIFT` + `g` (End Delete at End of File)
1. `SHIFT` + `a` (Enter into Append Mode)
1. `CMD` + `v` (Paste new Contents)
1. `ESC` (Go back to Command Mode)
1. `:` then `w` then `q` then `ENTER` (or `RETURN`) (Write new File changes and Quit `vim`)

<a id="install-macos-commandline-utilities"></a>
### Install macOS Commandline Utilities

There's kind of a Catch-22 with macOS, that in order to install `brew`, you're going to also need to install the macOS Commandline Utilities so that you can get `git` and `curl` to be available, along with `gcc` (GNU Compiler Collection) for building and linking any relevant binaries during the `brew` setup and install.

To install these tools, you may get a prompt when you go to install `brew`, but you can also force the install by running the command:

```bash
xcode-select --install
```

<a id="install-brew-and-other-tools"></a>
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

<a id="bash-configuration-files"></a>
### `bash` Configuration Files

The `.bashrc.d` directory provides a bunch of `.bash` files, which are just shell scripts using `bash` syntax, and have been configured this way to just show them as being different from "normal" shell scripts.

The idea here, which I found from a blog which I'll add here as a reference, is that we can iterate through this directory based-on the custom `.bash` file-extension, and simply parse these files in the order we discover them by calling the `source` command. By doing that, we can `source` all the files into the `bash` configuration, without having to put everything into one giant long file.

This should make it easier to see what configuration is setup for each utility, as needed, and allow us to add more as we go, or remove any that we don't want or need anymore.

You can see that from this snippet that you'll find in the `.bashrc` file:

```bash
# Source the ~/.bashrc.d directory
for custom_config_file in ~/.bashrc.d/*.bash; do
    source ${custom_config_file}
done
unset -v custom_config_file
```

Note that "work" being done here is the `source` command. Some of the text here can be put into variables to make this snippet more configurable, but I find this to be straight-forward enough, as it currently is.

The `unset` call is basically a "clean-up" command to make sure that this iteration variable from the `for` loop does not stay in scope in your environment, since this is written into the `bash` configuration file, and due to the `chsh` command that we ran to set `bash` as the login shell, this will be run at the start of every terminal's shell environment.

Note that you'll see some other stuff in the `.bashrc` file, because this method isn't foolproof.

One major caveat is that we're going to be alphabetically iterating through the `.bash` files based-on the current system LOCALE configuration's alphanumerical (symbolic) ordering. This means that if there's any of these configurations that need to happen before or after other configurations, you can't control that with this approach, except by enforcing some specific naming conventions in the filenames.

<a id="bash-profile-and-bashrc-file"></a>
### `bash` Profile and `.bashrc` File

In macOS, the login shell as configured by `chsh` being `bash` will actually `source` the `~/.bash_profile` file for the current User, whose `$HOME` directory is equivalent to the `~/` shorthand.

But in Linux variants, like Ubuntu (Debian), you'd find that the `~/.bashrc` file is actually the configuration file that gets sourced.

So, you'll see that we keep the `.bash_profile` file and simply configure it to `source` the `.bashrc` file.

This is, arguably, just a convenience that allows us to have a common `.bashrc` file across macOS and Linux environments.

<a id="linux-desktop-vm-or-docker"></a>
## Linux (Desktop, VM, or Docker)

You can use most of these configuration files with Linux, as well, and similar tools exist, but you won't have access to `brew`, and you may need to install some of the tools directly.

<a id="_other-configs-directory"></a>
## `_other-configs/` Directory

See the [`_other-configs/README.md`](./_other-configs/README.md) for details; but, this folder is meant for non-`bash` configurations that don't necessarily go here in the `$HOME` directory and are more just `bash`-adjacent, so I've collected them here for convenience (and so that I don't make _yet another_ new GitHub repo 👻).

<a id="references"></a>
## References
