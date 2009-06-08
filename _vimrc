version 5.4

set nocompatible	" Use Vim defaults (much better!)
set bs=2		" allow backspacing over everything in insert mode
set ai			" always set autoindenting on
set nobackup	" do not keep a backup file
set viminfo='20,\"50	" read/write a .viminfo file, don't store more
					" than 50 lines of registers
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set hidden      " Allow switching of buffers when the current one is not saved
set tags=$CPROVDIR\tags
set expandtab

" Only do this part when compiled with support for autocommands
if has("autocmd")
  " In text files, always limit the width of text to 78 characters
  autocmd BufRead *.txt set tw=78
  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost * if line("'\"") | exe "'\"" | endif
endif

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if has("gui_running")
  syntax on
  set hlsearch
endif

if has("autocmd")
 augroup cprog
  " Remove all cprog autocommands
  au!

  " When starting to edit a file:
  "   For C and C++ files set formatting of comments and set C-indenting on.
  "   For other files switch it off.
  "   Don't change the order, it's important that the line with * comes first.
  autocmd FileType *      set formatoptions=tcq nocindent comments&
  autocmd FileType c,cpp  set formatoptions=tcroq2 cindent comments=sr:/*,mb:*,el:*/,://
 augroup END

 augroup gzip
  " Remove all gzip autocommands
  au!

  " Enable editing of gzipped files
  "	  read:	set binary mode before reading the file
  "		uncompress text in buffer after reading
  "	 write:	compress file after writing
  "	append:	uncompress file, append, compress file
  autocmd BufReadPre,FileReadPre	*.gz set bin
  autocmd BufReadPost,FileReadPost	*.gz let ch_save = &ch|set ch=2
  autocmd BufReadPost,FileReadPost	*.gz '[,']!gunzip
  autocmd BufReadPost,FileReadPost	*.gz set nobin
  autocmd BufReadPost,FileReadPost	*.gz let &ch = ch_save|unlet ch_save
  autocmd BufReadPost,FileReadPost	*.gz execute ":doautocmd BufReadPost " . expand("%:r")

  autocmd BufWritePost,FileWritePost	*.gz !mv <afile> <afile>:r
  autocmd BufWritePost,FileWritePost	*.gz !gzip <afile>:r

  autocmd FileAppendPre			*.gz !gunzip <afile>
  autocmd FileAppendPre			*.gz !mv <afile>:r <afile>
  autocmd FileAppendPost		*.gz !mv <afile> <afile>:r
  autocmd FileAppendPost		*.gz !gzip <afile>:r
 augroup END
endif
" And these are my commands
set directory=$TEMP/vim
set shiftwidth=4
set textwidth=74
set smartcase
set tabstop=4
behave xterm
set selectmode=mouse
set cindent
set makeprg=nmake
set errorformat=%f(%l)\ :\ %*[a-z]\ %t%n:\ %m
set path=.,$INCPATH
set showbreak=>>\ 

" Cute macros to make life easier editing C/C++ files
nmap _i I<C-m><Esc>kI#include ""<Esc>$i
imap <C-z>i <Esc>_i
nmap _I I<C-m><Esc>kI#include <><Esc>$i
imap <C-z><C-i> <Esc>_I

" Header file #ifdef protections
nmap _L my:0<CR>O#ifndef INC_<Esc>"%p:s/\./_/g<CR>$bv$U"zy$o#define <Esc>"zpo<Esc>Go<CR>#endif /* <Esc>"zpA */<Esc>k^`y
imap <C-z><C-l> <Esc>_L

nmap <F4> :cn<C-m>

imap <C-space> <C-n>

set listchars=tab:\ \ ,trail:#
set list
hi NonText guifg=red gui=NONE

set incsearch

set cino=:0(0
set tw=79
if has("gui_running")
    winpos 0 0
    winsize 80 40
endif
source $VIMRUNTIME/colors/peachpuff.vim

func ReverseEng()
    au! CursorHold *.[ch] nested call PreviewWord()
endfun

func PreviewWord()
	if &previewwindow			" don't do this in the preview window
		return
	endif
	let w = expand("<cword>")		" get the word under cursor
	if w != ""				" if there is one ":ptag" to it
		" Delete any existing highlight before showing another tag
		silent! wincmd P			" jump to preview window
		if &previewwindow			" if we really get there...
			match none			" delete existing highlight
			wincmd p			" back to old window
		endif

		" Try displaying a matching tag for the word under the cursor
		let v:errmsg = ""
		exe "silent! ptag " . w
		if v:errmsg =~ "tag not found"
			return
		endif

		silent! wincmd P			" jump to preview window
		if &previewwindow		" if we really get there...
			if has("folding")
				silent! .,$foldopen		" don't want a closed fold
			endif
			call search("$", "b")		" to end of previous line
			let w = substitute(w, '\\', '\\\\', "")
			call search('\<\V' . w . '\>')	" position cursor on match
			" Add a match highlight to the word at this position
			hi previewWord term=bold ctermbg=green guibg=green
			exe 'match previewWord "\%' . line(".") . 'l\%' . col(".") . 'c\k*"'
			wincmd p			" back to old window
		endif
	endif
endfun

func CheckIndent()
    " Remember the current position
    let c=col(".")
    let l=line(".")
    " Goto beginning of file.
    goto 1
    " Search for an indented line (anywhere) that is composed of tabs.
    " If it exists, change all space tabs into <TAB> tabs.
    if search("^\t[^$]", "W") > 0
        " Make sure we do not expand tabs in this file.
        set noexpandtab
        " Get rid of the space indentations
        let i=&sw
        let ts=""
        while i > 0
            let ts=ts . "\ "
            let i=i-1
        endwhile
        goto 1
        while search("^" . ts . "[^$]", "W") > 0
            execute "normal =$"
        endwhile
    else
        set expandtab
    endif
    " Restore position
    call cursor(l,c)
endfunc

func FindTags()
    " Find the current directory
    let cwd=getcwd()
    " For win32 freaks, get rid of the nasty '/'
    let cwd=substitute(cwd, "\\", "/", 'g')
    " Add the trailing /
    let cwd=substitute(cwd, '\([^\/]\)$', '\1\/', '')
    while stridx(cwd,'/') != -1
        let tagName=cwd . 'tags'
        if filereadable(tagName)
            let &tags=tagName
            break
        endif
        let cwd=substitute(cwd, '\(.\{-}\)[^\/]*\/$', '\1', '')
    endwhile
endfunc

func FindIncludes()
    " Find the current directory
    let cwd=getcwd()
    " For win32 freaks, get rid of the nasty '/'
    let cwd=substitute(cwd, "\\", "/", 'g')
    " Add the trailing /
    let cwd=substitute(cwd, '\([^\/]\)$', '\1\/', '')
    while stridx(cwd,'/') != -1
        let includeName=cwd . 'include'
        if isdirectory(includeName)
            execute("set path+=" . includeName)
        endif
        let cwd=substitute(cwd, '\(.\{-}\)[^\/]*\/$', '\1', '')
    endwhile
endfunc

autocmd BufRead *.c,*.h,*.java,*.cpp,*.hpp,*.lua call CheckIndent()
autocmd BufRead *.c,*.h,*.java,*.cpp,*.hpp call FindTags()
autocmd BufRead Makefile,*.mak set noexpandtab
autocmd BufNewFile *.c,*.h,*.java,*.cpp,*.hpp set expandtab
autocmd BufNewFile Makefile,*.mak,*lua set noexpandtab

set updatetime=1000
set previewheight=8

func ProdNt()
set makeprg=nmake\ -fnt.mak
compiler msvc
endfunc

call ProdNt() " Default is the NT build
call FindIncludes() " Construct the include path
set nofoldenable

