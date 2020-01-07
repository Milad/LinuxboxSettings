# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

MY_PHPSTORM_VERSION="193.5662.63"
MY_GOGLAND_VERSION="192.5728.103"
MY_PYCHARM_VERSION="181.4203.547"
MY_CLION_VERSION="191.7141.37"

PATH="$HOME/.local/share/JetBrains/Toolbox/apps/PhpStorm/ch-0/$MY_PHPSTORM_VERSION/bin:$PATH"
PATH="$HOME/.local/share/JetBrains/Toolbox/apps/Gogland/ch-0/$MY_GOGLAND_VERSION/bin:$PATH"
PATH="$HOME/.local/share/JetBrains/Toolbox/apps/PyCharm-P/ch-0/$MY_PYCHARM_VERSION/bin:$PATH"
PATH="$HOME/.local/share/JetBrains/Toolbox/apps/CLion/ch-0/$MY_CLION_VERSION/bin:$PATH"
PATH="$HOME/.local/share/JetBrains/Toolbox/bin:$PATH"
PATH="$HOME/Documents/Settings/scripts:$PATH"
