# Setup fzf
# ---------
if [[ ! "$PATH" == */home/chenshiyun/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/chenshiyun/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/chenshiyun/.fzf/shell/completion.bash" 2> /dev/null

#export FZF_DEFAULT_COMMAND="fd --exclude={.repo,.git,.idea,.vscode,.sass-cache,node_modules,build} --type f"

export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --preview '(highlight -O ansi {} || cat {}) 2> /dev/null | head -500'"

# Key bindings
# ------------
source "/home/chenshiyun/.fzf/shell/key-bindings.bash"
