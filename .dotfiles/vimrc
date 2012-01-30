set nocompatible 
filetype off 
call pathogen#runtime_append_all_bundles()

filetype plugin indent on
filetype on

syntax on
set t_Co=256
set background=dark
colorscheme mgj256
"set background=light
""colorscheme mgj256dark

if has('gui_running')
  if &bg == "dark"
    set transparency=15
  else
    set transparency=0
  endif
  set guifont=monaco:h12
  set guioptions=-t
  set lines=34 columns=81
endif

function! ShowIndentLevel()
  let pos = range(1, &l:textwidth, &l:shiftwidth)
  call map(pos, '"\\%" . v:val . "v"')
  let pat = '\%(\_^\s*\)\@<=\%(' . join(pos, '\|') . '\)\s'                  
  call matchadd('HiBeginTab', pat)
endfunction

function! HideIndentLevel()
  let pos = range(1, &l:textwidth, &l:shiftwidth)
  call map(pos, '"\\%" . v:val . "v"')
  let pat = '\%(\_^\s*\)\@<=\%(' . join(pos, '\|') . '\)\s'
  call matchadd('UnHiBeginTab', pat)
endfunction

nmap <leader>t :call ShowIndentLevel()<CR>
nmap <leader>h :call HideIndentLevel()<CR>
call HideIndentLevel()

nmap <leader>n :NERDTree<CR>
nmap <leader>l :set list!<CR>
set listchars=eol:¬

set encoding=utf-8
set scrolloff=2
set shell=/bin/zsh
set mouse=a			    " Enable mouse usage (all modes) in terminalssssssssssssssss
set backspace=2     " forces backspace behave normal
set smartcase		    " Do smart case matching
set showmatch		    " this makes the cursor jumps briefly to maching brace/paranthese/bracket

set breakat=\ 
set linebreak
set showbreak=\ ...\ 

"set relativenumber
"set colorcolumn=78

set autoindent		  " this use the current line's indent level to set the indent level of new lines
set tabstop=3		    " set the tab to 3 spaces instead of 8
set expandtab		    " expand tabs into space
set shiftwidth=3	  " this tell vim to use 3 spaces when autoindent is on
set smarttab
set softtabstop=3

set vb t_vb=		    " this turn off the beeps
set ruler			      " show cursor position
set nohls			      " this does not highlight maches
set incsearch		    " this allow vim to search as you type
set ignorecase		  " this ignore case in search 

"" The following are commented out as they cause vim to behave a lot
"" differently from regular Vi. They are highly recommended though.

"set backspace=indent,eol,start

""set showcmd		" Show (partial) command in status line.
""set showmatch		" Show matching brackets.
""set ignorecase	" Do case insensitive matching
""set incsearch		" Incremental search
""set autowrite		" Automatically save before commands like :next and :make
""set hidden             " Hide buffers when they are abandoned
""set hls			" this highlight maches
""set nobackup	
""set noignorecase	" doesn't ignore case in search
""
""set number          "  numbers in line
""set undofile
""filetype on
""set ofu=syntaxcomplete#Complete
""autocmd FileType python set omnifunc=pythoncomplete#Complete



