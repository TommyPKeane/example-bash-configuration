# Multiple Concurrent NodeJS (and NPM) Installs
# (Node Version Manager)
#
# Reference:
# - https://github.com/nvm-sh/nvm
# - https://formulae.brew.sh/formula/nvm
#
# Install:
# `brew install nvm`

export NVM_DIR="${HOME}/.nvm"

# This loads nvm
[ -s "${NVM_DIR}/nvm.sh" ] && \. "${NVM_DIR}/nvm.sh"

# This loads nvm bash_completion
[ -s "${NVM_DIR}/bash_completion" ] && \. "${NVM_DIR}/bash_completion"
