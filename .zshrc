#### Custom aliases and functions located in ~/.oh-my-zsh/custom/

#### Path to oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

#### THEME #####################
## Set name of the theme to load for trying out
#ZSH_THEME="robbyrussell"
#ZSH_THEME="jonathan"
#ZSH_THEME="miloshadzic"
#ZSH_THEME="minimal"
#ZSH_THEME="gnzh"
#ZSH_THEME="agnoster"
#ZSH_THEME="simple" <-- good
#ZSH_THEME="tjkirch" <-- good
#ZSH_THEME="macovsky-ruby" <-- good
#ZSH_THEME="mlh" <-- good (simple, only current folder
#ZSH_THEME="crunch"
ZSH_THEME="random"

#### PLUGINS #####################
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(asdf git)
source $ZSH/oh-my-zsh.sh

#### MISC. SETTINGS #####################
# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
 DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
 COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder
#######################################


#### USER CONFIGURATION ###############
# export MANPATH="/usr/local/man:$MANPATH"
export PATH="/Users/nixycamacho/bin:$PATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
 if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
 fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"
#####################################

##### LOAD ALIASES ##################
[[ -f $ZSH/custom/.aliases ]] && source $ZSH/custom/.aliases

#### LOAD SELF-DEFINED FUNCTIONS ####
for function in $ZSH/custom/functions/*; do
  source $function
done

# To run asdf
. /opt/homebrew/opt/asdf/libexec/asdf.sh
