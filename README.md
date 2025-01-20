# pywaldotfiles

## Installing

These dotfiles are managed by `stow`. To install, simply run:
```
// To install the dotfiles
make

// To remove the dotfiles
make delete
```

`make` runs the command below. This symbolic links the git repo files to your home directory:
```
stow --verbose --target=$$HOME --restow */
```
`stow` requires the target location to not exist. So if their are errors, you must move and backup your old config files before installing. 

`make delete` runs the command below. This removes the symbolic links from your home directory
```
stow --verbose --target=$$HOME --delete */
```

## Oh My ZSH

Requires:

Syntax Highlighting:
```
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

Autosuggestions:
```
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

Powerlevel10k:
```
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

