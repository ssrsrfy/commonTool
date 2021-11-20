set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
	
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim' " The following are examples of different formats supported.  " Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
	
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
Plugin 'ascenator/L9', {'name': 'newL9'}
	
	
"文件浏览,文件树形结构插件
Plugin 'scrooloose/nerdtree'
	
"想用TAB键配合文件树的插件
Plugin 'jistr/vim-nerdtree-tabs'

Plugin 'kien/ctrlp.vim'

Plugin 'suan/vim-instant-markdown'

Plugin 'nelstrom/vim-markdown-preview'

Plugin 'ervandew/supertab'
	
"语法检测和高亮的插件
"Plugin 'scrooloose/syntastic'
	
"这个小插件可以添加PEP8风格检查
Plugin 'nvie/vim-flake8'
	
"阅读项目
Plugin 'majutsushi/tagbar'
	
"配色方案插件
Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'
	
"代码折叠优化的插件(不安装也不影响折叠,根据个人喜好吧)
Plugin 'tmhedberg/SimpylFold'
	
"解决某些情况下缩进混乱的插件
Plugin 'vim-scripts/indentpython.vim'
	
" cs Plugin	"支持自动补全的最好的插件,非常的难装,99%的人都卡在这个插件
Plugin 'Valloric/YouCompleteMe'

Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
	
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
	
"对YouCompleteMe插件的一个小补充(用不用都可以)
"第一行代码让完成操作后自动补全窗口不会消失
"第二行定义"转到定义"的快捷方式
"let g:ycm_autoclose_preview_window_after_completion=1
"map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
let g:ycm_confirm_extra_conf=0
set runtimepath+=~/.vim/bundle/YouCompleteMe
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_collect_identifiers_from_tag_files = 1             " 开启YCM基于标签引擎
let g:ycm_collect_identifiers_from_comments_and_strings = 1  " 注释与字符串中的内容也用于补全
let g:syntastic_ignore_files=[".*\.py$"]
let g:ycm_seed_identifiers_with_syntax = 1                   " 语法关键字补全
let g:ycm_complete_in_comments = 1
let g:ycm_confirm_extra_conf = 0
let g:ycm_key_list_select_completion = ['<c-n>', '<Down>']   " 映射按键，没有这个会拦截掉tab，导致其他插件的tab不能用
let g:ycm_key_list_previous_completion = ['<c-p>', '<Up>']
let g:ycm_complete_in_comments = 1                          " 在注释输入中也能补全
let g:ycm_complete_in_strings = 1                           " 在字符串输入中也能补全
let g:ycm_collect_identifiers_from_comments_and_strings = 1 " 注释和字符串中的文字也会被收入补全
let g:ycm_global_ycm_extra_conf='~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_show_diagnostics_ui = 0                           " 禁用语法检查
let g:ycm_server_log_level='info'
let g:ycm_min_num_identifier_candidate_chars=2
let g:ycm_key_invoke_completion='<c-z>'
let g:ycm_global_ycm_extra_conf='~/.vim/bundle/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py'
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>" |            " 回车即选中当前项
nnoremap <c-j> :YcmCompleter GoToDefinitionElseDeclaration<CR>|     " 跳转到定义处
nnoremap <c-z> <NOP>

let g:ycm_semantic_triggers={
            \'c,cpp,python,java,go,erlang,perl':['re!\w{2}'],
            \'cs,lua,javascript':['re!w{2}'],
            \}

	
"let g:ycm_python_binary_path  = '/home/brucelau/anaconda3/bin/python3.6'
	
"let g:ycm_python_binary_path  = '/home/brucelau/anaconda3/envs/fcn/bin/python3.7'
"let g:ycm_python_binary_path  = '/home/brucelau/anaconda3/envs/fcn/bin/python2.7'
	
	
"split navigations	"使用ctrl+hjkl代替切换屏幕(建议加上,很方便)
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
	
	
" Enable folding	"开启方法和类的折叠(建议加上,很方便)
set foldmethod=indent
set foldlevel=99
" Enable folding with the spacebar	"使用空格折叠(代替手动折叠)
nnoremap <space> za
"看到折叠代码的文档字符串(可选用)
let g:SimpylFold_docstring_preview=1
	
	
"对其他类型文件配置PEP8风格缩进
au BufNewFile,BufRead *.js, *.html, *.css
\ set tabstop=2
\ set softtabstop=2
\ set shiftwidth=2
	
	
"标示不必要的空白字符
hi BadWhitespace guifg=gray guibg=red ctermfg=gray ctermbg=red
"au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
	
	
"支持UTF-8编码
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936
set fileencoding=utf-8
set termencoding=utf-8
	
	
"让代码变漂亮(根据个人喜好添加)
let python_highlight_all=1
syntax on
	
	
"颜色主题配置
set t_Co=256
let g:solarized_termcolors=256
"let g:solarized_termtrans=1
set background=dark	
colorscheme solarized
	
"显示行号
set nu
"高亮查找
set hlsearch
	 
	 
"配置项目阅读设置
nmap <F8> :TagbarToggle<CR>     "按f8开启关闭
"let g:tagbar_autopreview = 1   "顶部自动预览
let g:tagbar_ctags_bin='/usr/bin/ctags'
let g:tagbar_sort = 0       "关闭自动排序，按照书写顺序排序
let g:tagbar_width=30       "设置窗口宽度
autocmd BufReadPost *.py,*.cpp,*.c,*.h,*.hpp,*.cc,*.cxx call tagbar#autoopen()  "设置在哪些文件中自动开启窗口
	
	 
"目录树
map <F2> : NERDTreeToggle<CR>   "按F2开启关闭
" 自动打开目录树(根据个人喜好选择,我选择不开启)
"autocmd VimEnter * NERDTree
	
	 
"设置括号自动补全
inoremap ' ''<ESC>i
inoremap " ""<ESC>i
inoremap ( ()<ESC>i
inoremap [ []<ESC>i
inoremap { {}<ESC>i
inoremap < <><ESC>i
	
	 
"括号补全后再输入右括号自动忽略
function! RemoveNextDoubleChar(char)
let l:line = getline(".")
let l:next_char = l:line[col(".")] 
if a:char == l:next_char
execute "normal! l"
else
execute   "normal!a". a:char .""
end
endfunction
inoremap ) <ESC>:call RemoveNextDoubleChar(')')<CR>a
inoremap ] <ESC>:call RemoveNextDoubleChar(']')<CR>a
inoremap } <ESC>:call RemoveNextDoubleChar('}')<CR>a
inoremap > <ESC>:call RemoveNextDoubleChar('>')<CR>a
	
	
"实现当删除左边括号的时候,自动删除右括号和括号内的内容(根据自己喜好设置,我是不喜欢)
function! RemovePairs()
let l:line = getline(".")
let l:previous_char = l:line[col(".")-1] 
if index(["(", "[", "{"], l:previous_char) != -1
let l:original_pos = getpos(".")
execute "normal %"
let l:new_pos = getpos(".")
if l:original_pos == l:new_pos
execute "normal! a\<BS>"
return
end
let l:line2 = getline(".")
if len(l:line2) == col(".")
execute "normal! v%xa"
else
execute "normal! v%xi"
end
else
execute "normal! a\<BS>"
end
endfunction
inoremap <BS> <ESC>:call RemovePairs()<CR>a
	
	
"设置背景透明度(选用,开启后,再把终端的透明度打开会很炫酷,至于终端透明度怎么开,百度一大把)
hi Normal ctermfg=252 ctermbg=none
	
	
"设置项目阅读的,个人觉得没有tagbar好用,所以注释掉了
"let Tlist_Auto_Highlight_Tag=1
"let Tlist_Auto_Open=1
"let Tlist_Auto_Update=1
"let Tlist_Display_Tag_Scope=1
"let Tlist_Exit_OnlyWindow=1
"let Tlist_Enable_Dold_Column=1
"let Tlist_File_Fold_Auto_Close=1
"let Tlist_Show_One_File=1
"let Tlist_Use_Right_Window=1
"let Tlist_Use_SingleClick=1
"nnoremap  <F8> :TlistToggle<CR>  
"设定F8为taglist开关
	
	
"设置语言的代码自动补全
filetype plugin on
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascrīpt set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete
	
	
"设置自动缩进
let g:pydiction_location='~/.vim/tools/pydiction/complete-dict'
set autoindent
set tabstop=4
set shiftwidth=4
set expandtab
set number
set backspace=2
"改变行号文字颜色
highlight LineNr ctermfg=red
"改变行号的背景色
"highlight LineNr ctermbg=white
"修改注释颜色
hi Comment ctermfg=6
"光标所在行高亮
set cursorline
highlight CursorLine cterm=NONE ctermbg=gray ctermfg=red

" vim-airline配置
let laststatus=2
"set t_Co=256
let g:airline_powerline_fonts=1
let g:Powerline_symbols='fancy'
"开启tabline
let g:airline#extensions#tabline#enabled=1         " tabline中当前buffer两端的分隔符
let g:airline#extensions#tabline#left_sep=' '      " tabline中未激活buffer两端的分隔符
let g:airline#extensions#tabline#left_alt_sep='|'  " tabline中buffer显示编号
let g:airline#extensions#tabline#buffer_nr_show=1

" 光标配置(gnome_terminator)
if has("autocmd")  
  au InsertEnter * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape ibeam"  
  au InsertLeave * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape block"  
  au VimLeave * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape ibeam"  
endif

" 解决窗口下面显示乱码问题，每当插入时都会显示，这个确实有作用
let &t_TI = ""
let &t_TE = ""
