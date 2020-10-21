# My .vim folder

- Last modified: ons okt 21, 2020  08:04
- Sign: Johan Nylander

## File `vimrc`

`~/.vimrc` is a symbolic link to `~/.vim/vimrc`.

## Additions and plugins

1. Clone a plugin directory in `~/.vim/vimrc/pack/plugins/start`, or in
   `~/.vim/vimrc/pack/plugins/opt`.

   For example:

       git clone https://github.com/vim-scripts/taglist.vim.git \
                  ~/.vim/pack/plugins/start/taglist.vim

2. Open `vim` and execute

        :helptags ~/.vim/pack/plugins/start/taglist.vim

If you put the plugin (say, `foo`) in `~/.vim/vimrc/pack/plugins/opt`, it is
not loaded at runtime but can be added by using the command `:packadd foo`.

## Current file structure

Note, not all files are under version control in this repository.
Stable plugins may be added as git submodules later.

    .
    ├── pack
    │   └── plugins
    │       ├── opt
    │       │   └── vim-game-code-break
    │       └── start
    │           ├── csv.vim
    │           ├── instant-markdown
    │           ├── LargeFile
    │           ├── nexus.vim
    │           ├── sketch.vim
    │           ├── taglist.vim
    │           ├── vim-snakemake
    │           ├── vim-template
    │           └── vimwiki
    ├── README.md
    └── vimrc

Sources:

    cd ~/Documents/Projects/GIT/vim/pack/plugins/start/
    git clone https://github.com/chrisbra/csv.vim.git
    git clone https://github.com/suan/vim-instant-markdown.git
    git clone https://github.com/ivan-krukov/vim-snakemake.git
    git clone https://github.com/vim-scripts/sketch.vim.git
    git clone https://github.com/Maxlufs/LargeFile.vim.git
    git clone https://github.com/vim-scripts/taglist.vim.git
    git clone https://github.com/aperezdc/vim-template.git
    git clone https://github.com/vim-scripts/vimwiki.git

    cd ~/Documents/Projects/GIT/vim/pack/plugins/opt/
    git clone https://github.com/johngrib/vim-game-code-break.git

<https://gist.github.com/manasthakur/d4dc9a610884c60d944a4dd97f0b3560>

Add submodules

    git submodule add https://github.com/chrisbra/csv.vim.git pack/plugins/start/csv.vim
    git submodule add https://github.com/suan/vim-instant-markdown.git pack/plugins/start/vim-instant-markdown
    git submodule add https://github.com/ivan-krukov/vim-snakemake.git pack/plugins/start/vim-snakemake
    git submodule add https://github.com/vim-scripts/sketch.vim.git pack/plugins/start/sketch.vim
    git submodule add https://github.com/Maxlufs/LargeFile.vim.git pack/plugins/start/LargeFile.vim
    git submodule add https://github.com/vim-scripts/taglist.vim.git pack/plugins/start/taglist.vim
    git submodule add https://github.com/aperezdc/vim-template.git pack/plugins/start/vim-template
    git submodule add https://github.com/vim-scripts/vimwiki.git pack/plugins/start/vimwiki
    git submodule add https://github.com/johngrib/vim-game-code-break.git pack/plugins/opt/vim-game-code-break

Remove submodule

    git submodule deinit pack/plugins/start/foo
    git rm -r pack/plugins/start/foo
    rm -r .git/modules/pack/plugins/start/foo

## Replicating the repository on a machine

Clone the repository (recursively to clone plugins as well):

    git clone --recursive https://github.com/username/reponame.git

Symlink .vim and .vimrc:

    ln -sf reponame ~/.vim
    ln -sf reponame/vimrc ~/.vimrc

Generate helptags for plugins:

    vim
    :helptags ALL
