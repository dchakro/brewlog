#!/usr/bin/env bash

###########
# author: Deepankar Chakroborty
# https://github.com/dchakro
# Leave feedback: https://github.com/dchakro/brewlog
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

OPTIONS:     
    --help         Show help
    --brew-help    Show brew commands (alias to "brew help")
    version        Show brewlog version info
    archive        Archives the current log file as .xz (gzip as fallback if xz not found)
	search [TERM]       Searches for TERM in the logfile. (Uses grep)
    tail [-n INT]       Show the last "INT" lines from the log file.
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
printf 'brewlog v.0.2  -  brewlog allows you to run homebrew commands while 
                  simultanously logging to a file

Follow the development: https://github.com/dchakro/brewlog
Copyright 2020, Deepankar Chakroborty. All rights reserved.
';
}

if [ ! -f "$LOGFILE" ] ; then
	# Creating brew.log
	echo "Creating $LOGFILE"
	mkdir -p "$(dirname "$LOGFILE")"
	touch "$LOGFILE"
fi

if [ "$#" -eq 0 ]; then
    HELP
    exit 0;
fi

if [ "$1" == "--help" ]; then
	HELP
	exit 0;
elif [ "$1" == "--brew-help" ]; then
	brew help
	exit 0;
elif [ "$1" == "version" ]; then
	VERSION
	exit 0;
elif [ "$1" == "tail" ]; then
	if [ "$2" == "-n" ]; then
	   # tail with specified number of lines
	   tail -n "$3" "$LOGFILE"
	   exit 0;
	else
	   # tail with 15 lines (default -n for tail is 10, I wanted more)
	   tail -n 15 "$LOGFILE"
	   exit 0;
	fi
elif [ "$1" == "find" ]; then
	# Listing all appearances of search term in the log file.
	cat "$LOGFILE" | egrep "$2"
elif [ "$1" == "archive" ]; then
	if [ -f "$LOGFILE" ] ; then
		# Archiving logfile i.e. brew.log is removed (will be created on next run)
		command -v xz > /dev/null
		if [ "$?" -eq "0" ]; then
		    xz -6vf $LOGFILE
		    mv "${LOGFILE}.xz" "$LOGFILE-$(date +'%Y%m%d').xz"
		    exit 0;
		else
		    # if xz is unavailable use gz
			gzip -6fv $LOGFILE
			mv "${LOGFILE}.gz" "$LOGFILE-$(date +'%Y%m%d').gz"
		    exit 0;
        fi
	else
		echo "$LOGFILE doesn't exist"
		exit 1
	fi
else
   echo "brew $* :: $(date)" | tee -a "$LOGFILE"
   # logs both STDOUT and STDERR to $LOGFILE
   $(which brew) "$@" 2>&1 | tee -a "$LOGFILE"
   exit 0;
fi

# Copyright 2020, Deepankar Chakroborty. All rights reserved.