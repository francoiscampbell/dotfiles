# dotfiles

## Setup on a new computer
Credit to https://medium.com/toutsbrasil/how-to-manage-your-dotfiles-with-git-f7aeed8adf8b for this method

```bash
git clone --bare git@github.com:francoiscampbell/dotfiles.git $HOME/.dotfiles
git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME checkout  # add -f to ignore local dotfiles changes
```
Re-source shell configs as necessary. This will also define the `.f` alias as 
```bash
alias .f='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```
 
## Committing changes
```bash
.f add .thedotfile
.f commit
.f push
```
