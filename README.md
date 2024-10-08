[![GitHub license](https://img.shields.io/github/license/dchakro/brewlog)](https://github.com/dchakro/brewlog/blob/master/LICENSE)
[![GitHub issues](https://img.shields.io/github/issues/dchakro/brewlog)](https://github.com/dchakro/brewlog/issues)
[![GitHub last commit (branch)](https://img.shields.io/github/last-commit/dchakro/brewlog/master.svg)](https://github.com/dchakro/brewlog/branches)
[![Bash](https://img.shields.io/badge/Made%20with-Bash-blueviolet)](https://www.gnu.org/software/bash/)

# brewlog

### Why?

I wrote [ `brewlog`](https://github.com/dchakro/brewlog/) to patch a minor but IMHO a significant shortcoming I feel [homebrew](https://brew.sh/) has had for a very long time; and that is the ability to log what homebrew does, more specifically maintain a log of user-executed `brew` activity. IMO it didn't have to be something very sophisticated i.e. integration with system-log, etc.. So, I worked on an idea I found about from [this particular issue](https://github.com/Homebrew/legacy-homebrew/issues/10430) and developed `brewlog`. 



### Why bother with a log file, when brew is so stable?

Yes, `brew` is generally very stable, but occasionally it breaks compatibility when it is upgrading some packages and removes some “obsolete” versions. Generally this is fine, but in certain cases the user wants to retain those packages for compatibility with something else. I recently faced [a problem](https://github.com/brewsci/homebrew-base/issues/29) due to this. While `brewlog` can’t prevent something like this from happening, but it logs `brew` activity so it is much easier to troubleshoot (by identifying what package(s) were added/removed).



### What can `brewlog` do ?

`brewlog` is simple solution that can:

+ `log` [`brew`](https://brew.sh/) activity (`STDOUT` and `STDERR`) to a logfile (default: `~/Logs/brew.log`)
  + because brewlog is a a new command (and not an alias), the user still retains the freedom to run `brew [command] [formula]` in case they do not want to log some brew activity.
+ `tail` the `brew.log` file to display selected number of lines.
+ `archive` the brew.log file (user has to explicitly invoke this command to archive).
  + The `brew.log` is removed during archiving, a new log file is created on the next run of `brewlog`.

Now you're easily able to track the changes made to your system while running `brew upgrade`or `brew cleanup`.



### How to use

#### a) Install from source

The script [`install.sh`](https://github.com/dchakro/brewlog/blob/master/install.sh) automatically picks the place to install brewlog by detecting the location where the `brew` binary is placed in your system `$PATH`.

```sh
# Install
curl -sSL 'https://raw.githubusercontent.com/dchakro/brewlog/master/install.sh' | bash
# Show help
brewlog --help
```

#### b) Install from binary

1. Download the binary from the [latest release](https://github.com/dchakro/brewlog/releases/latest) (should run on *nix with a [homebrew](https://brew.sh/) installation).
2. `mv brewlog /usr/local/bin/brewlog` or to some other place that is in your `$PATH`.
3. Familiarize yourself by running `brewlog —help`.

#### c) Install from source with modifications

```sh
# download
curl -OJL 'https://raw.githubusercontent.com/dchakro/brewlog/master/install.sh'
# Review/Modify code
bat install.sh
nano install.sh
# Install
sh install.sh | bash
# Show help
brewlog --help
```



#### Examples using brewlog

```sh
# Running homebrew commands
brewlog install ffmpeg
brewlog info ffmpeg
brewlog outdated

# Tail the log file
brewlog tail
brewlog tail -n 5

# archive the current log file
brewlog archive

# Even complex brew commands work with brewlog
brewlog list --multiple --versions
brew deps ffmpeg | xargs brewlog uninstall ----ignore-dependencies

# Writing package and cask dependency tree
brewlog tree                                                                                  
package and cask dependency tree updated. Find it here: ~/Logs/brew_tree.txt
```



### `brewlog —help` listing parameters and examples:

```
brewlog - allows you to log your homebrew/linuxbrew operations to a file.
Usage:
   brewlog [brew command] [arguments to homebrew]
e.g.
   brewlog install ffmpeg, invokes "brew install ffmpeg" and writes output to a log file.

OPTIONS:
    --help         Show help
    --brew-help    Show brew commands (alias to "brew help")
    version        Show brewlog version info
    tree           Write the dependency tree of all installed packages & casks to a file
    archive        Archives the current log file as .xz (gzip as fallback if xz not found)
    find [TERM]	   grep the TERM in the logfile.
    tail [-n INT]  Show the last "INT" lines from the log file.
                                  (default: last 15 lines)

Homebrew/Linuxbrew Function examples:
  brewlog install [formula]     		Install formula
  brewlog uninstall [formula]   		Uninstall formula
  brewlog deps [formula]        		Show dependencies for [formula]
  brewlog uses --installed [formula]    Show items listing [formula] as a dependency
  brewlog outdated              		Show outdated formulae
  brewlog upgrade [formula]     		Upgrade all (or entered) brew formula
  ... ... ...
     Find out more homebrew commands by running "brew --help".
```

If you found `brewlog` useful consider adding a star ‘✩' to this repo.

[![PayPal](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://paypal.me/robocopAlpha) 

### Notice about the command `brew log`:

+ Not to be confused with `brew log` which shows the commit history (similar to `git log`). 
+ I'm open to a new name, but for now as I personally don’t use `brew log`, I had no “merge conflicts” in my brain while assigning  `brewlog` to achive my desired result of logging brew output :) [*IMHO* `brew history` *might have been a better name for* `brew log`]



© Deepankar Chakroborty, 2020. All rights reserved. 
