set hls ts=2 sw=2 ai et
set nonu

" don't do this
" cursor stays in place on escape to normal mode
" autocmd InsertLeave * :normal! `^
" set virtualedit=onemore


" prettier color for search highlighting
hi Search ctermbg=DarkGray ctermfg=LightBlue

let g:mapleader = ","

command! -bar Reload :source ~/.vimrc
syn off " no syntax highlighting

func! ToggleColorNum()
  if exists("g:syntax_on")
    syn off
    set nonu
    colorscheme default
  else
    syn on
    set nu
    colorscheme desert
  endif
endfunc
nmap <leader>C :call ToggleColorNum()<CR>


" syntax enable
" filetype plugin indent on

setglobal fileencodings=ucs-bom.utf-8

" command! Paste :r !cat 
command! Pa :r !cat

nmap ,# 65i#<ESC>o
nmap ,- 65i-<ESC>o
nmap ,_ 65i-<ESC>:r !date +'\%a \%d \%b \%Y'<CR>

nnoremap ,g :grep '<cword>' *<CR>:cope<CR><CR>


autocmd BufNewFile,BufRead *.tsv setlocal noet
" mblaze compose
autocmd BufNewFile,BufRead snd.* setlocal tw=70 hls
autocmd BufNewFile,BufRead *.txt setlocal tw=70 hls
autocmd BufNewFile,BufRead TODO* setlocal ts=2 sw=2 tw=70 hls
autocmd BufNewFile,BufRead *.md  setlocal ft=txt tw=0
autocmd BufNewFile,BufRead *.js,*.ts  setlocal ts=2 sw=2 tw=0
autocmd BufNewFile,BufRead README*,INSTALL setlocal tw=70 hls
autocmd BufNewFile,BufRead NOTES setlocal tw=70 hls
autocmd BufNewFile,BufRead *.rb set ft=ruby
autocmd BufNewFile,BufRead Makefile* setlocal noet tw=0
autocmd BufNewFile,BufRead *.py set ts=4 sw=4 et

" remove trailing whitespace
autocmd BufWritePre *.sh :%s/\s\+$//e
autocmd BufWritePre *.yml :%s/\s\+$//e

" prevent accidental file cruft creation
autocmd BufWritePre ; throw "Canceled write to filename: ;"
autocmd BufWritePre : throw "Canceled write to filename: :"


func! ToggleNumbering()
  if &nu 
    set nonu
  else 
    set nu
  endif
endfunc
nmap <leader>n :call ToggleNumbering()<CR>

" resize windows
noremap ,< :vertical resize -20<cr>
noremap ,> :vertical resize +20<cr>

" formats python with Blue
func! Blue()
  !blue %
  :e
endfunc
command! Blue :call Blue()


func! CommentMarker() 
  let ext = expand('%:e')
  if ext == 'js' || ext == 'json' || ext == 'swift' || ext == 'ts' || ext == 'c'
    return '//'
  elseif ext == 'hs' || ext == 'cabal' || ext == 'elm' || ext == 'cabal' || ext == 'chs'
    return '--'
  elseif ext == 'html'
    return '<!--'
  elseif expand('%') == '.vimrc'
    return '"' 
  else
    return '#'
  endif
endfunc
func! Comment() range
  let lnum = a:firstline
  while lnum <= a:lastline
    let line = getline(lnum)
    let newline = substitute(line, '^', CommentMarker() . ' ', '')      " comment out
    call setline(lnum, newline)
    let lnum += 1
  endwhile
endfunc
func! Uncomment() range
  let lnum = a:firstline
  while lnum <= a:lastline
    let line = getline(lnum)
    let newline = substitute(line, '^'.CommentMarker().'\s\?', '', '')   " uncomment
    call setline(lnum, newline)
    let lnum += 1
  endwhile
endfunc
command! -bar -range Comment :<line1>,<line2>call Comment()
command! -bar -range Uncomment :<line1>,<line2>call Uncomment()

func! Underline()
  " get line
  let length = strlen(getline("."))
  echo length
  call append(line('.'), repeat("-", length) )
endfunc
noremap ,= :call Underline()<cr>


