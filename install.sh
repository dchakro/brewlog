#!/usr/bin/env bash
BREWLOCATION=$(command -v brew)
if [ "$?" -ne "0" ]; then
    echo "Homebrew/Linux brew installation not detected in your PATH."
    exit 1
else
    BREWLOCATION=$(dirname "$BREWLOCATION")
    echo "Determined installation location: $BREWLOCATION/brewlog"
fi

if [ -w $BREWLOCATION ]; then
   curl -sSL 'https://raw.githubusercontent.com/robocopAlpha/brewlog/master/brewlog.sh' > $BREWLOCATION/brewlog
   chmod +x $BREWLOCATION/brewlog
   printf "
brewlog has been installed as $(command -v brewlog). 
You can start with brewlog --help %s\n"
else
  shopt -q nocasematch;
  if [ "$?" -eq "1" ]; then
    shopt -s nocasematch
    flag=1
  fi
  curl -sSL 'https://raw.githubusercontent.com/robocopAlpha/brewlog/master/brewlog.sh' >| brewlog.sh
  echo "user $(whoami) cannot write to $BREWLOCATION"
  read -r -p "use sudo (y/N): " choice
  if [[ "$choice" =~ ^(yes|y)$ ]]
  then
    sudo mv brewlog.sh $BREWLOCATION/brewlog
    sudo chmod +x $BREWLOCATION/brewlog
    sudo -k
  else
    echo "cannot install $BREWLOCATION/brewlog without sudo rights"
    exit 1;
  fi
  if [ "$flag" -eq "1" ]; then
    shopt -s nocasematch
  fi
fi
