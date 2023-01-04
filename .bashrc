# Bourne Again Shell (bash) Configuration
#
# References:
# - https://www.gnu.org/software/bash/
# - https://brew.sh/

# brew.sh Setup
eval "$(/opt/homebrew/bin/brew shellenv)"

# Add Installed Binaries to Path
export PATH="/usr/local/bin:${PATH}"

# Source the ~/.bashrc.d directory
for custom_config_file in ~/.bashrc.d/*.bash; do
        source ${custom_config_file}
done
unset -v custom_config_file

source ~/.bashrc.d/direnv.bash  # Fix Prompt
