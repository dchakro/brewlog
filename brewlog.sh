#!/bin/bash

###########
# author: robocopAlpha
# https://github.com/robocopAlpha
# Leave feedback: https://gist.github.com/robocopAlpha/3e9792b6e47c3648e725fb518a2dbf68
#
# Software provided as is without warranty.
###########

# If needed modify the location of logfile
LOGFILE="$HOME/Logs/brew.log"


## Function definitions:

HELP()
{
printf 'brewlog - allows you to log your homebrew/linuxbrew operations to a file.
Usage:
   brewlog [brew command] [arguments to homebrew]
e.g.
   brewlog install ffmpeg, invokes "brew install ffmpeg" and writes output to a log file.
     
   --help             Show help
   --brew-help        show brew commands (alias to "brew help")
    
OPTIONS:
    version            Show brewlog version
    archive            Archives the current log file as .xz
    tail [-n INT]      Show the last "INT" lines from the log file.
                                  (default: last 15 lines)
   
Homebrew/Linuxbrew Function examples:
  brewlog install [formula]     Install formula
  brewlog uninstall [formula]   Uninstall formula
  brewlog deps [formula]        Show dependencies for formula
  brewlog outdated              Show outdated formulae
  brewlog upgrade [formula]     Upgrade all (or entered) brew formula
  ... ... ...
     Find out more homebrew commands by running "brew --help".
';
  
}

VERSION()
{
printf 'brewlog v.0.1  -  brewlog allows you to run homebrew commands while 
                  simultanously logging to a file

Follow the development: https://github.com/robocopAlpha/brewlog

';
}
VERSION

if [ ! -f "$LOGFILE" ] ; then
	# Creating brew.log
	echo "Creating $LOGFILE"
	mkdir -p "$(dirname "$LOGFILE")"
	touch "$LOGFILE"
fi
if [ "$1" == "--help" ]; then
	HELP
elif [ "$1" == "--brew-help" ]; then
	brew help
elif [ "$1" == "--brew-help" ]; then
	VERSION
elif [ "$1" == "tail" ]; then
	if [ "$2" == "-n" ]; then
	   # tail with specified number of lines
	   tail -n "$3" "$LOGFILE"
	else
	   # tail with 15 lines (default -n for tail is 10, I wanted more)
	   tail -n 15 "$LOGFILE"
	fi
elif [ "$1" == "archive" ]; then
	if [ -f "$LOGFILE" ] ; then
		# Archiving logfile i.e. brew.log is removed (will be created on next run)
		xz -vf $LOGFILE
		mv "${LOGFILE}.xz" "$LOGFILE-$(date +'%Y%m%d').xz"
	else
		echo "$LOGFILE doesn't exist"
		exit 1
	fi
else
   echo "brew $* :: $(date)" | tee -a "$LOGFILE"
   # logs both STDOUT and STDERR to $LOGFILE
   $(which brew) "$@" 2>&1 | tee -a "$LOGFILE"
fi