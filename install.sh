#!/bin/bash
if [ -w /usr/local/bin ]; then
   curl -sSL 'https://raw.githubusercontent.com/robocopAlpha/brewlog/master/brewlog.sh' > /usr/local/bin/brewlog
   chmod +x /usr/local/bin/brewlog
else
  curl -sSL 'https://raw.githubusercontent.com/robocopAlpha/brewlog/master/brewlog.sh' >| brewlog.sh
  echo "user $(whoami) cannot write to /usr/local/bin."
  read -r -p "use sudo (y/N): " choice
  shopt -q nocasematch;
  if [ "$?" -eq "1" ]; then
    shopt -s nocasematch
    flag=1
  fi
  if [[ "$choice" =~ ^(yes|y)$ ]]
  then
    sudo mv brewlog.sh /usr/local/bin/brewlog
    sudo chmod +x /usr/local/bin/brewlog
    sudo -k
  else
    echo "cannot install /usr/local/bin/brewlog without sudo rights"
    exit 1;
  fi
  if [ "$flag" -eq "1" ]; then
    shopt -s nocasematch
  fi
fi