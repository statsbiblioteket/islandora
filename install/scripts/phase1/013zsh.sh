#!/usr/bin/env bash

HOME_DIR=$1

if [ -f "$HOME_DIR/islandora/install/configs/variables" ]; then
  . "$HOME_DIR"/islandora/install/configs/variables
fi

cd "$HOME_DIR"

# Bug fix for Ubuntu 14.04 with zsh 5.0.2 -- https://bugs.launchpad.net/ubuntu/+source/zsh/+bug/1242108
export MAN_FILES
MAN_FILES=$(wget -qO- "http://sourceforge.net/projects/zsh/files/zsh/5.0.2/zsh-5.0.2.tar.gz/download" \
  | tar xvz --overwrite -C /usr/share/man/man1/ --wildcards "zsh-5.0.2/Doc/*.1" --strip-components=2)
for MAN_FILE in ${MAN_FILES}; do gzip -f /usr/share/man/man1/"${MAN_FILE##*/}"; done

# More helpful packages
apt-get -y install zsh
