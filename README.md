Nice Status Line
===

Yet another status line plugin. The aim of Nice Status is to provide a clean, and 
simple UI with just basic information and no bells and whistles for those users
who consider things like Powerline to be overkill.

Nice Status is based on the status line script created by Luke Maciak.


The original code can be seen here:

  * http://github.com/maciakl/vim-neatstatus.git

Which was loosely based on:
  * http://winterdom.com/2007/06/vimstatusline


Installation
---

To install with vundle:
    
    add Plugin 'jbwindsor/vim-nicestatus' to .vimrc file inside vundle logic
    vim :PluginInstall 


To install manualy:

    cd ~/.vim/bundle
    git clone https://github.com/jbwindsor/vim-nicestatus.git


If your .vim is under source control with Git do this instead:

    cd ~/.vim
    git submodule add https://github.com/jbwindsor/vim-nicestatus.git bundle/vim-nicestatus
    git submodule init
    git submodule update

Installing without vundle:

  * Copy `neatstatus.vim` to `~/.vim/after/plugins` directory

Configuration
---

You can configure the colors of the status line elements by defining the following global vars in your `.vimrc`:

* `g:sl_normal` - the color of the mode indicator when in normal mode
* `g:sl_insert` - the color of the mode indicator when in insert mode
* `g:sl_replace` - the color of the mode indicator when in replace mode
* `g:sl_termtype` - the color of the terminal info 
* `g:sl_position` - the color of the cursor position box (and session box)
* `g:sl_linenumber` - the color of the line number in the cursor position box
* `g:sl_filetype` - the color of the filetype box
* `g:sl_fileinfo` - the color of the file info ie type, os type,format, buffer 
* `g:sl_modified` - the color of the "modified" indicator on the right

Make sure you define values both for graphical and terminal clients when you do this. Here is
a quick example that shows you hot to redefine the insert mode colors:

    let g:sl_insert = 'guifg=#ffffff guibg=#ff0000 gui=bold ctermfg=15 ctermbg=9 cterm=bold'

    or use a defualt color

    let g:l_insert = g:BlkonRed 


You can also change the separator character that divides the boxes by changing:

* `g:ls_separator`

By default the separator is set to the pipe `|` character. You can disable the separator by setting it to empty string.
