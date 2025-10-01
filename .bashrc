# Bourne Again Shell (bash) Configuration
#
# References:
#   - https://www.gnu.org/software/bash/
#   - https://brew.sh/

# Source the ~/.bashrc.d directory
for custom_config_file in ~/.bashrc.d/*.bash; do
    source ${custom_config_file}
done
unset -v custom_config_file

# Add Installed Binaries to Path
pathadd "/usr/local/bin"

source ~/.bashrc.d/direnv.bash  # Fix Prompt
