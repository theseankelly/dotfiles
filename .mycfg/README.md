# dotfiles

Inspired by https://news.ycombinator.com/item?id=11071754

## Setup
```
git init --bare $HOME/.mycfg
alias config='/usr/bin/git --git-dir=$HOME/.mycfg/ --work-tree=$HOME'
config config status.showUntrackedFiles no
```

To import the .mybashrc settings, add this to your .bashrc
```
# custom bashrc settings for this machine
if [ -f ~/.mybashrc ]; then
    . ~/.mybashrc
fi
```

## Cloning
```
git clone --separate-git-dir=$HOME/.mycfg https://github.com/theseankelly/dotfiles $HOME/mycfg_tmp
rsync --recursive --verbose --exclude '.git' mycfg_tmp/ $HOME/
rm -r mycfg_tmp
alias config='/usr/bin/git --git-dir=$HOME/.mycfg/ --work-tree=$HOME'
config config status.showUntrackedFiles no
```

## Dependent Utilities

* [powerline](https://github.com/powerline/powerline)
  * Must use python3 via pip: `sudo python3 -m pip install powerline-status`
* [virtualenvwrapper](https://virtualenvwrapper.readthedocs.io/en/latest/install.html)
  * `sudo pip install virtualenvwrapper`
  * NOTES: use sudo. And I had some trouble with `pip3`.
* vim
  * `sudo apt install vim-gtk` to enable LUA support
  * `sudo apt install liblua5.2-dev` (or whichever lua version is in vim...) for `color_coded` support
  * Compile [`color_coded`](https://github.com/jeaye/color_coded#all)
    ```
    sudo apt-get install build-essential libclang-3.9-dev libncurses-dev libz-dev cmake xz-utils libpthread-workqueue-dev
    cd ~/.vim/plugged/color_coded
    mkdir build && cd build
    cmake ..
    make && make install
    make clean && make clean_clang
    ```
