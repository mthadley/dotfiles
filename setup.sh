#!/bin/bash

#
# Dotfiles setup script
#

validateCmd () {
	command -v "$1" >/dev/null 2>&1 || { echo >&2 "$1 not installed Aborting."; exit 1; }
}

setupVim () {
	echo "Configuring Vim..."

	git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

	vim +PluginInstall +qall now
}

setupZSH () {
	echo "Configuring zsh..."

	curl -L http://install.ohmyz.sh | sh

	git clone https://github.com/chriskempson/base16-shell.git "$HOME/.config/base16-shell"
}

setupTmux () {
	echo "Configuring Tmux..."

	git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"

	bash "$HOME/.tmux/plugins/tpm/scripts/install_plugins.sh"
}

for CMD in curl vim git tmux; do
	validateCmd "$CMD"
done

printf "\nDeploying configs:\n\n"

for STOW_DIR in "$(dirname $0)"/*/; do
	echo "$(basename "$STOW_DIR")..."

	stow --no-folding "$STOW_DIR"
done

printf "\nProgram specific setup:\n\n"

setupVim
setupZSH
setupVim

printf "\nDone\n"