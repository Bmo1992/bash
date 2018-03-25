This repo is to document my personal bash scripts that I've written. 
Scripts here are written for administrative or personal purposes. 
Feel free to reuse any material here.

The .bash_functions file is placed in the home directory and sourced by placing the following if statement in your ~/.bash_profile


if [ -f ~/.bash_functions ]; then
    . ~/.bash_functions
fi


