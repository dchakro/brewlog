#!/bin/bash
BREWLOCATION=$(command -v brew)
echo "$BREWLOCATION/brewlog"
if [ "$?" -ne "0" ]; then
    echo "Homebrew/Linux brew installation not detected in your PATH."
    exit 1
else
    BREWLOCATION= $(dirname "$BREWLOCATION")
fi

if [ -w /usr/local/bin ]; then
   curl -sSL 'https://raw.githubusercontent.com/robocopAlpha/brewlog/master/brewlog.sh' > $BREWLOCATION/brewlog
   chmod +x $BREWLOCATION/brewlog
else
  curl -sSL 'https://raw.githubusercontent.com/robocopAlpha/brewlog/master/brewlog.sh' >| brewlog.sh
  echo "user $(whoami) cannot write to $BREWLOCATION"
  read -r -p "use sudo (y/N): " choice
  shopt -q nocasematch;
  if [ "$?" -eq "1" ]; then
    shopt -s nocasematch
    flag=1
  fi
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