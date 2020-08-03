if [ -w /usr/local/bin ]; then
   curl -sSL 'https://raw.githubusercontent.com/robocopAlpha/brewlog/master/brewlog.sh' > /usr/local/bin/brewlog
   chmod +x /usr/local/bin/brewlog
else
   sudo -s
   if [ -w /usr/local/bin ]; then
      curl -sSL 'https://raw.githubusercontent.com/robocopAlpha/brewlog/master/brewlog.sh' > /usr/local/bin/brewlog
   	  chmod +x /usr/local/bin/brewlog
      exit
      sudo -k
    else
      echo "cannot write to /usr/local/bin".
      exit 1;
    fi
fi
