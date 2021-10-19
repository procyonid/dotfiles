# for loading non-zsh stuff into shell
if [ -d "$HOME/.config/profile_modules" ]; then
	for filepath in $HOME/.config/profile_modules/* ; do
		source $filepath
	done
fi
