# custom scripts or binaries
PATH="$HOME/.local/bin:$PATH"
# node_modules
PATH="$HOME/.local/share/node_modules/bin:$PATH"
export npm_config_prefix=~/.local/share/node_modules
# gem
PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH"

export EDITOR=vim