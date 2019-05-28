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
git clone --separate-git-dir=$HOME/.mycfg /path/to/repo $HOME/mycfg_tmp
rsync --recursive --verbose --exclude '.git' mycfg_tmp/ $HOME/
rm -r mycfg_tmp
```

