<pre>
          888          888     .d888 d8b 888
          888          888    d88P"  Y8P 888
          888          888    888        888
      .d88888  .d88b.  888888 888888 888 888  .d88b.  .d8888b
     d88" 888 d88""88b 888    888    888 888 d8P  Y8b 88K
     888  888 888  888 888    888    888 888 88888888 "Y8888b.
     Y88b 888 Y88..88P Y88b.  888    888 888 Y8b.          X88
      "Y88888  "Y88P"   "Y888 888    888 888  "Y8888   88888P'
                                                    - mthadley
</pre>

Just a backup of some of my configs, for use with [GNU Stow](http://www.gnu.org/software/stow/)

Configurations can be deployed using the following command (make sure you have `stow` installed):

```console
$ stow --no-folding [dir]
```

Now you can manage all of your config files and from a single git directory and track their changes.

## Program specific setup

These require a few extra steps before their configuration is complete:

### Vim Setup

Make sure to install `plug` first:

```console
$ curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```
Then run `:PlugInstall`.

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
