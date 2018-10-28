echo
echo -n "Would you like to backup your current dotfiles? (y/n) "
old_stty_cfg=$(stty -g)
stty raw -echo
answer=$( while ! head -c 1 | grep -i '[ny]' ;do true ;done )
stty $old_stty_cfg
if echo "$answer" | grep -iq "^y" ;then
	mv ~/.zshrc ~/.zshrc.old
	mv ~/.tmux.conf ~/.tmux.conf.old
	mv ~/.vimrc ~/.vimrc.old
else
	echo -e "\nNot backing up old dotfiles."
fi

printf "source '$HOME/.dotfiles/zsh/zshrc'" > ~/.zshrc
printf "so $HOME/.dotfiles/vim/vimrc" > ~/.vimrc
printf "so $HOME/.dotfiles/vim/vimrc" > ~/.config/nvim/init.vim
ln -s $HOME/.dotfiles/vim/autoload ~/.config/nvim/autoload
printf "source-file $HOME/.dotfiles/tmux/tmux.conf" > ~/.tmux.conf

echo
echo "Please log out and log back in for default shell to be initialized."
