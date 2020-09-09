# NVIM Settings

This is my NVM config. There are many like it, but this one is mine.  Current iteration requires Neovim nightly build (until that blows up in my face).

## Dependencies

* fzf

Definitely need this.

```bash
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install
```

* the_silver_searcher

Though I'm not sure if this is still needed.

```sudo apt-get install silversearcher-ag```

```brew install the_silver_searcher```

# TERMINAL HALP

## Get Italics Working in iTerm (and maybe others)

* Create a plain text file called `xterm-256color-italic.terminfo` with the following:

```
# A xterm-256color based TERMINFO that adds the escape sequences for italic.
xterm-256color-italic|xterm with 256 colors and italic,
  sitm=\E[3m, ritm=\E[23m,
  use=xterm-256color,
```

* Run this:

```tic xterm-256color.terminfo.txt```

> Finally, we need to tell iTerm2 to use this new TERM, xterm-256color-italic, by default. This is done in the terminal pane of whatever profile you’re using. The new entry probably won’t be in the list, but we can just type it in.

![terminal-type](https://raw.githubusercontent.com/droppedoncaprica/nvim/master/terminal-type.jpg)

> If you don’t see italicised text, something else might be overriding the TERM environment variable. Check its value is xterm-256color-italic.

```
$ echo $TERM
xterm-256color-italic
```

> If it’s different, check you’re dotfiles (like .bashrc)

Shamelessly stolen from [here.](https://alexpearce.me/2014/05/italics-in-iterm2-vim-tmux/)
