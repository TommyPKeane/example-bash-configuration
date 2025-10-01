# Bourne Again Shell (bash) Configurations
#
# Reference:
# 	- https://tiswww.case.edu/php/chet/bash/bashtop.html
#	- https://www.gnu.org/software/bash/manual/bash.html


echo -e "🫡 🤖 🤓 💻 👻 Hiya, $(whoami)!\n"
echo "Reminder to regularly run (once a week -ish):"
echo "  ᠅ brew update"
echo "  ᠅ brew upgrade"
echo "  ᠅ uv tool upgrade --all"


# From: https://superuser.com/questions/39751/add-directory-to-path-if-its-not-already-there
pathadd() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="${PATH:+"$PATH:"}$1"
    fi
}
