" Generial
"
set history=500

" 显示菜单栏
set wildmenu

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is chagned from the outside
set autoread

" <leader>w
let mapleader=","

" Fast saving 
" ,w 
nmap <leader>w :w!<CR>

" sudo saves
command W w !sudo tee % > /dev/null

" === VIM UI ===
" j/k moves 7 lines
set so=7

" Height of the command bar
set cmdheight=2

" A buffer becomes hidden when it's abandoned
set hid

" 使用backspace原本的效果
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" 搜索
set ignorecase 
set smartcase
set hlsearch

" regular expressions turn magic on
set magic

" 显示匹配括号
set showmatch
" 显示匹配括号的时间, 2/10 * 1000 = 200ms
set mat=2 

" 取消响铃
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" GVIM
if has("gui_macvim")
	autocmd GUIEnter * set vb t_vb=
endif

" 左侧预留2列
set foldcolumn=2

" === Colors and Fonts
" 语法高亮
syntax enable

" Gnome 终端使用256色
if $COLORTERM == 'gnome-terminal'
	set t_Co=256
endif

" 配色模式
try 
	colorscheme desert
catch
endtry

" 配色模式
set background=dark

" 如果是GUI模式
if has("gui_running")
	set guioptions-=T
	set guioptions-=e
	set t_Co=256
	set guitablabel=%M\ %t
endif

" utf8编码
set encoding=utf8
" 文件类型探测顺序
set ffs=unix,dos,mac

" ==== 文件: 备份和撤销
set nobackup
" wb == writebackup
set nowb
set noswapfile

" === Text, tab, intent
" 使用空格代替tab
set expandtab
" 智能模式
set smarttab
" 1tab=4spaces
set shiftwidth=4
set tabstop=4

" 500个字符换行
" lbr = linebreak, 开启换行模式
set lbr
" tw == textwidth
set tw=500

set autoindent
set smartindent
set wrap

" 可是模式下 * 和# 查找当前选中内容
vnoremap <silent> * :<C-u>call VisualSelection('','')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('','')<CR>?<C-R>=@/<CR><CR>

" 使用空格搜索
map <space> /
" 使用ctrl-space反向搜索
map <c-space> ?
" ,<CR> 取消高亮
map <silent> <leader><CR> :noh<CR>

" 多个窗口移动
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l


" 关闭当前buffer
map <leader>bd :Bclose<CR>:tabclose<CR>gT

" 关闭所有的buffer
map <leader>ba :bufdo bd<CR>

map <leader>l :bnext<CR>
map <leader>h :bprevious<CR>

" 新建tab
map <leader>tn :tabnew<CR>
" 只显示一个tab
map <leader>to :tabonly<CR>
" 关闭tab
map <leader>tc :tabclose<CR>
map <leader>tm :tabmove
" 下一个tab 
map <leader>t<leader> :tabnext

" <leader>tl 当前tab和最后一个访问的tab之间切换
let g:lasttab=1
nmap <leader>tl :exe "tabn".g:lasttab<CR>

"autocmd 事件 文件类型 命令
au TabLeave * let g:lasttab = tabpagenr()

" 在当前文件目录打开一个tab
map <leader>te :tabedit <C-R>=expand("%:p:h")<CR>/

" 切换到当前文件所在的目录
map <leader>cd :cd %:p:h<CR>:pwd<CR>

try
    set switchbuf=useopen,usetab,newtab
    set stal=2
catch
endtry

" 打开文件跳转到最后编辑的地方
" autocmd 事件 文件类型 命令
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" === 状态栏
" 一直显示状态栏
set laststatus=2
" 状态栏格式
set statusline=\ %{HasPaste()}\ %F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c

" remap vim 0 to first non-blank character
map 0 ^

" 移动行 Alt+jk
" 普通模式
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
" 可视模式
vmap <M-j> :m'>+<CR>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<CR>`>my`<mzgv`yo`z

" Command+[jk]
if has("mac") || has("macunix")
    nmap <D-j> <M-j>
    nmap <D-k> <M-k>
    vmap <D-j> <M-j>
    vmap <D-k> <M-k>
endif

" 保存文件时删除末尾空白
fun! CleanExtraSpaces()
    let pos = getpos(".")
    let query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', pos)
    call setreg('/', query)
endfun

if has("autocmd")
    " 这些文件在保存之前删除多余空白
    autocmd BufWritePre *.txt,*.js,*.py,*.sh,*.c,*.cpp,*.h,*.cc,*.cxx,*.go :call CleanExtraSpaces()
endif

" === Spell checking
" ,sc 开启和关闭拼写检查
map <leader>sc :setlocal spell!<CR>

" 拼写修正
" 下一个拼下错误的地方
map <leader>sn ]s
" 上一个拼写错误的地方
map <leader>sp [s
" 使用spellfile修正当前拼写错误的词
map <leader>sa zg
" 当前光标下拼写错误的词该如何修正
map <leader>s? z=


" ==== Functions ====
fun! HasPaste()
    if &paste
        return 'PASTE MODE '
    endif
    return ''
endfun


command! Bclose call <SID>BufcloseCloseIt()
fun! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else 
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfun

fun! CmdLine(str)
    call freekeys(":" . a:str)
endfun

fun! VisualSelection(direction, extra_filter) range
    let l:saved_reg=@"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction = 'gv'
        call CmdLine("Ack '" . l:pattern . "' ")
    elseif a:direction == 'gv'
        call CmdLine("%s" . '/' . l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfun

source ~/.plugins.vimrc

