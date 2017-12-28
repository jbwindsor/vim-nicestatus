" NeatStatus (c) 2012 Lukasz Grzegorz Maciak
" Neat and simple status line - because Powerline is overrated
"
" Loosely based on a script by Tomas Restrepo (winterdom.com)
" " Original available here:
" http://winterdom.com/2007/06/vimstatusline

set ls=2 " Always show status line
let g:last_mode=""

" Color Scheme Settings
" You can redefine these in your .vimrc

" ==============================================================================
"  Colors 
" ==============================================================================

    " Full color setting stuff
    " = 'guifg=#ff00ff guibg=#000000 gui=NONE ctermfg=7 ctermbg=0'

    " =============
    " Standard 
    " =============
    "
        let g:BlkonRed = 'ctermfg=0  ctermbg=1'
        let g:BlkonGre = 'ctermfg=0  ctermbg=2'
        let g:BlkonBlu = 'ctermfg=0  ctermbg=4'
        let g:BlkonPin = 'ctermfg=0  ctermbg=5'
        let g:BlkonLbl = 'ctermfg=0  ctermbg=6'
        let g:BlkonGry = 'ctermfg=0  ctermbg=7'
        let g:BlkonYel = 'ctermfg=0  ctermbg=11'
        let g:BlkonWhi = 'ctermfg=0  ctermbg=15'

        let g:RedonBlk = 'ctermfg=1  ctermbg=0'
        let g:GreonBlk = 'ctermfg=2  ctermbg=0'
        let g:BluonBlk = 'ctermfg=4  ctermbg=0'
        let g:PinonBlk = 'ctermfg=5  ctermbg=0'
        let g:LblonBlk = 'ctermfg=6  ctermbg=0'
        let g:GryonBlk = 'ctermfg=7  ctermbg=0'
        let g:YelonBlk = 'ctermfg=11 ctermbg=0'
        let g:WhionBlk = 'ctermfg=15 ctermbg=0'

    " =============
    " Custome
    " =============
    "
        let g:BlkonPur = 'ctermfg=0    ctermbg=105'
        let g:BlkonLgr = 'ctermfg=0    ctermbg=244'
        let g:BlkonOrg = 'ctermfg=0    ctermbg=208'
        let g:BlkonDog = 'ctermfg=0    ctermbg=202'

        let g:PuronBlk = 'ctermfg=105  ctermbg=0'
        let g:LgronBlk = 'ctermfg=244  ctermbg=0'
        let g:OrgonBlk = 'ctermfg=208  ctermbg=0'

        let g:GreonDpr = 'ctermfg=119   ctermbg=53'
        let g:OrgonDpr = 'ctermfg=166   ctermbg=53'
        let g:GryonDpr = 'ctermfg=244   ctermbg=53'

        let g:DpronGre = 'ctermfg=53   ctermbg=47'

" ==============================================================================
"  status line type colors 
" ==============================================================================
    
    " =============
    " Modes
    " =============
    
        if !exists('g:sl_normal') | let g:sl_normal = g:BlkonGre | endif
        if !exists('g:sl_insert') | let g:sl_insert = g:BlkonYel | endif
        " if !exists('g:sl_visual') | let g:sl_visual = g:BlkonBlu | endif
        if !exists('g:sl_visual') | let g:sl_visual = g:BlkonPur | endif
        if !exists('g:sl_replace') | let g:sl_replace = g:BlkonYel | endif

    " =============
    " file stuff 
    " =============
    
        if !exists('g:sl_plainstyle') | let g:sl_plainstyle = g:WhionBlk | endif
        if !exists('g:sl_termtype') | let g:sl_termtype = g:BlkonBlu | endif
        if !exists('g:sl_fileinfo') | let g:sl_fileinfo = g:GreonBlk | endif
        " if !exists('g:sl_filestatus') | let g:sl_filestatus = g:WhionBlk | endif
        if !exists('g:sl_filestatus') | let g:sl_filestatus = g:GryonDpr | endif
        if !exists('g:sl_linenumber') | let g:sl_linenumber = g:OrgonDpr | endif
        if !exists('g:sl_modified') | let g:sl_modified = g:BlkonDog | endif
    
    " =============
    " Separator
    " =============
        if !exists('g:sl_separator') | let g:sl_separator = '|' |  endif


" ==============================================================================
" Functions 
" ==============================================================================

" Set up the colors for the status bar
function! SetStatusColorscheme()

    " Basic color presets
    
    exec 'hi User1 '.g:sl_normal
    exec 'hi User2 '.g:sl_termtype
    exec 'hi User3 '.g:sl_fileinfo
    exec 'hi User4 '.g:sl_filestatus
    exec 'hi User5 '.g:sl_linenumber
    exec 'hi User6 '.g:sl_modified

endfunc

" pretty mode display - converts the one letter status notifiers to words
function! Mode()
    redraw
    let l:mode = mode()
    
    if     mode ==# "n"  | exec 'hi User1 '.g:sl_normal  | return "NORMAL"
    elseif mode ==# "i"  | exec 'hi User1 '.g:sl_insert  | return "INSERT"
    elseif mode ==# "R"  | exec 'hi User1 '.g:sl_replace | return "REPLACE"
    elseif mode ==# "v"  | exec 'hi User1 '.g:sl_visual  | return "VISUAL"
    elseif mode ==# "V"  | exec 'hi User1 '.g:sl_visual  | return "V-LINE"
    elseif mode ==# "" | exec 'hi User1 '.g:sl_visual  | return "V-BLOCK"
    else                 | return l:mode
    endif
endfunc    

" ==============================================================================
" Format statusline 
" ==============================================================================

if has('statusline')

    " set up color scheme now
    call SetStatusColorscheme()

    " Status line detail:
    " -------------------
    "
    " %f    file name
    " %F    file path
    " %y    file type between braces (if defined)
    "
    " %{v:servername}   server/session name (gvim only)
    "
    " %<    collapse to the left if window is to small
    "
    " %( %) display contents only if not empty
    "
    " %1*   use color preset User1 from this point on (use %0* to reset)
    "
    " %([%R%M]%)   read-only, modified and modifiable flags between braces
    "
    " %{'!'[&ff=='default_file_format']}
    "        shows a '!' if the file format is not the platform default
    "
    " %{'$'[!&list]}  shows a '*' if in list mode
    " %{'~'[&pm=='']} shows a '~' if in patchmode
    "
    " %=     right-align following items
    "
    " %{&fileencoding}  displays encoding (like utf8)
    " %{&fileformat}    displays file format (unix, dos, etc..)
    " %{&filetype}      displays file type (vim, python, etc..)
    "
    " #%n   buffer number
    " %l/%L line number, total number of lines
    " %p%   percentage of file
    " %c%V  column number, absolute column number
    " &modified         whether or not file was modified
    "
    " %-5.x - syntax to add 5 chars of padding to some element x
    "
    function! SetStatusLineStyle()

        " Determine the name of the session or terminal
        if (strlen(v:servername)>0)
            if v:servername =~ 'nvim'
                let g:neatstatus_session = 'neovim'
            else
                " If running a GUI vim with servername, then use that
                let g:neatstatus_session = v:servername
            endif
        elseif !has('gui_running')
            " If running CLI vim say TMUX or use the terminal name.
            if (exists("$TMUX"))
                let g:neatstatus_session = 'tmux'
            else
                " Giving preference to color-term because that might be more
                " meaningful in graphical environments. Eg. my $TERM is
                " usually screen256-color 90% of the time.
                let g:neatstatus_session = exists("$COLORTERM") ? $COLORTERM : $TERM
            endif
        else
            " idk, my bff jill
            let g:neatstatus_session = '?'
        endif
    
        " zero out
        let &stl=""
        
        " mode (changes color)
        let &stl.="%1*\ %{Mode()} %0*"
        
        " session name
        " let &stl.="%2* %{g:neatstatus_session} %0*"
        
        " " file path
        " let &stl.="%3* %<%f "
        
        " file path
        let &stl.="%3* %f "

        " read only, modified, modifiable flags in brackets
        let &stl.="%%([%R%M]%) "

        " right-aligh everything past this point
        let &stl.="%= "

        " readonly flag
        let &stl.="%(%{(&ro!=0?'(readonly)':'')} ".g:sl_separator." %)"

        " file type (eg. python, ruby, etc..)
        let &stl.="%3*%( %{&filetype} %)".g:sl_separator." %0*"
        
        " file format (eg. unix, dos, etc..)
        let &stl.="%<%3*%{&fileformat} ".g:sl_separator." "
        
        " " file encoding (eg. utf8, latin1, etc..)
        " let &stl.="%(%{(&fenc!=''?&fenc:&enc)} ".g:sl_separator." %)"
        
        " buffer number
        let &stl.="BUF #%n "
        
        "line number (red) / total lines
        let &stl.="%<%4* LN %5*%-4.l%4*/%-4.L\ "
        
        " percentage done
        let &stl.="%4*(%-3.p%%) %4*"
        
        " column number (minimum width is 4)
        " let &stl.="%9*COL %-3.c %0*"
        " modified / unmodified (purple)
        let &stl.="%(%6* %{&modified ? 'modified':''} %)"

    endfunc

    "FIXME: hack to fix the repeated statusline issue in console version
    if !has('gui_running')
        au InsertEnter  * redraw!
        au InsertChange * redraw!
        au InsertLeave  * redraw!
    endif

    " whenever the color scheme changes re-apply the colors
    au ColorScheme * call SetStatusColorscheme()

    " Make sure the statusbar is reloaded late to pick up servername
    au ColorScheme,VimEnter * call SetStatusLineStyle()

    " Switch between the normal and vim-debug modes in the status line
    nmap _ds :call SetStatusLineStyle()<CR>
    call SetStatusLineStyle()
    " Window title
    if has('title')
        set titlestring="%t%(\ [%R%M]%)".expand(v:servername)
    endif
endif
