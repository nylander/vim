# My .vim folder

- Last modified: ons okt 21, 2020  06:50
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



