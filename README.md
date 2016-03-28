# Mike's Dotfiles

Just a backup of some of my configs, for use with [GNU Stow](http://www.gnu.org/software/stow/)

Configurations can be deployed using the following command (make sure you have `stow` installed):

```console
$ stow --no-folding [dir]
```

Now you can manage all of your config files and from a single git directory and track their changes.

## Program specific setup

These require a few extra steps before their configuration is complete:

### Vim Setup

Make sure to install vundle first:

```console
$ git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```
Then simply run `:PluginInstall`

### ZSH setup

Download and execute the install script:

```console
$ curl -L http://install.ohmyz.sh | sh
```

### Tmux setup

Install `tpm`:

```console
$ git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```
Then install the plugins with the following keybind: <kbd>CTRL+a I</kbd>
