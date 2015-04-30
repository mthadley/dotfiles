### Mike's Dotfiles

Just a backup of some of my configs, for use with [GNU Stow](http://www.gnu.org/software/stow/)

#### Vim Setup

Make sure to install vundle first:

```console
$ git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```
Then simply run `:BundleInstall`

#### ZSH setup

Download and execute the install script:

```console
$ curl -L http://install.ohmyz.sh | sh
```

Install base-16

```console
$ git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell
```

#### Tmux setup

Install `tpm`

```console
$ git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```
Then install the plugins with the following keybind: `ctrl+a I`
