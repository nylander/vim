# My .vim folder

- Last modified: fre mar 12, 2021  01:40
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

- Remove submodule

    git submodule deinit pack/plugins/start/foo
    git rm -r pack/plugins/start/foo
    rm -rf .git/modules/pack/plugins/start/foo

## Current file structure

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

Submodules added

    mkdir -p pack/plugins/{start,opt}
    git submodule add https://github.com/chrisbra/csv.vim.git pack/plugins/start/csv.vim
    git submodule add https://github.com/suan/vim-instant-markdown.git pack/plugins/start/vim-instant-markdown
    git submodule add https://github.com/ivan-krukov/vim-snakemake.git pack/plugins/start/vim-snakemake
    git submodule add https://github.com/vim-scripts/sketch.vim.git pack/plugins/start/sketch.vim
    git submodule add https://github.com/Maxlufs/LargeFile.vim.git pack/plugins/start/LargeFile.vim
    git submodule add https://github.com/vim-scripts/taglist.vim.git pack/plugins/start/taglist.vim
    git submodule add https://github.com/aperezdc/vim-template.git pack/plugins/start/vim-template
    git submodule add https://github.com/vim-scripts/vimwiki.git pack/plugins/start/vimwiki
    git submodule add https://github.com/johngrib/vim-game-code-break.git pack/plugins/opt/vim-game-code-break

## Replicating the repository on a machine

1. Install prerequisites

        sudo apt install vim-gui-common exuberant-ctags

2. Clone the repository (recursively to clone plugins as well):

        git clone --recursive https://github.com/nylander/vim.git

3. Generate helptags for plugins:

        vim
        :helptags ALL

4. Symlink .vim and .vimrc:

        ln -sf vim ~/.vim
        ln -sf vim/vimrc ~/.vimrc

## TODO

Track local changes made in submodules.

### Links

- <https://gist.github.com/manasthakur/d4dc9a610884c60d944a4dd97f0b3560>

