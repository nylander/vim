# My .vim folder

- Last modified: tor okt 05, 2023  11:55
- Sign: Johan Nylander

---

*Vim isn't an editor designed to hold its users' hands. It is a tool, the use
of which must be learned.*

---Bram Moolenaar (author of vim)

---

## Description

Reasonable setup for efficient work with the [vim
editor](https://www.vim.org/).  In particular, I use settings for the
"graphical vim" (`gvim`).

#### Current file structure

    vim/
       ├── pack
       │   └── plugins
       │       ├── opt
       │       │   └── vim-game-code-break
       │       └── start
       │           ├── copilot.vim
       │           ├── csv.vim
       │           ├── LargeFile
       │           ├── sketch.vim
       │           ├── taglist.vim
       │           ├── vim-instant-markdown
       │           ├── vim-snakemake
       │           ├── vim-template
       │           └── vimwiki
       ├── README.md
       └── vimrc


To setup on a new machine, see the [Replication... section
below](#replicating-the-repository-on-a-new-machine)

## Some notes

### File `vimrc`

`~/.vimrc` is a symbolic link to `~/.vim/vimrc`.

### Additions and plugins/submodules

1. Clone a plugin directory in `~/.vim/vimrc/pack/plugins/start`, or in
   `~/.vim/vimrc/pack/plugins/opt`.

   For example:

       $ git clone https://github.com/vim-scripts/taglist.vim.git \
                  ~/.vim/pack/plugins/start/taglist.vim

2. Open `vim` and execute

        :helptags ~/.vim/pack/plugins/start/taglist.vim

If you put the plugin (say, `foo`) in `~/.vim/vimrc/pack/plugins/opt`, it is
not loaded at runtime but can be added by using the command `:packadd foo`.

- Remove submodule

        $ git submodule deinit pack/plugins/start/foo
        $ git rm -r pack/plugins/start/foo
        $ rm -rf .git/modules/pack/plugins/start/foo

- Update submodules

        $ git submodule update --remote --merge

Then add and commit any new changes, followed by push.  If I need to make
changes in submodule files, I do it from my own fork of the submodule (adding
submodule as examples below).

#### Submodules used

\footnotesize

    mkdir -p $HOME/.vim/pack/plugins/{start,opt}
    cd $HOME/.vim
    git submodule add https://github.com/chrisbra/csv.vim.git pack/plugins/start/csv.vim
    git submodule add https://github.com/suan/vim-instant-markdown.git pack/plugins/start/vim-instant-markdown
    git submodule add https://github.com/ivan-krukov/vim-snakemake.git pack/plugins/start/vim-snakemake
    git submodule add https://github.com/vim-scripts/sketch.vim.git pack/plugins/start/sketch.vim
    git submodule add https://github.com/Maxlufs/LargeFile.vim.git pack/plugins/start/LargeFile.vim
    git submodule add https://github.com/vim-scripts/taglist.vim.git pack/plugins/start/taglist.vim
    git submodule add https://github.com/nylander/vim-template.git pack/plugins/start/vim-template
    git submodule add https://github.com/vim-scripts/vimwiki.git pack/plugins/start/vimwiki
    git submodule add https://github.com/johngrib/vim-game-code-break.git pack/plugins/opt/vim-game-code-break

\normalsize

## Replicating the repository on a new machine

(Note: partly untested)

We will clone the vim directory and then symlink to `$HOME/.vim` (and
`$HOME/.vim/vimrc` to `$HOME/.vimrc`).  One alternative is to clone the repo
directly to `$HOME/.vim`, and link/copy the `.vim/vimrc` to `$HOME/.vimrc`.

1. Install prerequisites (see also [Update...](#update-to-latest-vim-version-using-ppa) below)

        $ sudo apt install vim-gui-common exuberant-ctags

2. Clone the repository (recursively to clone plugins as well).

        $ git clone --recursive https://github.com/nylander/vim.git

3. Generate helptags for plugins:

        $ vim
        :helptags ALL

4. Symlink to .vim and .vimrc:

        $ ln -sf $PWD/vim $HOME/.vim
        $ ln -sf $PWD/vim/vimrc $HOME/.vimrc


## Update to latest vim version using PPA

Oct 2023: Update to vim 9 from PPA:

    $ sudo add-apt-repository ppa:jonathonf/vim
    $ sudo apt update
    $ sudo apt install vim
    $ vim --version


### Links

- <https://gist.github.com/manasthakur/d4dc9a610884c60d944a4dd97f0b3560>
- <https://itsfoss.com/install-latest-vim-ubuntu/>


