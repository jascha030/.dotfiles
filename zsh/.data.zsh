# Data files directory
export DATA_FILES_DIR=$HOME/.config/datafiles

# Create directory if it doesn't exist yet
[ ! -d $DATA_FILES_DIR ] && mkdir -p $DATA_FILES_DIR

#--------------------------------------------------- FILES -----------------------------------------------------------#

# Zsh history
[ ! -f $DATA_FILES_DIR/.zsh_history ] && touch $DATA_FILES_DIR/.zsh_history

export HISTFILE=$DATA_FILES_DIR/.zsh_history 

# Mysql history
[ ! -f $DATA_FILES_DIR/.mysql_history ] && touch $DATA_FILES_DIR/.mysql_history

export MYSQL_HISTFILE=$DATA_FILES_DIR/.mysql_history

