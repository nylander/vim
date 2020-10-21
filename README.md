# My .vim folder

- Last modified: ons okt 21, 2020  08:12
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



Add submodules

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

Remove submodule

    git submodule deinit pack/plugins/start/foo
    git rm -r pack/plugins/start/foo
    rm -r .git/modules/pack/plugins/start/foo

## Replicating the repository on a machine

1. Clone the repository (recursively to clone plugins as well):

        git clone --recursive https://github.com/nylander/vim.git

2. Generate helptags for plugins:

        vim
        :helptags ALL

2. Symlink .vim and .vimrc:

        ln -sf vim ~/.vim
        ln -sf vim/vimrc ~/.vimrc

### Links

- <https://gist.github.com/manasthakur/d4dc9a610884c60d944a4dd97f0b3560>

