# dotfiles
Dotfiles for bash, vim, etc

```
ln -sv dotfiles/.bashrc .bashrc
ln -sv dotfiles/.vimrc .vimrc
```

or

```
cat "source ~/dotfiles/.bashrc" >> ~/.bashrc"
```

git: add to .gitconfig
```
[include]
    path = ~/dotfiles/.gitconfig
```
