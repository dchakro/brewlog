# brewlog

### Why?

I wrote Brewlog to fulfill a shortcoming I felt [homebrew](https://brew.sh/) has had for a long time. I got the basic idea from [a very old issue on homebrew](https://github.com/Homebrew/legacy-homebrew/issues/10430). 

### What can `brewlog` do ?

`brewlog` is simple solution that can:

+ log homebrew/linuxbrew activity (`STDOUT` and `STDERR`)
  + as it is a new command, the user still retains the freedom to run `brew [command] [formula]` and not log it to the file
+ tail the log file to display selected number of lines.
+ archive the log file (when user invokes the appropriate command).
  + a new log file is created the next time `brewlog` is invoked after archiving.

Now you'll be easily able to track the changes made by `brew upgrade`or `brew cleanup`.



### How to use

```sh
curl -sSL 'install.sh' | bash

# Show help
brewlog --help

# Running homebrew commands
brewlog install ffmpeg
brewlog info ffmpeg

# Even complex brew commands work with brewlog
brewlog list --multiple --versions
```

### Detailed usage

```
brewlog - allows you to log your homebrew/linuxbrew operations to a file.
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
```



**Note:**

+ Not to be confused with `brew log` which shows the commit history (similar to `git log`). 
+ I'm open to a new name, but for now as I personally don’t use `brew log`, I had no “merge conflicts” in my brain while assigning  `brewlog` to achive my desired result of logging brew output :) [*IMHO* `brew history` *might have been a better name for* `brew log`]



