"" File: vimrc
""
"" Last modified: fre nov 06, 2020  01:28
""
"" Sign: Johan Nylander
""
"" Sections:
""     INSTALL
""     DEFAULTS
""     GUI SETTINGS
""     FUNCTIONS
""     COMMANDS
""     FILE TYPES
""     MAPPINGS
""     PHYLO MENU
""     HELP


""===========================================================================
"" INSTALL
""===========================================================================
""
"" Installation of vim on (X)ubuntu:
""
""     sudo apt install -y exuberant-ctags \
""                         vim-common \
""                         vim-gui-common \
""                         vim-scripts
""
"" Download and install plug-ins:
""
"" (from www.vim.org):
""
""     csv.vim
""     LargeFile.vim
""     sketch.vim
""     vimwiki.vim

"" (from github.com):
""
""     vim-pathogen
""     vim-template
""
"" My vim stuff can be found on:
""
""     www.abc.se/~nylander
""
"" Install using Vim 8's own package manager system:
""
"" 1. Clone a plugin directory in `~/.vim/vimrc/pack/plugins/start` or in
""    `~/.vim/vimrc/pack/plugins/opt`.
"" 
""    For example:
"" 
""        git clone https://github.com/vim-scripts/taglist.vim.git \
""                   ~/.vim/vimrc/pack/plugins/start/taglist.vim
"" 
"" 2. Open `vim` and execute
"" 
""         :helptags ~/.vim/vimrc/pack/plugins/start/taglist.vim
"" 
"" If you put the plugin (say, `foo`) in `~/.vim/vimrc/pack/plugins/opt`, it is
"" not loaded at runtime but can be added by using the command `:packadd foo`.
""


""===========================================================================
"" DEFAULTS
""===========================================================================

let g:instant_markdown_autostart = 0
syntax on                                                     " Enable syntax
filetype plugin indent on                                     " Enable plugins for filetype
"set textwidth=100                                            " Maximum width of text that is being inserted (line will be broken).
set wrap!                                                     " Do not soft wrap buffer.
set nu                                                        " Note: no numbers ('set nu!') when teaching.
set shiftwidth=4                                              " Indent 4 spaces
set shiftround                                                " Round indent to multiple of 'shiftwidth'
set autoindent                                                " Reuse indent on current line
set list listchars=tab:❘-,trail:·,extends:»,precedes:«,nbsp:× " Display indentation guides
set tabstop=4                                                 " Tab is 4 spaces
set expandtab                                                 " Replace tabs with spaces,
autocmd FileType make setlocal noexpandtab                    "   but not if editing a Makefile
set matchpairs+=<:>                                           " Add <> as match pairs (default "(:),{:},[:]")
set nocompatible                                              " For vimwiki
"set cursorline cursorcolumn                                  " Highlight current line/column
set ruler                                                     " Show the line and column number of the cursor position.   
set backspace=indent,eol,start                                " Backspace behavior.
set foldmethod=indent                                         " Enable folding on indentation. Use zo, zc, zM, zR to open/close.
set foldminlines=0                                            " Fold also single lines.
set foldenable!                                               " Fold by default.
"set viminfo='10,\"100,:20,%,n~/.viminfo

"" Manipulate status line to show seq position.
"" TODO: This is work in progress.
"set statusline=[%l,%c].\ Seqpos:%{ShowSeqPos()}
"set statusline+=\ Seqpos:%{ShowSeqPos()}%=[%l,%c]
"set statusline+=\Seq\ pos:\ %{ShowSeqPos()}\ [%{ShowSeqLabel()}]%=[%l,%c]
"set laststatus=2


""===========================================================================
"" GUI SETTINGS
""===========================================================================

set guifont=DejaVu\ Sans\ Mono\ 10                  " On awesome laptop.
"set guifont=DejaVu\ Sans\ Mono\ 20                 " For teaching.
"set guifont=Monospace\ 10                          " On awesome laptop.
"set guifont=Monospace\ 20                          " For teaching.

set guioptions+=b                                   " GUI bottom scrollbar
set guioptions-=T                                   " No toolbar in GUI

"" Set default size for GUI window
"if has("gui_running")
"  "" GUI is running or is about to start.
"  "" Maximize gvim window.
"  set lines=40 columns=150
"else
"  "" This is console Vim.
"  if exists("+lines")
"    set lines=30
"  endif
"  if exists("+columns")
"    set columns=100
"  endif
"endif


""===========================================================================
"" FUNCTIONS
""===========================================================================

"" For vim-templates
"" TODO: use global variable for company
function! GetCompany()
    return 'NRM/NBIS'
endfunction

"" For vim-templates
"" TODO: use global variable for user
function! GetFullUser()
    return 'Johan Nylander'
endfunction

"" Automatically update the 'Last modified:' date on write buffert.
"" http://vim.wikia.com/wiki/Insert_current_date_or_time
""" If buffer modified, update any 'Last modified: ' in the first 20 lines.
""" 'Last modified: ' can have up to 10 characters before (they are retained).
""" Restores cursor and window position using save_cursor variable.
"" TODO: manipulate lang: lan tim en_US.UTF-8
function! LastModified()
  if &modified
    let save_cursor = getpos(".")
    let n = min([20, line("$")])
    keepjumps exe '1,' . n . 's#^\(.\{,10}Last modified: \).*#\1' .
          \ strftime('%a %b %d, %Y  %I:%M%p') . '#e'
    call histdel('search', -1)
    call setpos('.', save_cursor)
  endif
endfun

"" Print buffer to PDF and postscript
function! PrintPdf()
    exe ':set path=.'
    let utfil=expand("%:t:r") . '.ps'
    echo "printing current file to PDF"
    exe 'set popt=header:0'
    exe ':hardcopy > ' . utfil
    exe ':!ps2pdf ' . utfil 
endfunction

"" Print buffer to postscript
function! PrintPs()
    exe ':set path=.'
    let utfil=expand("%:t:r") . '.ps'
    echo "printing current file to ps"
    exe 'set popt=header:0'
    exe ':hardcopy > ' . utfil
endfunction

"" Count the number of '>' in file
function! GetNtax()
    let ntax=0
    g/^/let ntax+=strlen(substitute(getline('.'), '[^>]', '', 'g'))
    return ntax
endfunction

"" Count the number of '>' in file
function! GetNtax2()
    let ntax=0
    g/^/let ntax+=strlen(substitute(getline('.'), '[^>]', '', 'g'))
    redraw
    echomsg "Number of sequences: " ntax
endfunction

"" Remove gaps in Fasta
function! DegapFasta()
    exe ':g!/^>/s/-//g'
    exe ':g/^\s*$/d'
    exe ':normal gg'
endfunction

"" Convert interleaved FASTA to non-interleaved FASTA
"" WARNING: does not work well on large (long sequences) files!
"function! Fasta2NonInterLeavedFasta()
"    exe ':g/^>/s/\(^>.*\)/\1@/'
"    exe ':%s/\n//' 
"    exe ':s/@/\r/g'
"    exe ':g!/^>/s/>/\r>/g'
"    echo ''
"endfunction
function! Fasta2NonInterLeavedFasta()
    exe ':%g/^>/s/\(^>.*\)/\1@/'
    exe ':%g!/^>/-1join' 
    exe ':%s/@/\r/g'
    exe ':%g!/^>/s/ //g'
    echo ''
endfunction

"" Count the sequence length from FASTA file
"function! GetNchar()
"    let nchar=0
"    "...
"    return nchar
"endfunction

"" Count the length of longest line in file (not counting white space)
function! GetMaxLineLength()
    let maxLength=0
    let start=line("1")
    let end=line("$")
    while (start <= end)
        let lineLength=strlen(substitute(getline(start), '\s', '', ''))
        if (lineLength > maxLength)
            let maxLength=lineLength
        endif
        let start = start + 1
    endwhile
    "echo "max line length: " maxLength
    return maxLength
endfunction

"" FASTA interleaved to Phyml transformer.
function! Fasta2Phyml()
    let ntax=GetNtax()
    exe ':normal gg'
    exe ':s/>/\r>/'
    exe ':%s/\(^>.\+\)$/\1<skojj/'
    exe ':%s/\n//g'
    exe ':%s/>/\r/g'
    exe ':%s/<skojj/<skojj\r/'
    let nchar=GetMaxLineLength()
    exe ':%s/<skojj\n/\t/'
    exe ':normal gg'
    exe ':%Align'
    exe ':normal gg'
    exe "normal i" ntax nchar "\<Esc>"
    "echo "Ntax: " ntax "Nchar: " nchar 
endfunction

""  RandSeq: generate random (P(A)=P(C)=P(G)=P(T)=0.25) DNA sequence
""  Source: http://www.drchip.org/astronaut/vim
""  Basically using Dr Chip's PassWGen (http://www.drchip.org/astronaut/vim) with
""     call PassWGen(len,"ACGT")
fun! RandSeq(len)
    let symbols = "ACGT"
    let symlen = strlen(symbols)
    let pw     = ""
    let i      = 0
    while i < a:len
        let pw = pw.(symbols[Dice(1,symlen)-1])
        let i  = i + 1
    endwhile
    "let fasta = ">" . "\n" . pw
    "return fasta
    return pw
endfun

"fun! RandSeq(len,symbols)
"  "let symbols = "ACGT"
"  let symlen = strlen(a:symbols)
"  let pw     = ""
"  let i      = 0
"  while i < a:len
"   let pw = pw.(a:symbols[Dice(1,symlen)-1])
"   let i  = i + 1
"  endwhile
"  return pw
"endfun

"" Randomization Variables: {{{1
"" with a little extra randomized start from localtime()
let g:rndm_m1 = 32007779 + (localtime()%100 - 50)
let g:rndm_m2 = 23717810 + (localtime()/86400)%100
let g:rndm_m3 = 52636370 + (localtime()/3600)%100

"" Rndm: generate pseudo-random variate on [0,100000000)
"" Source: http://www.drchip.org/astronaut/vim
fun! Rndm()
    let m4= g:rndm_m1 + g:rndm_m2 + g:rndm_m3
    if( g:rndm_m2 < 50000000 )
        let m4= m4 + 1357
    endif
    if( m4 >= 100000000 )
        let m4= m4 - 100000000
        if( m4 >= 100000000 )
            let m4= m4 - 100000000
        endif
    endif
    let g:rndm_m1 = g:rndm_m2
    let g:rndm_m2 = g:rndm_m3
    let g:rndm_m3 = m4
    return g:rndm_m3
endfun

"" Urndm: generate uniformly-distributed pseudo-random variate on [a,b]
"" Source: http://www.drchip.org/astronaut/vim
fun! Urndm(a,b)
    " sanity checks
    if a:b < a:a
        return 0
    endif
    if a:b == a:a
        return a:a
    endif
    " Using modulus: rnd%(b-a+1) + a  loses high-bit information
    " and makes for a poor random variate.  Following code uses
    " rejection technique to adjust maximum interval range to
    " a multiple of (b-a+1)
    let amb       = a:b - a:a + 1
    let maxintrvl = 100000000 - ( 100000000 % amb)
    let isz       = maxintrvl / amb
    let rnd= Rndm()
    while rnd > maxintrvl
        let rnd= Rndm()
    endw
    return a:a + rnd/isz
endfun

"" Dice: assumes one is rolling a qty of dice with "sides" sides.
""       Example - to roll 5 four-sided dice, call Dice(5,4)
"" Source: http://www.drchip.org/astronaut/vim
fun! Dice(qty,sides)
    let roll= 0
    let sum= 0
    while roll < a:qty
        let sum = sum + Urndm(1,a:sides)
        let roll= roll + 1
    endw
    return sum
endfun

"" Insert random sequence using external Perl-script
"function! RandSeq(len)
"    let LENGTH = a:len
"    exe ':r!/home/nylander/bin/getrandomsequence.pl' . ' ' . LENGTH
"endfunction
"command! -nargs=1 Randseq : call RandSeq(<args>)

"" Call ToggleSketch while disabling the autofolding
function MySketch()
"    set foldenable!
    call ToggleSketch()
endfunction

"" A function to save word under cursor to a file
function! SaveWord()
   normal yiw
   exe ':!echo '.@0.' >> word_from_vim.txt'
endfunction

"" Count letters in the word under the cursor
function LC()
  normal yiW
  echo strlen(@") . " characters in word"
endfunction

"" Print the position in word under cursor 
function PC()
  normal yiB
  echo strlen(@") . " position in word"
endfunction

"" Count letters in the line under the cursor, v.2
function LC2()
  let string_length = strlen(substitute(getline("."), ".*", "&", "g"))
  echo string_length . " characters in line"
endfunction

"" Count words in the line under the cursor, v.3
"function LC3()
"  let string_length = strlen(substitute(getline("."), ".*", "&", "g"))
"  echo string_length . " words in line"
"endfunction

"" Count A, C, G, and T's on a line
"" This function counts the AT and GC on the WHOLE line (and only one line)
"" It reports the AT/GC contents and the calculated Tm based on 4*GC+2*AT
"" Alexandru Tudor Constantinescu, 12/14/2004 
function! Count_bases() 
   let l:string_length = strlen(substitute(getline("."), ".*", "&", "g"))
   let l:a = l:string_length - strlen(substitute(getline("."), "\\c[a]", "", "g"))
   let l:c = l:string_length - strlen(substitute(getline("."), "\\c[c]", "", "g"))
   let l:g = l:string_length - strlen(substitute(getline("."), "\\c[g]", "", "g"))
   let l:t = l:string_length - strlen(substitute(getline("."), "\\c[t]", "", "g"))
   let l:gap = l:string_length - strlen(substitute(getline("."), "\\c[-]", "", "g"))
   let l:other = l:string_length - l:a - l:c - l:g - l:t - l:gap
   echo "Length=" . l:string_length " (" "A=" . l:a "C=" . l:c "G=" . l:g "T=" . l:t "-=" . l:gap "other=" . l:other ")"
endfunction

" Get the reverse-complement of a certain DNA sequence
" Alexandru Tudor Constantinescu,  02/14/2005
" you have to select a block of text in advance
" the script is crude, in that it assumes you have only ATCG
" capitalization does not get screwed up
" at this moment 12/07/2004, the whole LINE (i.e. not only part of line) gets
" changed, irrespective of what you select.
" Tim Chase and William Nater 12/12/2004 
" since ignorecase gives problems (i.e. capitalization is lost)
" The replacement should be done by selecting a block of text (beware that the
" WHOLE line will get changed!!) and then issuing the commmand:
" :RC
fun! Rev(result)
   let l:i = strlen(a:result) - 1
   let l:result = ''
   while (l:i > -1)
	  let l:result = l:result.a:result[l:i]
	  let l:i = l:i - 1
   endwhile
   return l:result
endfun 

function! RC_Tim(l1, l2)
   let l:str = getline(a:l1)
   let l:len = strlen(l:str)
   let l:ignorecs = &l:ic
   let &l:ic = 0
   exe a:l1.",".a:l2."j!"
   exe a:l1."s/.*/\\=Rev(submatch(0))/"
   exe a:l1."s/\\c[agct]/\\=\"ATGCatgc\"[match(\"TACGtacg\", submatch(0))]/ge"
   "exe a:l1."s/.\\{".&tw."\\}\\zs/\\r/g"
   exe a:l1."s/.\\{".&tw."\\}\\zs//g"
   let &l:ic = l:ignorecs
endfunction

"" Show seq position. Assumes this format: Seqlabel ACGT
function! ShowSeqPos()
    let mycolumn = col(".")
    let [lnum, seqstart] = searchpos('\s', 'bcn')
    let seqpos = mycolumn - seqstart
    if seqpos < 1 
        let seqpos = ''  
    endif
    return seqpos
endfunction

"" Show sequence label. Beta 01/17/2013 09:45:18 PM
function! ShowSeqLabel()
    let seqlabel = substitute(getline("."), '\s*\(\S\+\)\s\+.*', '\1', '')
    return seqlabel
endfunction

"" C-Comment/uncomment function modified from vim.org/tips
function! CComment()
    if getline(".") =~ '\/\*'
        let hls=@/
        s/^\/\*//
        s/*\/$//
        let @/=hls
    else
        let hls=@/
        s/^/\/*/
        s/$/*\//
        let @/=hls
    endif
endfunction

"" Nexus-Comment/uncomment 
"" Works on line-by-line basis only
function! NexusComment()
    if getline(".") =~ '['
        let hls=@/
        s/^\(\s*\)\[/\1/
        s/\(\s*\)\]$/\1/
        let @/=hls
    else
        let hls=@/
        s/^/[/
        s/$/]/
        let @/=hls
    endif
endfunction

"" Perl-Comment/uncomment 
function! PerlComment()
    if getline(".") =~ '^\s*#'
        let hls=@/
        s/^\(\s*\)#/\1/
        let @/=hls
    else
        let hls=@/
        s/^/#/
        let @/=hls
    endif
endfunction

"" LaTeX-Comment/uncomment 
function! LaTeXComment()
    if getline(".") =~ '%'
        let hls=@/
        s/^%//
        let @/=hls
    else
        let hls=@/
        s/^/%/
        let @/=hls
    endif
endfunction

"" Vertical copy
"" Author: Vijayandra Singh <vijayandra@netzero.com>
"" Modified: 2006 Dec 24
"" License: Public Domain
"" Version: 1.02
func Stuff(str,justif,fillchar,len)
    let out = a:str
    let intendedlen  = a:len
    let left_or_right = a:justif
    let fillch=a:fillchar

    while intendedlen > strlen(out)
        if left_or_right > 0 
            let out = out . fillch
        else
            let out = fillch . out
        endif
    endwhile
    return out
endfunc

function! ColCopy()
    "let start=line(".") " From current line
    let start=line(".")
    let end=line("$")
    let longtestlen=0
    while (start <= end)
        let len = strlen(getline(start))
        if(len > longtestlen)
            let longtestlen=len
        endif
        let start = start + 1
    endwhile
    let beautymargin=longtestlen+1
    let start=line(".")
    while (start <= end)
        let str = getline(start)
        let src_op1=getline(start)
        let src_op2=getline(start)
        "let len=strlen(x)
        let src_op1=Stuff(src_op1,1," ",beautymargin)
        let result_string=(src_op1 . ' ' . src_op2)
        call setline(start,result_string)
        let start = start + 1
    endwhile
endfunction

"" Search for visually selected text
"" Basically you press * or # to search for the current selection
"" From an idea by Michael Naumann
"" Not working at the moment 04/18/2007 11:22:39 AM CEST
"function! VisualSearch(direction) range
"  let l:saved_reg = @"
"  execute "normal! vgvy"
"  let l:pattern = escape(@", '\\/.*$^~[]')
"  let l:pattern = substitute(l:pattern, "\n$", "", "")
"  if a:direction == 'b'
"    execute "normal ?" . l:pattern . "^M"
"  else
"    execute "normal /" . l:pattern . "^M"
"  endif
"  let @/ = l:pattern
"  let @" = l:saved_reg
"endfunction

"" Align columns based on white space by visually select a text, and then
"" :Align<CR> or press '\a'
function! AlignSection(regex) range
    let extra = 1
    let sep = empty(a:regex) ? '\s\+' : a:regex
    let maxpos = 0
    let section = getline(a:firstline, a:lastline)
    for line in section
        let pos = match(line, ' *'.sep)
        if maxpos < pos
            let maxpos = pos
        endif
    endfor
    call map(section, 'AlignLine(v:val, sep, maxpos, extra)')
    call setline(a:firstline, section)
endfunction

function! AlignLine(line, sep, maxpos, extra)
    let m = matchlist(a:line, '\(.\{-}\) \{-}\('.a:sep.'.*\)')
    if empty(m)
        return a:line
    endif
    let spaces = repeat(' ', a:maxpos - strlen(m[1]) + a:extra)
    return m[1] . spaces . m[2]
endfunction

" Highlight a column in csv text.
" :Csv 1    " highlight first column
" :Csv 12   " highlight twelfth column
" :Csv 0    " switch off highlight
function! CSVH(colnr)
    if a:colnr > 1
        let n = a:colnr - 1
        execute 'match Keyword /^\([^,]*,\)\{'.n.'}\zs[^,]*/'
        execute 'normal! 0'.n.'f,'
    elseif a:colnr == 1
        match Keyword /^[^,]*/
        normal! 0
    else
        match
    endif
endfunction

"" Function to read Man page
"" Source -- Edited by JN from http://vim.wikia.com/wiki/
""           Open_a_window_with_the_man_page_for_the_word_under_the_cursor
function! ReadMan(man_word)
    exe ':tabnew'
    exe ':r!man ' . a:man_word . ' | col -b'
    exe ':goto'
    exe ':delete'
    exe ':set filetype=man'
endfunction

"" Change case
""http://vim.wikia.com/wiki/Switching_case_of_characters
function! TwiddleCase(str)
    if a:str ==# toupper(a:str)
        let result = tolower(a:str)
    elseif a:str ==# tolower(a:str)
        let result = substitute(a:str,'\(\<\w\+\>\)', '\u\1', 'g')
    else
        let result = toupper(a:str)
    endif
    return result
endfunction

"" Display indentation guides
"" http://stackoverflow.com/questions/2158305/is-it-possible-to-display-indentation-guides-in-vim
"function! ToggleIndentGuides()
"    if exists('b:indent_guides')
"        call matchdelete(b:indent_guides)
"        unlet b:indent_guides
"    else
"        let pos = range(1, &l:textwidth, &l:shiftwidth)
"        call map(pos, '"\\%" . v:val . "v"')
"        let pat = '\%(\_^\s*\)\@<=\%(' . join(pos, '\|') . '\)\s'
"        let b:indent_guides = matchadd('CursorLine', pat)
"    endif
"endfunction

"" Yank word under cursor and put into a Perl-debug print statement
function! Gettt()
    let l:wordUnderCursor = expand("<cWORD>")
    let s:apa = substitute(l:wordUnderCursor, '[\$\%\@]', "", "g")
    let l:cmd = "print Dumper(" . l:wordUnderCursor . ");warn \"\\n" . s:apa . " (hit return to continue)\\n\" and getc();"
    exe "normal o" l:cmd "\<Esc>"
endfunction


""===========================================================================
"" COMMANDS
""===========================================================================

" Highlight a column in csv text.
command! -nargs=1 Csv :call CSVH(<args>)

"" Align columns based on white space
command! -nargs=? -range Align <line1>,<line2>call AlignSection('<args>')

" Get the reverse-complement of a certain DNA sequence
command! -n=* -range RC :call RC_Tim(<line1>,<line2>)

"" Randseq
command! -nargs=1 Randseq : call setline(line('.'), getline(line('.')) . RandSeq(<args>))

"" Converts file format to/from unix
command Unix :set ff=unix
command Dos :set ff=dos
command Mac :set ff=mac

"" Convert interleaved FASTA to non-interleaved FASTA
"command! -nargs=0 Fasta2NonInterLeavedFasta :normal gg | :s/>/\r>/<CR> | :%s/\(^>.\+\)$/\1<skojj/<CR> | :%s/\n//g<CR> | :%s/>/\r>/g<CR> | :%s/<skojj/\r/<CR> | :normal ggdd<CR>
command! -nargs=0 UnWrapFasta : call Fasta2NonInterLeavedFasta()

"" Convert sequential PHYML file format to sequential FASTA file format. 2014/04/27 (JN): Will not work as is if no blank lines. Will also not work without the first g/^$/d if blank lines...
command! -nargs=0 Phyml2Fasta : g/^$/d<CR> | :normal ggdd | :%s/^/>/<CR>< | :%s/\s\+/\r/<CR><CR>

"" Convert FASTA (interleaved) file format to  PHYML (sequential) file format
command! -nargs=0 Fasta2Phyml2 :normal gg | :s/>/\r>/<CR> | :%s/\(^>.\+\)$/\1<skojj/<CR> | :%s/\n//g<CR> | :%s/>/\r/g<CR> | :%s/<skojj/\t/<CR> | :normal gg<CR>

"" Convert FASTA (non-interleaved) file format to FASTA (interleaved) file format
command! -nargs=0 WrapFasta :normal gg | :g!/^>/s/.\{70}/&\r/g<CR> | :normal gg<CR>

"" Convert sequential FASTA file format to sequential PHYML file format
command! -nargs=0 Fasta2Phyml3 :normal gg | :%s/^/>/<CR> | :%s/\s\+/\r/<CR>

"" FASTA to NEXUS using external program
command! -nargs=0 Fas2Nex :%! fas2nex.stdinout %<CR>

"" FASTA to TAB delimited
command! -nargs=0 Fasta2Tab :normal gg | :%s/^>\(.*\)/>\1\t/<CR> | :%s/\n//<CR> | :%s/>/\r/g<CR> | :g/^$/d<CR>

"" TAB to FASTA
command! -nargs=0 Tab2Fasta :normal gg | :%s/^\(.*\)\t\(.*\)/>\1\r\2/<CR>

"" Print current buffer to postscript and pdf file
command! -nargs=0 Pdf : call PrintPdf()
command! -nargs=0 Ps : call PrintPs()


""===========================================================================
"" FILE TYPES
""===========================================================================

"" For vim-templates
"" Do not use template by default. Load manually instead by, e.g., :Template *.tex
let g:templates_no_autocmd = 0 " to enable automatic insertion of template on buffer creation, set to 0
"" User data for vim-templates
let g:email = 'johan.nylander\@nrm.se'
"let g:username = 'Johan Nylander'
let g:templates_user_variables = [
    \ ['COMPANY', 'GetCompany'],
    \ ['FUSER', 'GetFullUser'],
    \ ]

"" For markdown README.md
"" I use a specific file for REAMDE.md: .vim/bundle/vim-template/templates/'=template=README.md'
"" For markdown preview in browser, set below to 1, or use :InstantMarkdownPreview
let g:instant_markdown_autostart = 0

"" For LyX
autocmd BufRead *.lyx set syntax=lyx foldmethod=syntax foldcolumn=3
autocmd BufRead *.lyx syntax sync fromstart

"" Check Perl syntax with :make
autocmd FileType perl set makeprg=perl\ -cW\ %\ $*
autocmd FileType perl set errorformat=%f:%l:%m
autocmd FileType perl set autowrite

"" For Taglist
let Tlist_Exist_OnlyWindow = 1 " if you are the last, kill yourself
let Tlist_Use_Right_Window = 1 " split to the right side of the screen

"" Read PDF files in vim
autocmd BufReadPre *.pdf set ro
autocmd BufReadPost *.pdf %!pdftotext -nopgbrk "%" - 

"" Allow editing of compressed files
"" http://www.ashberg.de/vim/vimrc.html
if v:version >= 600
    filetype on
    filetype indent on
else
    filetype on
endif
if has("autocmd")
    " try to auto-examine filetype
    if v:version >= 600
        filetype plugin indent on
    endif
    " try to restore last known cursor position
    autocmd BufReadPost * if line("'\"") | exe "normal '\"" | endif
    " autoread gzip-files
    augroup gzip
    " Remove all gzip autocommands
    au!
    " Enable editing of gzipped files
    " set binary mode before reading the file
    autocmd BufReadPre,FileReadPre      *.gz,*.bz2 set bin
    autocmd BufReadPost,FileReadPost    *.gz call GZIP_read("gunzip")
    autocmd BufReadPost,FileReadPost    *.bz2 call GZIP_read("bunzip2")
    autocmd BufWritePost,FileWritePost  *.gz call GZIP_write("gzip")
    autocmd BufWritePost,FileWritePost  *.bz2 call GZIP_write("bzip2")
    autocmd FileAppendPre               *.gz call GZIP_appre("gunzip")
    autocmd FileAppendPre               *.bz2 call GZIP_appre("bunzip2")
    autocmd FileAppendPost              *.gz call GZIP_write("gzip")
    autocmd FileAppendPost              *.bz2 call GZIP_write("bzip2")
    " After reading compressed file: Uncompress text in buffer with "cmd"
    fun! GZIP_read(cmd)
        let ch_save = &ch
        set ch=2
        execute "'[,']!" . a:cmd
        set nobin
        let &ch = ch_save
        execute ":doautocmd BufReadPost " . expand("%:r")
    endfun
    " After writing compressed file: Compress written file with "cmd"
    fun! GZIP_write(cmd)
        !mv <afile> <afile>:r
        execute "!" . a:cmd . " <afile>:r"
    endfun
    " Before appending to compressed file: Uncompress file with "cmd"
    fun! GZIP_appre(cmd)
        execute "!" . a:cmd . " <afile>"
        !mv <afile>:r <afile>
    endfun
    augroup END " gzip
endif

"" Automatically update the 'Last modified:' date on write buffert.
autocmd BufWritePre * call LastModified()


""===========================================================================
"" MAPPINGS
""===========================================================================

"" Set mark in Perl
iab gett warn "\n HERE (hit return to continue)\n" and getc();
iab gettt print Dumper();warn "\n  (hit return to continue)\n" and getc();
map <F2> :call Gettt()<CR>

"" Map M to get rid of ^M's
map M :%s//\r/g

"" Add or remove Perl beginning of line comments
" map _c :s/^/# /<CR>
" map _u :s/^# //<CR>

"" Remap the help F1 key:
"" The original function of <F1> can be obtained with <F1><Enter>
"nnoremap <F1> :help<Space>
"Johans re-map:
nnoremap <F1> :call MyHelp()<CR>
vmap <F1> <C-C><F1>
omap <F1> <C-C><F1>
map! <F1> <C-C><F1>

"" Map F4 to TagList on/off 
nnoremap <silent> <F4> :TlistToggle<CR>

"" Map the F12 key to Sketch on/off
"map <F12> :call ToggleSketch()<CR>
map <F12> :call MySketch()<CR>

"" Map CTRL-s to SAVE in normal, visual, and insert mode
nmap <C-S> <Esc>:w<CR>
vmap <C-S> <Esc>:w<CR>v
imap <C-S> <Esc>:w<CR>i

"" Map CTRL-d to insert time stamp.
"" TODO: force English day names:
"" LC_ALL=en_US date
"" lan tim en_US.UTF-8
"" LC_TIME=en_US.UTF-8 date
:nnoremap <C-d> exe ':lan tim en_US.UTF-8'; "=strftime("%c")<CR>P
:inoremap <C-d> <C-R>=strftime("%c")<CR>

"" Search for occurence of selected text by pressing '/' in visual mode
"" See function below for an alternative using forward and backward search
vmap / y/<C-R>"<CR> 

"" A function to save word under cursor to a file
" map ,p :call SaveWord()

"" Count letters in the word under the cursor
map zz :call LC()<CR>

"" Print the position in word under cursor 
"map zz:call PC()<CR>

"" Count letters in the line under the cursor, v.2
map zx :call LC2()<CR>

"" Count words in the line under the cursor, v.3
"map ZX :call LC3()<CR>

"" Count A, C, G, and T's on a line
map ZZ :call Count_bases()<CR>

"" C-Comment/uncomment function modified from vim.org/tips
map ö :call CComment()<CR>
map ,/ :call CComment()<CR>

"" Nexus-Comment/uncomment 
map å :call NexusComment()<CR>
map ,[ :call NexusComment()<CR>

"" Perl-Comment/uncomment 
map ä :call PerlComment()<CR>
map ,. :call PerlComment()<CR>

"" LaTeX-Comment/uncomment 
"map ' :call LaTeXComment()<CR>

"" VisualSearch
"vnoremap <silent> * :call VisualSearch('f')<CR>
"vnoremap <silent> # :call VisualSearch('b')<CR>

"" Align columns based on white space
vnoremap <silent> <Leader>a :Align<CR>

"" Change case
vnoremap ~ ygv"=TwiddleCase(@")<CR>Pgv

""===========================================================================
"" Add to Syntax Menu
""===========================================================================
"" Markown to PDF conversion using external wrapper to pandoc
menu Syntax.-Sep-       :
menu Syntax.Markdown\ to\ PDF :!md2pdf % <CR><CR>

""===========================================================================
"" PHYLO MENU (experimental)
""===========================================================================

"" Run Alignment programs
menu Phylo.Do\ Alignment.CLUSTALO.Protein\ or\ DNA :! clustalo --infile=% --outfile=ClUsTaLo.aln <CR>: tabe ClUsTaLo.aln<CR> : normal gg<CR>
menu Phylo.Do\ Alignment.CLUSTALO.-Sep-       :
menu Phylo.Do\ Alignment.CLUSTALO.Read\ CLUSTALO\ man\ page : call ReadMan('clustalo')<CR>
menu Phylo.Do\ Alignment.CLUSTALW.Protein :! clustalw -outorder=INPUT -output=GDE -case=UPPER -outfile=ClUsTaLw.aln -align -infile=%<CR>: tabe ClUsTaLw.aln<CR> :% s/%/>/<CR>: normal gg<CR>
menu Phylo.Do\ Alignment.CLUSTALW.DNA     :! clustalw -outorder=INPUT -output=GDE -case=UPPER -outfile=ClUsTaLw.aln -align -infile=%<CR>: tabe ClUsTaLw.aln<CR> :% s/#/>/<CR>: normal gg<CR>
menu Phylo.Do\ Alignment.CLUSTALW.-Sep-       :
menu Phylo.Do\ Alignment.CLUSTALW.Read\ CLUSTALW\ man\ page : call ReadMan('clustalw')<CR>
menu Phylo.Do\ Alignment.MUSCLE.Protein :! muscle -in % -out mUsClE.aln<CR>: tabe mUsClE.aln<CR> :normal gg<CR>
menu Phylo.Do\ Alignment.MUSCLE.-Sep-       :
menu Phylo.Do\ Alignment.MUSCLE.Read\ MUSCLE\ man\ page : call ReadMan('muscle')<CR>
menu Phylo.Do\ Alignment.MAFFT.mafft       :! mafft  % > MaFfT.mafft.ali<CR> : tabe  MaFfT.mafft.ali<CR><CR>
menu Phylo.Do\ Alignment.MAFFT.linsi       :! linsi  % > MaFfT.linsi.ali<CR> : tabe  MaFfT.linsi.ali<CR><CR>
menu Phylo.Do\ Alignment.MAFFT.ginsi       :! ginsi  % > MaFfT.ginsi.ali<CR> : tabe  MaFfT.ginsi.ali<CR><CR>
menu Phylo.Do\ Alignment.MAFFT.einsi       :! einsi  % > MaFfT.einsi.ali<CR> : tabe  MaFfT.einsi.ali<CR><CR>
menu Phylo.Do\ Alignment.MAFFT.fftnsi      :! fftnsi % > MaFfT.fftnsi.ali<CR>: tabe  MaFfT.fftnsi.ali<CR><CR>
menu Phylo.Do\ Alignment.MAFFT.fftns       :! fftns  % > MaFfT.fftns.ali<CR> : tabe  MaFfT.fftns.ali<CR><CR>
menu Phylo.Do\ Alignment.MAFFT.nwns        :! nwns   % > MaFfT.nwns.ali<CR>  : tabe  MaFfT.nwns.ali<CR><CR>
menu Phylo.Do\ Alignment.MAFFT.nwnsi       :! nwnsi  % > MaFfT.nwnsi.ali<CR> : tabe  MaFfT.nwnsi.ali<CR><CR>
menu Phylo.Do\ Alignment.MAFFT.-Sep-       :
menu Phylo.Do\ Alignment.MAFFT.Read\ MAFFT\ man\ page : call ReadMan('mafft')<CR>

"" Edit alignments
"menu Phylo.Edit.-Sep-	:
menu Phylo.Utilities.Get\ FASTA\ info                      : ! get_fasta_info %<CR>
menu Phylo.Utilities.Remove\ all\ gaps\ in\ FASTA          : call DegapFasta()<CR>
menu Phylo.Utilities.Align\ taxlabels\ (in\ phyml\ format) : Align<CR>
menu Phylo.Utilities.Count\ sequences\ (in\ FASTA\ format) : call GetNtax2()<CR>
menu Phylo.Utilities.Set\ filetype\ to\ DNA                : set ft=align<CR>
menu Phylo.Utilities.Set\ filetype\ to\ AA                 : set ft=aalign<CR>
menu Phylo.Utilities.Set\ filetype\ to\ Nexus              : set ft=nexus<CR>
menu Phylo.Utilities.Display\ Newick\ as\ ASCII            : ! nw_display -S  % > AsCiI.tRe<CR> : tabe AsCiI.tRe<CR><CR>

"" Format conversions
menu Phylo.Convert.Phyml\ to\ FASTA : Phyml2Fasta<CR>
menu Phylo.Convert.FASTA\ to\ Phyml : call Fasta2Phyml()<CR><CR>
menu Phylo.Convert.FASTA\ to\ Nexus : Fas2Nex<CR> : set ft=nexus<CR>
menu Phylo.Convert.FASTA\ to\ Tab   : Fasta2Tab<CR>
menu Phylo.Convert.Tab\ to\ FASTA   : Tab2Fasta<CR>
menu Phylo.Convert.Unwrap\ FASTA    : call Fasta2NonInterLeavedFasta()<CR><CR>
menu Phylo.Convert.Wrap\ FASTA      : WrapFasta<CR>

"" DNA
menu Phylo.DNA.RevComp                  : RC<CR>
menu Phylo.DNA.Insert\ Random\ DNA\ Seq : Randseq

"" Run programs
"" need to capture the output from fasttree in a new buffer instead of having
"" to hardcode the output name
menu Phylo.Run.Fasttree\ (DNA)         : ! fasttree -nt % > FaSt.tre<CR><CR>: tabe FaSt.tre<CR>
menu Phylo.Run.Fasttree\ (AA)          : ! fasttree  % > FaSt.tre<CR><CR>: tabe FaSt.tre<CR>
menu Phylo.Run.PAUP                    : ! paup %<CR>
menu Phylo.Run.MrBayes                 : ! mb -i %<CR>
"menu Phylo.Phylo.Run\ Phyml :
menu Phylo.Run.MrAIC\ (24\ nt\ models) : ! mraic.pl %<CR><CR>: tabe *.MrAIC.txt<CR>
menu Phylo.Run.MrAIC\ (56\ nt\ models) : ! mraic.pl -modeltest %<CR><CR>: tabe *.MrAIC.txt<CR>
menu Phylo.Run.pMrAIC\ (24\ nt\ models) : ! pmraic.pl --noverbose %<CR><CR>: tabe *.pMrAIC.txt<CR>
menu Phylo.Run.pMrAIC\ (56\ nt\ models) : ! pmraic.pl --noverbose --modeltest %<CR><CR>: tabe *.pMrAIC.txt<CR>


""===========================================================================
"" HELP
""===========================================================================
function MyHelp()

    echo "#For Perl-like regular expressions:"
    echo ":perlod s/search/replace/"
    echo " "

    echo "#Count occurrence of word:"
    echo ":%s/word//gn"
    echo "#or:"
    echo ": w !wc"
    echo " "

    echo "#Count printed words in TeX file (needs detex):"
    echo ":w !detex \| wc -w"
    echo " "

    echo "#For search and replace in visual selection"
    echo ":%s/\%Vsearch_pattern/replace_pattern/g"
    echo ":s/\%Vsearch_pattern/replace_pattern/g"
    echo ""

    echo "#CSV files (first, make sure filetype is set to csv)"
    echo "#Search for foo in column 3"
    echo ":SC 3=foo"
    echo "#Highlight column 3"
    echo ":Csv 3"
    echo "#Delete column 3"
    echo ":DC 3 "
    echo "#Change delimiter"
    echo ":Delimiter \t"
    echo " "

    echo "#For file type templates:"
    echo "TT <file>, TH <file>, TLS : "
    echo " "

    echo "#Show a list of all occurences of TEXT with line numbers"
    echo ":g/TEXT/#"
    echo " "

    echo "#Display all lines FRED but not FREDDY"
    echo ":g/\\<FRED\\>/"
    echo " "

    echo "#Delete all empty lines, or lines with only blanks"
    echo ":v/\\S/d"
    echo " "

    echo "#Duplicate every line"
    echo ":g/^/t."
    echo " "

    echo "#Delete every other line"
    echo ":%norm jdd"
    echo " "

    echo "#Add/subtract one from number under cursor"
    echo "CTRL+A/CTRL+X"
    echo

    echo "#For drawing functions:"
    echo ":call ToggleSketch()  or Press F12!"
    echo " "

    echo "#Insert TEXT after every line"
    echo "Ctrl+V j $ A TEXT ESC"
    echo " "

    echo "#Display relative line numbers in vim"
    echo ":set relativenumber"
    echo

    echo "#For insertion of random DNA sequence of length n:"
    echo ":call RandSeq(n)"
    echo " "

    echo "#For running an external cmd on the current file (e.g.):"
    echo ":! paup %"
    echo " "
    echo "#To insert result from external cmd (e.g.):"
    echo ":r!/home/nylander/bin/getrandomsequence.pl "
    echo " "

    echo "#For counting characters/words:"
    echo "zz, ZZ, zx"
    echo ":!wc -w < %"
    echo "#VISUAL mode (select area and): "
    echo "gCTRL+G "
    echo ":%s/search_for_this/&/gn "
    echo ":%s/\S/&/gn "
    echo " "

    echo "#For a IDE-like environment"
    echo ":Tlist   or press F4!"
    echo " "

    echo "#For commenting/uncommenting:"
    echo "å  or ä or ö or ' or "
    echo " "

    echo "#For write-completion: in insert mode, start typing then press"
    echo "Ctrl-n"
    echo " "

    echo "#For quick-save:"
    echo "Ctrl-s"
    echo " "

    echo "#For smart selection:"
    echo "Ctrl+v ab  Select \"a block\" from \"[(\" to \"])\", including braces"
    echo "Ctrl+v ib  Select \"inner block\" from \"[(\" to \"])\""
    echo "Ctrl+v aB  Select \"a block\" from \"[{\" to \"]}\", including brackets"
    echo "Ctrl+v iB  Select \"inner block\" from \"[{\" to \"]}\""
    echo " "

    echo "#For going to global/local definition of variables:"
    echo "gd   Go to Declaration of local variable under cursor."
    echo "gD   Go to Declaration of global variable under cursor."
    echo " "

    echo "#For folds:"
    echo "Use zo, zc, zM, zR to open/close"
    echo " "

    echo "#For a calendar"
    echo ":Calendar"
    echo " "

endfunction

