"" File: vimrc
""
"" Last modified: tor okt 30, 2025  06:16
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
""     GUI MENUS
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
"" (from github.com):
""
""    LargeFile.vim
""    copilot.vim
""    csv.vim
""    sketch.vim
""    taglist.vim
""    vim-game-code-break
""    vim-instant-markdown
""    vim-snakemake
""    vim-template
""    vimwiki
""
"" Install using Vim's own package manager system:
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
"" NOTE: In addition to the standard packages above, some of the functions
"" and commands in this file calls external software. Both home made(!) and
"" avalilable from, e.g. debian/ubuntu apt sources.
"" Current list with sources:
""  - clustalo: sudo apt install clustalo
""  - clustalw: sudo apt install clustalw
""  - fasttree: sudo apt install fasttree
""  - mafft: sudo apt install mafft
""  - man: sudo apt install man-db
""  - mb: sudo apt install mrbayes
""  - muscle3: sudo apt install muscle3
""  - pdftotext: sudo apt install poppler-utils
""  - ps2pdf: sudo apt install ghostscript
""
""  - fas2nex.stdinout: https://gist.github.com/nylander/3e197cb3c683419965b84d327a5217d1
""  - get_fasta_info: https://github.com/nylander/get_fasta_info
""  - md2beamer: https://github.com/nylander/md2pdf
""  - md2pdf: https://github.com/nylander/md2pdf
""  - mraic.pl: https://github.com/nylander/mraic
""  - nw_display: https://github.com/tjunier/newick_utils
""  - paup: https://phylosolutions.com/paup-test
""  - pmraic.pl: https://github.com/nylander/pmraic
""


""===========================================================================
"" DEFAULTS
""===========================================================================

filetype plugin indent on                                     " Enable plugins for filetype
syntax on                                                     " Enable syntax
"set textwidth=100                                            " Maximum width of text that is being inserted (line will be broken).
set wrap!                                                     " Do not soft wrap buffer.
set nu                                                        " Note: no numbers ('set nu!') when teaching.
set shiftwidth=4                                              " Indent 4 spaces
set shiftround                                                " Round indent to multiple of 'shiftwidth'
set tabstop=4                                                 " Tab is 4 spaces
set expandtab                                                 " Replace tabs with spaces,
set autoindent                                                " Reuse indent on current line
set list listchars=tab:❘-,trail:·,extends:»,precedes:«,nbsp:× " Display indentation guides
set matchpairs+=<:>                                           " Add <> as match pairs (default "(:),{:},[:]")
set nocompatible                                              " For vimwiki
set ruler                                                     " Show the line and column number of the cursor position.
set backspace=indent,eol,start                                " Backspace behavior.
set foldmethod=indent                                         " Enable folding on indentation. Use zo, zc, zM, zR to open/close.
set foldminlines=0                                            " Fold also single lines.
set foldenable!                                               " Fold by default.
"set viminfo='10,\"100,:20,%,n~/.viminfo
"set cursorline cursorcolumn                                  " Highlight current line/column
let &t_SI = "\<Esc>[6 q"                                      " Cursor settings, t_SI insert, t_EI normal, t_SR replace
let &t_SR = "\<Esc>[4 q"                                      " 1 = blinking block,        2 = steady block
let &t_EI = "\<Esc>[2 q"                                      " 3 = blinking underline,    4 = steady underline
                                                              " 5 = blinking vertical bar, 6 = steady vertical bar

let g:copilot_enabled = v:false                               " Disable copilot by default. Enable by :Copilot enable
let g:instant_markdown_autostart = 0                          " Disable instant_markdown by default

"" Manipulate status line to show seq position.
"" TODO: This is work in progress.
"set statusline=[%l,%c].\ Seqpos:%{ShowSeqPos()}
"set statusline+=\ Seqpos:%{ShowSeqPos()}%=[%l,%c]
"set statusline+=\Seq\ pos:\ %{ShowSeqPos()}\ [%{ShowSeqLabel()}]%=[%l,%c]
"set laststatus=2


""===========================================================================
"" GUI SETTINGS
""===========================================================================

set guifont=DejaVu\ Sans\ Mono\ 9                  " On desktop.
"set guifont=DejaVu\ Sans\ Mono\ 20                 " For teaching.
"set guifont=Monospace\ 20                          " For teaching.
"set guifont=Monospace\ 11                          " On awesome laptop.

set guioptions+=b                                   " GUI bottom scrollbar
set guioptions-=T                                   " No toolbar in GUI

"" Set default size for GUI window
if has("gui_running")
    "" GUI is running or is about to start.
    "" Maximize gvim window.
    set lines=40 columns=140
else
    "" This is console Vim.
    if exists("+lines")
        set lines=30
    endif
    if exists("+columns")
        set columns=100
    endif
endif


""===========================================================================
"" FUNCTIONS
""===========================================================================

function! GetCompany()
    "" For vim-templates
    "" TODO: use global variable for company
    return 'NRM'
endfunction

function! GetFullUser()
    "" For vim-templates
    "" TODO: use global variable for user
    return 'Johan Nylander'
endfunction

function! LastModified()
    "" Automatically update the 'Last modified:' date on write buffert.
    "" http://vim.wikia.com/wiki/Insert_current_date_or_time
    """ If buffer modified, update any 'Last modified: ' in the first 20 lines.
    """ 'Last modified: ' can have up to 10 characters before (they are retained).
    """ Restores cursor and window position using save_cursor variable.
    """ TODO: Use my InsertEnglishTimestamp() function
    if &modified
        let save_cursor = getpos(".")
        let n = min([20, line("$")])
        keepjumps exe '1,' . n . 's#^\(.\{,10}Last modified: \).*#\1' .
          \ strftime('%a %b %d, %Y  %I:%M%p') . '#e'
        call histdel('search', -1)
        call setpos('.', save_cursor)
    endif
endfun

function! PrintPdf()
    "" Print buffer to PDF and postscript
    exe ':set path=.'
    let utfil=expand("%:t:r") . '.ps'
    echo "printing current file to PDF"
    exe 'set popt=header:0'
    exe ':hardcopy > ' . utfil
    exe ':!ps2pdf ' . utfil
endfunction

function! PrintPs()
    "" Print buffer to postscript
    exe ':set path=.'
    let utfil=expand("%:t:r") . '.ps'
    echo "printing current file to ps"
    exe 'set popt=header:0'
    exe ':hardcopy > ' . utfil
endfunction

function! GetNtax()
    "" Count the number of '>' in file
    let ntax=0
    g/^/let ntax+=strlen(substitute(getline('.'), '[^>]', '', 'g'))
    return ntax
endfunction

function! GetNtax2()
    "" Count the number of '>' in file
    let ntax=0
    g/^/let ntax+=strlen(substitute(getline('.'), '[^>]', '', 'g'))
    redraw
    echomsg "Number of sequences: " ntax
endfunction

function! DegapFasta()
    "" Remove gaps in Fasta
    exe ':g!/^>/s/-//g'
    exe ':g/^\s*$/d'
    exe ':normal gg'
endfunction

function! Fasta2NonInterLeavedFasta()
    "" Convert interleaved FASTA to non-interleaved FASTA
    exe ':%g/^>/s/\(^>.*\)/\1@/'
    exe ':%g!/^>/-1join'
    exe ':%s/@/\r/g'
    exe ':%g!/^>/s/ //g'
    echo ''
endfunction

function! GetMaxLineLength()
    "" Count the length of longest line in file (not counting white space)
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

function! Fasta2Phyml()
    "" FASTA interleaved to Phyml transformer
    "" Uing functions GetNtax and GetMaxLineLength
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

function! RandSeq(len)
    "" RandSeq: generate random (P(A)=P(C)=P(G)=P(T)=0.25) DNA sequence
    "" Using function Dice()
    "" Source: http://www.drchip.org/astronaut/vim
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
endfunction

"function! RandSeq(len,symbols)
"    let symbols = "ACGT"
"    let symlen = strlen(a:symbols)
"    let pw     = ""
"    let i      = 0
"    while i < a:len
"        let pw = pw.(a:symbols[Dice(1,symlen)-1])
"        let i  = i + 1
"    endwhile
"    return pw
"endfunction

"" Randomization Variables: {{{1
"" with a little extra randomized start from localtime()
let g:rndm_m1 = 32007779 + (localtime()%100 - 50)
let g:rndm_m2 = 23717810 + (localtime()/86400)%100
let g:rndm_m3 = 52636370 + (localtime()/3600)%100

function! Rndm()
    "" Rndm: generate pseudo-random variate on [0,100000000)
    "" Source: http://www.drchip.org/astronaut/vim
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
endfunction

function! Urndm(a,b)
    "" Urndm: generate uniformly-distributed pseudo-random variate on [a,b]
    "" Using function Rndm
    "" Source: http://www.drchip.org/astronaut/vim
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
endfunction

function! Dice(qty,sides)
    "" Dice: assumes one is rolling a qty of dice with "sides" sides.
    ""       Example - to roll 5 four-sided dice, call Dice(5,4)
    "" Uses function Urndm
    "" Source: http://www.drchip.org/astronaut/vim
    let roll= 0
    let sum= 0
    while roll < a:qty
        let sum = sum + Urndm(1,a:sides)
        let roll= roll + 1
    endw
    return sum
endfunction

function MySketch()
    "" Call ToggleSketch while disabling the autofolding
    "set foldenable!
    call ToggleSketch()
endfunction

function! SaveWord()
    "" A function to save word under cursor to a file
   normal yiw
   exe ':!echo '.@0.' >> word_from_vim.txt'
endfunction

function LC()
    "" Count letters in the word under the cursor
    normal yiW
    echo strlen(@") . " characters in word"
endfunction

function PC()
    "" Print the position in word under cursor
    normal yiB
    echo strlen(@") . " position in word"
endfunction

function LC2()
    "" Count letters in the line under the cursor, v.2
    let string_length = strlen(substitute(getline("."), ".*", "&", "g"))
    echo string_length . " characters in line"
endfunction

"function LC3()
"    "" Count words in the line under the cursor, v.3
"    let string_length = strlen(substitute(getline("."), ".*", "&", "g"))
"    echo string_length . " words in line"
"endfunction

function! Count_bases()
    "" Count A, C, G, and T's on a line
    "" This function counts the AT and GC on the WHOLE line (and only one line)
    "" It reports the AT/GC contents and the calculated Tm based on 4*GC+2*AT
    "" Alexandru Tudor Constantinescu, 12/14/2004
    let l:string_length = strlen(substitute(getline("."), ".*", "&", "g"))
    let l:a = l:string_length - strlen(substitute(getline("."), "\\c[a]", "", "g"))
    let l:c = l:string_length - strlen(substitute(getline("."), "\\c[c]", "", "g"))
    let l:g = l:string_length - strlen(substitute(getline("."), "\\c[g]", "", "g"))
    let l:t = l:string_length - strlen(substitute(getline("."), "\\c[t]", "", "g"))
    let l:gap = l:string_length - strlen(substitute(getline("."), "\\c[-]", "", "g"))
    let l:other = l:string_length - l:a - l:c - l:g - l:t - l:gap
    echo "Length=" . l:string_length " (" "A=" . l:a "C=" . l:c "G=" . l:g "T=" . l:t "-=" . l:gap "other=" . l:other ")"
endfunction

function! Rev(result)
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
    let l:i = strlen(a:result) - 1
    let l:result = ''
    while (l:i > -1)
        let l:result = l:result.a:result[l:i]
        let l:i = l:i - 1
    endwhile
    return l:result
endfunction

function! RC_Tim(l1, l2)
    " Get the reverse-complement of current  line (DNA sequence)
    " using the Rev() function
    " Alexandru Tudor Constantinescu,  02/14/2005
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

"function! ShowSeqPos()
"    "" Show seq position. Assumes this format: Seqlabel ACGT
"    let mycolumn = col(".")
"    let [lnum, seqstart] = searchpos('\s', 'bcn')
"    let seqpos = mycolumn - seqstart
"    if seqpos < 1
"        let seqpos = ''
"    endif
"    return seqpos
"endfunction
"
"function! ShowSeqLabel()
"    "" Show sequence label. Beta 01/17/2013 09:45:18 PM
"    let seqlabel = substitute(getline("."), '\s*\(\S\+\)\s\+.*', '\1', '')
"    return seqlabel
"endfunction

function! ShowSeqLabelInFasta()
    " Fasta header parser
    let lnum = search('^>', 'bcnW')
    if lnum == 0
        return ''
    endif
    let header = getline(lnum)
    return substitute(header, '^>\s*', '', '')
endfunction

function! ShowSeqPosInFasta()
    " Compute cumulative sequence position in fasta (1-based, ignoring spaces)
    let myline = line('.')
    let mycol  = col('.')
    let line_text = getline(myline)
    if line_text =~ '^>'
        return '-'
    endif
    let start_line = search('^>', 'bcnW')
    if start_line == 0
        return ''
    endif
    let next_header = search('^>', 'nW')
    if next_header == 0
        let end_line = line('$')
    else
        let end_line = next_header - 1
    endif
    let seqpos = 0
    for l in range(start_line + 1, myline - 1)
        let seqpos += strlen(substitute(getline(l), '\s', '', 'g'))
    endfor
    let current_segment = strpart(line_text, 0, mycol)
    let seqpos += strlen(substitute(current_segment, '\s', '', 'g'))
    return seqpos
endfunction
" Testing:
"set statusline=%f\ Seq\ pos:\ %{ShowSeqPosInFasta()}\ [%{ShowSeqLabelInFasta()}]%=[%l,%c]
"set laststatus=2

function! ShowSeqLabelInPhylip()
    " phylip label parser (will also include the first row)
    let seqlabel = substitute(getline("."), '\s*\(\S\+\)\s\+.*', '\1', '')
    return seqlabel
endfunction

function! ShowSeqPosInPhylip()
    " Compute cumulative sequence position in phylip format (1-based, ignoring spaces)
    let mycolumn = col(".")
    let line = getline(".")
    let seqstart = match(line, '\s\zs\S') "'\s\zs[\w?-]'
    if seqstart == -1
        return '-'
    endif
    if mycolumn <= seqstart
        return '-'
    endif
    let segment = strpart(line, seqstart, mycolumn - seqstart)
    let segment_clean = substitute(segment, '\s', '', 'g')
    let seqpos = strlen(segment_clean)
    return seqpos
endfunction
" Testing
"set statusline=%f\ Seq\ pos:\ %{ShowSeqPosInPyhylip()}\ [%{ShowSeqLabelInPhylip()}]%=[%l,%c]
"set laststatus=2

function! CComment()
    "" C-Comment/uncomment function modified from vim.org/tips
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

function! NexusComment()
    "" Nexus-Comment/uncomment
    "" Works on line-by-line basis only
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

function! PerlComment()
    "" Perl-Comment/uncomment
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

function! LaTeXComment()
    "" LaTeX-Comment/uncomment
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

function! Stuff(str,justif,fillchar,len)
    "" Vertical copy
    "" Author: Vijayandra Singh <vijayandra@netzero.com>
    "" Modified: 2006 Dec 24
    "" License: Public Domain
    "" Version: 1.02
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
endfunction

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

function! AlignSection(regex) range
    "" Align columns based on white space by visually select a text, and then
    "" Uses function AlignLine
    "" :Align<CR> or press '\a'
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
    "" Used by function AlignSection
    let m = matchlist(a:line, '\(.\{-}\) \{-}\('.a:sep.'.*\)')
    if empty(m)
        return a:line
    endif
    let spaces = repeat(' ', a:maxpos - strlen(m[1]) + a:extra)
    return m[1] . spaces . m[2]
endfunction

function! CSVH(colnr)
    " Highlight a column in csv text.
    " :Csv 1    " highlight first column
    " :Csv 12   " highlight twelfth column
    " :Csv 0    " switch off highlight
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

function! ReadMan(man_word)
    "" Function to read Man page
    "" Source -- Edited by JN from http://vim.wikia.com/wiki/
    ""           Open_a_window_with_the_man_page_for_the_word_under_the_cursor
    exe ':tabnew'
    exe ':r!man ' . a:man_word . ' | col -b'
    exe ':goto'
    exe ':delete'
    exe ':set filetype=man'
endfunction

function! TwiddleCase(str)
    "" Change case
    ""http://vim.wikia.com/wiki/Switching_case_of_characters
    if a:str ==# toupper(a:str)
        let result = tolower(a:str)
    elseif a:str ==# tolower(a:str)
        let result = substitute(a:str,'\(\<\w\+\>\)', '\u\1', 'g')
    else
        let result = toupper(a:str)
    endif
    return result
endfunction

"function! ToggleIndentGuides()
"    "" Display indentation guides
"    "" http://stackoverflow.com/questions/2158305/is-it-possible-to-display-indentation-guides-in-vim
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

function! Gettt()
    "" Yank word under cursor and put into a Perl-debug print statement
    let l:wordUnderCursor = expand("<cWORD>")
    let s:apa = substitute(l:wordUnderCursor, '[\$\%\@]', "", "g")
    let l:cmd = "print Dumper(" . l:wordUnderCursor . ");warn \"\\n" . s:apa . " (hit return to continue)\\n\" and getc();"
    exe "normal o" l:cmd "\<Esc>"
endfunction

function! InsertEnglishTimestamp() abort
    " Get timestamp while temporarily changing LC_TIME to en_US.UTF-8
    let l:langinfo = execute('language')
    let l:old = ''
    let l:m = matchlist(l:langinfo, 'time\s\+\(\S\+\)')
    if !empty(l:m)
        let l:old = l:m[1]
    endif
    silent! language time en_US.UTF-8
    let l:ts = strftime("%c")
    if l:old !=# ''
        silent! execute 'language time ' . l:old
    else
        silent! language time
    endif
    return l:ts
endfunction


""===========================================================================
"" COMMANDS
""===========================================================================

" Highlight a column in csv text
" Uses function CSVH
command! -nargs=1 Csv :call CSVH(<args>)

"" Align columns based on white space
"" Uses function AlignSection
command! -nargs=? -range Align <line1>,<line2>call AlignSection('<args>')

" Get the reverse-complement of a certain DNA sequence
" Uses function RC_Tim
command! -n=* -range RC :call RC_Tim(<line1>,<line2>)

"" Randseq
"" Uses function RandSeq
command! -nargs=1 Randseq : call setline(line('.'), getline(line('.')) . RandSeq(<args>))

"" Converts file format to/from unix
command Unix :set ff=unix
command Dos  :set ff=dos
command Mac  :set ff=mac

"" Convert interleaved FASTA to non-interleaved FASTA
"" Uses funciton Fasta2NonInterLeavedFasta
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
"" Uses external program fas2nex.stdinout
command! -nargs=0 Fas2Nex :%! fas2nex.stdinout %<CR>

"" FASTA to TAB delimited
command! -nargs=0 Fasta2Tab :normal gg | :%s/^>\(.*\)/>\1\t/<CR> | :%s/\n//<CR> | :%s/>/\r/g<CR> | :g/^$/d<CR>

"" TAB to FASTA
command! -nargs=0 Tab2Fasta :normal gg | :%s/^\(.*\)\t\(.*\)/>\1\r\2/<CR>

"" Print current buffer to pdf file
"" Uses function PrintPdf
command! -nargs=0 Pdf : call PrintPdf()

"" Print current buffer to postscript file
"" Uses function PrintPs
command! -nargs=0 Ps : call PrintPs()


""===========================================================================
"" FILE TYPES
""===========================================================================


"" Use other color scheme for diff
if &diff
    colorscheme github
endif

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
"" Uses external program pdftotext
autocmd BufReadPre *.pdf set ro
autocmd BufReadPost *.pdf %!pdftotext -nopgbrk "%" -

"" FASTA files
autocmd BufRead,BufNewFile *.fas,*.fasta,*.fna,*.faa setfiletype fasta
augroup fasta_statusline
    autocmd!
    autocmd FileType fasta call SetFastaStatusline()
augroup END
function! SetFastaStatusline()
    setlocal statusline=%f\ Seq\ pos:\ %{ShowSeqPosInFasta()}\ [%{ShowSeqLabelInFasta()}]%=[%l,%c]
    setlocal laststatus=2
endfunction

"" PHYLIP files
autocmd BufRead,BufNewFile *.dat,*.phy setfiletype phylip
augroup phylip_statusline
    autocmd!
    autocmd FileType phylip call SetPhylipStatusline()
augroup END
function! SetPhylipStatusline()
    setlocal statusline=%f\ Seq\ pos:\ %{ShowSeqPosInPhylip()}\ [%{ShowSeqLabelInPhylip()}]%=[%l,%c]
    setlocal laststatus=2
endfunction

"" Allow editing of compressed files
"" http://www.ashberg.de/vim/vimrc.html
if v:version >= 600
    filetype on
    filetype indent on
else
    filetype on
endif
if has("autocmd")
    if v:version >= 600
        filetype plugin indent on
    endif
    autocmd BufReadPost * if line("'\"") | exe "normal '\"" | endif
    augroup gzip
    au!
    autocmd BufReadPre,FileReadPre      *.gz,*.bz2 set bin
    autocmd BufReadPost,FileReadPost    *.gz call GZIP_read("gunzip")
    autocmd BufReadPost,FileReadPost    *.bz2 call GZIP_read("bunzip2")
    autocmd BufWritePost,FileWritePost  *.gz call GZIP_write("gzip")
    autocmd BufWritePost,FileWritePost  *.bz2 call GZIP_write("bzip2")
    autocmd FileAppendPre               *.gz call GZIP_appre("gunzip")
    autocmd FileAppendPre               *.bz2 call GZIP_appre("bunzip2")
    autocmd FileAppendPost              *.gz call GZIP_write("gzip")
    autocmd FileAppendPost              *.bz2 call GZIP_write("bzip2")
    fun! GZIP_read(cmd)
        let ch_save = &ch
        set ch=2
        execute "'[,']!" . a:cmd
        set nobin
        let &ch = ch_save
        execute ":doautocmd BufReadPost " . expand("%:r")
    endfun
    fun! GZIP_write(cmd)
        !mv <afile> <afile>:r
        execute "!" . a:cmd . " <afile>:r"
    endfun
    fun! GZIP_appre(cmd)
        execute "!" . a:cmd . " <afile>"
        !mv <afile>:r <afile>
    endfun
    augroup END " gzip
endif

"" Automatically update the 'Last modified:' date on write buffert
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

"" Map F4 to TagList on/off
"nnoremap <silent> <F4> :TlistToggle \| sp <CR>
"set <F4>=<C-v><F4>
"nnoremap <F4> :TlistToggle \| sp <CR>
nnoremap <F4> :TlistToggle<enter>

"" Map the F12 key to Sketch on/off
"map <F12> :call ToggleSketch()<CR>
map <F12> :call MySketch()<CR>

"" Map CTRL-s to SAVE in normal, visual, and insert mode
nmap <C-S> <Esc>:w<CR>
vmap <C-S> <Esc>:w<CR>v
imap <C-S> <Esc>:w<CR>i

""" Map CTRL-d to insert time stamp
nnoremap <C-d> :execute "normal! i" . InsertEnglishTimestamp()<CR>
inoremap <C-d> <C-R>=InsertEnglishTimestamp()<CR>

"" Search for occurence of selected text by pressing '/' in visual mode
"" See function below for an alternative using forward and backward search
vmap / y/<C-R>"<CR>

"" Save word under cursor to a file
"" Uses function SaveWord
" map ,p :call SaveWord()

"" Count letters in the word under the cursor
"" Uses function LC
map zz :call LC()<CR>

"" Print the position in word under cursor
"" Uses function PC
"map zz:call PC()<CR>

"" Count letters in the line under the cursor, v.2
"" Uses function LC2
map zx :call LC2()<CR>

"" Count words in the line under the cursor, v.3
"" Uses function LC3
"map ZX :call LC3()<CR>

"" Count A, C, G, and T's on a line
"" Uses function Count_bases
map ZZ :call Count_bases()<CR>

"" C-Comment/uncomment function modified from vim.org/tips
"" Uses function CComment
map ö :call CComment()<CR>
map ,/ :call CComment()<CR>

"" Nexus-Comment/uncomment
"" Uses function NexusComment
map å :call NexusComment()<CR>
map ,[ :call NexusComment()<CR>

"" Perl-Comment/uncomment
"" Uses function PerlComment
map ä :call PerlComment()<CR>
map ,. :call PerlComment()<CR>

"" LaTeX-Comment/uncomment
"" Uses function LaTeXComment
"map ' :call LaTeXComment()<CR>

"" Align columns based on white space
"" Uses command Align
vnoremap <silent> <Leader>a :Align<CR>

"" Change case
vnoremap ~ ygv"=TwiddleCase(@")<CR>Pgv


""===========================================================================
"" GUI MENUS
""===========================================================================

"" SYNTAX MENU
"" Markdown to PDF conversion using external wrappers to pandoc
menu Syntax.-Sep-                               :
menu Syntax.Markdown.-Sep-                      :
menu Syntax.Markdown.Markdown\ to\ &PDF         :! md2pdf % <CR><CR>
menu Syntax.Markdown.Markdown\ to\ &Beamer\ PDF :! md2beamer % <CR><CR>
menu Syntax.Retab.-Sep-                         :
menu Syntax.Retab.Replace\ tabs\ with\ spaces   : norm gg=G''<CR>

"" PHYLO MENU (Note: uses a number of external software!)
"" Run Alignment programs
menu Phylo.Do\ Alignment.CLUSTALO.Protein\ or\ DNA          :! clustalo --infile=% --outfile=ClUsTaLo.aln <CR>: tabe ClUsTaLo.aln<CR> : normal gg<CR>
menu Phylo.Do\ Alignment.CLUSTALO.-Sep-                     :
menu Phylo.Do\ Alignment.CLUSTALO.Read\ CLUSTALO\ man\ page : call ReadMan('clustalo')<CR>
menu Phylo.Do\ Alignment.CLUSTALW.Protein                   :! clustalw -outorder=INPUT -output=GDE -case=UPPER -outfile=ClUsTaLw.aln -align -infile=%<CR>: tabe ClUsTaLw.aln<CR> :% s/%/>/<CR>: normal gg<CR>
menu Phylo.Do\ Alignment.CLUSTALW.DNA                       :! clustalw -outorder=INPUT -output=GDE -case=UPPER -outfile=ClUsTaLw.aln -align -infile=%<CR>: tabe ClUsTaLw.aln<CR> :% s/#/>/<CR>: normal gg<CR>
menu Phylo.Do\ Alignment.CLUSTALW.-Sep-                     :
menu Phylo.Do\ Alignment.CLUSTALW.Read\ CLUSTALW\ man\ page : call ReadMan('clustalw')<CR>
menu Phylo.Do\ Alignment.MUSCLE.Protein                     :! muscle3 -in % -out mUsClE.aln<CR>: tabe mUsClE.aln<CR> :normal gg<CR>
menu Phylo.Do\ Alignment.MUSCLE.-Sep-                       :
menu Phylo.Do\ Alignment.MUSCLE.Read\ MUSCLE\ man\ page     : call ReadMan('muscle3')<CR>
menu Phylo.Do\ Alignment.MAFFT.mafft\ --auto                :! mafft --auto % > MaFfT.mafft.auto.ali<CR> : tabe  MaFfT.mafft.auto.ali<CR><CR>
menu Phylo.Do\ Alignment.MAFFT.-Sep-                        :
menu Phylo.Do\ Alignment.MAFFT.Read\ MAFFT\ man\ page       : call ReadMan('mafft')<CR>

"" Edit alignments
menu Phylo.Utilities.Get\ FASTA\ info                       :! get_fasta_info %<CR>
menu Phylo.Utilities.Remove\ all\ gaps\ in\ FASTA           : call DegapFasta()<CR>
menu Phylo.Utilities.Align\ taxlabels\ (in\ phyml\ format)  : Align<CR>
menu Phylo.Utilities.Count\ sequences\ (in\ FASTA\ format)  : call GetNtax2()<CR>
menu Phylo.Utilities.Set\ filetype\ to\ DNA                 : set ft=align<CR>
menu Phylo.Utilities.Set\ filetype\ to\ AA                  : set ft=aalign<CR>
menu Phylo.Utilities.Set\ filetype\ to\ Nexus               : set ft=nexus<CR>
menu Phylo.Utilities.Display\ Newick\ as\ ASCII             :! nw_display -S  % > AsCiI.tRe<CR> : tabe AsCiI.tRe<CR><CR>

"" Format conversions
menu Phylo.Convert.Phyml\ to\ FASTA                         : Phyml2Fasta<CR>
menu Phylo.Convert.FASTA\ to\ Phyml                         : call Fasta2Phyml()<CR><CR>
menu Phylo.Convert.FASTA\ to\ Nexus                         : Fas2Nex<CR> : set ft=nexus<CR>
menu Phylo.Convert.FASTA\ to\ Tab                           : Fasta2Tab<CR>
menu Phylo.Convert.Tab\ to\ FASTA                           : Tab2Fasta<CR>
menu Phylo.Convert.Unwrap\ FASTA                            : call Fasta2NonInterLeavedFasta()<CR><CR>
menu Phylo.Convert.Wrap\ FASTA                              : WrapFasta<CR>

"" DNA
menu Phylo.DNA.RevComp                                      : RC<CR>
menu Phylo.DNA.Insert\ Random\ DNA\ Seq                     : Randseq

"" Run programs
"" Need to capture the output from fasttree in a new buffer instead of having to hardcode the output name
menu Phylo.Run.Fasttree\ (DNA)                              :! fasttree -nt % > FaSt.tre<CR><CR>: tabe FaSt.tre<CR>
menu Phylo.Run.Fasttree\ (AA)                               :! fasttree  % > FaSt.tre<CR><CR>: tabe FaSt.tre<CR>
menu Phylo.Run.PAUP                                         :! paup %<CR>
menu Phylo.Run.MrBayes                                      :! mb -i %<CR>
menu Phylo.Run.MrAIC\ (24\ nt\ models)                      :! mraic.pl %<CR><CR>: tabe *.MrAIC.txt<CR>
menu Phylo.Run.MrAIC\ (56\ nt\ models)                      :! mraic.pl -modeltest %<CR><CR>: tabe *.MrAIC.txt<CR>
menu Phylo.Run.pMr&AIC\ (24\ nt\ models)                    :! pmraic.pl --noverbose %<CR><CR>: tabe *.pMrAIC.txt<CR>
menu Phylo.Run.pMrAIC\ (56\ nt\ models)                     :! pmraic.pl --noverbose --modeltest %<CR><CR>: tabe *.pMrAIC.txt<CR>

