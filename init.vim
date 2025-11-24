call plug#begin('~/.local/share/nvim/plugged')
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
"    Plug 'joshdick/onedark.vim'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
    Plug 'easymotion/vim-easymotion'
    Plug 'octol/vim-cpp-enhanced-highlight'
    Plug 'luochen1990/rainbow'
    Plug 'inkarkat/vim-ingo-library'
    Plug 'inkarkat/vim-mark'
    Plug 'tpope/vim-fugitive'
    Plug 'Yggdroot/indentLine'
    Plug 'junegunn/fzf'
    Plug 'junegunn/fzf.vim'
    Plug 'preservim/nerdtree'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'majutsushi/tagbar'
"    Plug 'crusoexia/vim-monokai'
call plug#end()

" theme
"let g:onedark_terminal_italics=1
"colorscheme onedark

"let g:onedark_config = {
"    \ 'style': 'warm',
"\}
syntax enable
syntax on
"set background=light
"let g:colors_name="white"
"colorscheme monokai
set clipboard+=unnamedplus
"关闭鼠标
set mouse=
inoremap [ []<ESC>i
inoremap { {}<ESC>i
inoremap " ""<ESC>i
inoremap ' ''<ESC>i
" Miscellaneous
let mapleader=" "
filetype plugin indent on
set expandtab
set softtabstop=4
set tabstop=4
set shiftwidth=4
set smartindent
set smartcase
set splitbelow
set splitright
" set wildignorecase
set ignorecase
"set colorcolumn=80
set cursorline
" cursorcolumn cause performance issue
" set cursorcolumn
set ruler
set nowrap
set number relativenumber
set termguicolors
"syntax enable
"syntax on
set hidden
" fix terminal last line issue
let g:neoterm_autoscroll=1
set ttimeoutlen=100
set enc=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1 "编码自动识别

set wildoptions=pum
set pumblend=20
set pumheight=15
set signcolumn=yes

"reload file
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

" key binding

" Press F4 to toggle highlighting on/off, and show current value.
noremap <F5> :set hlsearch! hlsearch?<CR>

nnoremap <M-h> <C-w>h
nnoremap <M-j> <C-w>j
nnoremap <M-k> <C-w>k
nnoremap <M-l> <C-w>l

nnoremap <M-=> <C-w>=

nnoremap <M-q> :q<CR>
nnoremap <M-w> :w<CR>

autocmd BufNewFile,BufRead *.h set ft=c

function Cd_cur_dir()
        cd %:p:h
        pwd
endfunction
noremap g. :call Cd_cur_dir()<CR>

" ++++++++++++++++++ whitespace +++++++++++++++++++++++++++++++++++
fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun
command! TrimWhitespace call TrimWhitespace()
" ++++++++++++++++++ whitespace +++++++++++++++++++++++++++++++++++

" +++++++++++++++++ easymotion start ++++++++++++++++++++++++++++++
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap s <Plug>(easymotion-s2)
vmap s <Plug>(easymotion-s2)
" Turn on case-insensitive feature
let g:EasyMotion_smartcase = 1
let g:EasyMotion_do_mapping = 0 " Disable default mappings
" +++++++++++++++++ easymotion end ++++++++++++++++++++++++++++++++

" ++++++++++++++++++ airline begin ++++++++++++++++++++++++++++++++
"airline状态栏配置
"这个是安装字体后 必须设置此项"
let g:airline_powerline_fonts = 0

"打开tabline功能,方便查看Buffer和切换,省去了minibufexpl插件
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

let g:airline#extensions#tabline#formatter = 'unique_tail'

" " 关闭状态显示空白符号计数
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#whitespace#symbol = '!'
" " 设置consolas字体"前面已经设置过
" " set guifont=Consolas\ for\ Powerline\ FixedD:h11
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

"设置切换Buffer快捷键"
map <c-Left> :bp<CR>    " 切换到上一个
map <c-Right> :bn<CR>   " 切换到下一个
map <F3> :bd<CR>        " 关闭当前窗口
map 11 :b1<CR>          " 切换到编号1
map 22 :b2<CR>          " 切换到编号2
map 33 :b3<CR>          " 切换到编号3
map 44 :b4<CR>          " 切换到编号4
map 55 :b5<CR>          " 切换到编号5
map 66 :b6<CR>          " 切换到编号6
map 77 :b7<CR>          " 切换到编号7
map 88 :b8<CR>          " 切换到编号8
map 99 :b9<CR>          " 切换到编号9
map 00 :b10<CR>         " 切换到编号10
" +++++++++++++++++ airline end +++++++++++++++++++++++++++++++++++

" +++++++++++++++++ indentLine begin ++++++++++++++++++++++++++++++
let g:indent_guides_guide_size = 1 " 指定对齐线的尺寸
let g:indent_guides_start_level = 2 " 从第二层开始可视化显示缩进
" +++++++++++++++++ indentLine end ++++++++++++++++++++++++++++++++

" +++++++++++++++++ highlight begin +++++++++++++++++++++++++++++++
" cpp-enhanced-highlight c/c++ 语法高亮配置
" 默认情况下，不突出显示类范围。启用设置
let g:cpp_class_scope_highlight = 1

" 默认情况下，成员变量突出显示为禁用状态。启用设置
let g:cpp_member_variable_highlight = 1

" 默认情况下，在声明中高亮显示类名。启用设置
let g:cpp_class_decl_highlight = 1

" POSIX功能的突出显示默认情况下处于禁用状态。启用设置
let g:cpp_posix_standard = 1

" 有两种突出显示模板功能的方法。要么
let g:cpp_experimental_simple_template_highlight = 1

" 在大多数情况下都可以使用，但是在大文件上可能会有点慢。替代设置
let g:cpp_experimental_template_highlight = 1

" 这是一个较快的实现，但是在某些极端情况下它不起作用。
" 注意：众所周知，C ++模板语法很难解析，因此不要指望此功能是完美的。
" 库概念的突出显示由
let g:cpp_concepts_highlight = 1

" 这将突出显示关键字的概念，要求以及标准库中的所有命名要求（例如DefaultConstructible）
" 可以通过以下方式禁用突出显示用户定义的功能
let g:cpp_no_function_highlight = 1
" +++++++++++++++++ highlight end +++++++++++++++++++++++++++++++++

" +++++++++++++++++ rainbow begin +++++++++++++++++++++++++++++++++
let g:rainbow_active = 1
let g:rainbow_conf = {
\   'guifgs': ['darkorange3', 'seagreen3', 'royalblue3', 'firebrick'],
\   'ctermfgs': ['lightyellow', 'lightcyan','lightblue', 'lightmagenta'],
\   'operators': '_,_',
\   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
\   'separately': {
\       '*': {},
\       'tex': {
\           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
\       },
\       'lisp': {
\           'guifgs': ['darkorange3', 'seagreen3', 'royalblue3', 'firebrick'],
\       },
\       'vim': {
\           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
\       },
\       'html': {
\           'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
\       },
\       'css': 0,
\   }
\}
"参考网址:https://www.cnblogs.com/cniwoq/p/13272746.html
" +++++++++++++++++ rainbow end +++++++++++++++++++++++++++++++++++

" +++++++++++++++++ vim-mark begin ++++++++++++++++++++++++++++++++
nmap <Leader>M <Plug>MarkToggle
nmap <Leader>N <Plug>MarkAllClear
" +++++++++++++++++ vim-mark end ++++++++++++++++++++++++++++++++++

" +++++++++++++++++ nerdtree begin ++++++++++++++++++++++++++++++++
" autocmd vimenter * NERDTree "自动开启Nerdtree
let g:NERDTreeWinSize = 25 "设定 NERDTree 视窗大小
let NERDTreeShowBookmarks=1 " 开启Nerdtree时自动显示Bookmarks

" 打开vim时如果没有文件自动打开NERDTree
" autocmd vimenter * if !argc()|NERDTree|endif
" 当NERDTree为剩下的唯一窗口时自动关闭
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" 设置树的显示图标
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'
" let NERDTreeIgnore = ['.pyc$'] " 过滤所有.pyc文件不显示
let g:NERDTreeShowLineNumbers=0 " 是否显示行号
let g:NERDTreeHidden=0 "不显示隐藏文件
" Making it prettier
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
nnoremap <F1> :NERDTreeToggle<CR>:NERDTreeRefreshRoot<CR> " nerdtree
nn <silent><F1><F1> :NERDTreeFind<CR>
" nnoremap <F1> :NERDTreeToggle<CR> " 开启/关闭nerdtree快捷键
" +++++++++++++++++ nerdtree end ++++++++++++++++++++++++++++++++++

" +++++++++++++++++ coc.nvim begin ++++++++++++++++++++++++++++++++
" if hidden is not set, TextEdit might fail.
set hidden
" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup
" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap ' to make sure tab is not mapped by other plugin.
inoremap pumvisible() ? "" : check_back_space() ? "" : coc#refresh()
inoremap pumvisible() ? "" : ""
function! s:check_back_space() abort
let col = col('.') - 1
return !col || getline('.')[col - 1] =~# 's'
endfunction
" Use to trigger completion.
inoremap coc#refresh()
" Use to confirm completion, `u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap pumvisible() ? "" : "u"
" Or use `complete_info` if your vim support it, like:
" inoremap complete_info()["selected"] != "-1" ? "" : "u"
" Use `[g` and `]g` to navigate diagnostics
nmap [g (coc-diagnostic-prev)
nmap ]g (coc-diagnostic-next)
" Remap keys for gotos
nmap gd (coc-definition)
nmap gy (coc-type-definition)
nmap gi (coc-implementation)
nmap gr (coc-references)
" Use K to show documentation in preview window
nnoremap K :call show_documentation()
function! s:show_documentation()
if (index(['vim','help'], &filetype) >= 0)
execute 'h '.expand('')
else
call CocAction('doHover')
endif
endfunction
" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')
" Remap for rename current word
nmap rn (coc-rename)
" Remap for format selected region
xmap f (coc-format-selected)
nmap f (coc-format-selected)
augroup mygroup
autocmd!
" Setup formatexpr specified filetype(s).
autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
" Update signature help on jump placeholder
autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end
" Remap for do codeAction of current line
nmap ac (coc-codeaction)
" Fix autofix problem of current line
nmap qf (coc-fix-current)
" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if (coc-funcobj-i)
xmap af (coc-funcobj-a)
omap if (coc-funcobj-i)
omap af (coc-funcobj-a)
" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')
" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call CocAction('fold', )
" use `:OR` for organize import of current buffer
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')
" +++++++++++++++++ coc.nvim end ++++++++++++++++++++++++++++++++++

" +++++++++++++++++ tagbar begin ++++++++++++++++++++++++++++++++++
nnoremap <silent> <F2> :TagbarToggle<CR>  " tagbar
let g:tagbar_autofocus=0          " 设置光标默认在tagbar页面内
let g:tagbar_width=40             " 设置宽度40，默认30
let g:tagbar_sort=0               " 设置默认不排序
" +++++++++++++++++ tagbar end ++++++++++++++++++++++++++++++++++++

" +++++++++++++++++ LeaderF begin +++++++++++++++++++++++++++++++++
let g:Lf_HideHelp = 1
let g:Lf_UseCache = 0
let g:Lf_UseVersionControlTool = 0
let g:Lf_IgnoreCurrentBufferName = 1
" popup mode
let g:Lf_WindowPosition = 'popup'
let g:Lf_StlSeparator = { 'left': "\ue0b0", 'right': "\ue0b2", 'font': "DejaVu Sans Mono for Powerline" }
let g:Lf_PreviewResult = {'Function': 0, 'BufTag': 0 }
let g:Lf_GtagsSkipUnreadable = 1
let g:Lf_GtagsAutoUpdate = 1
let g:Lf_RootMarkers = ['.repo', '.workspace']
let g:Lf_GtagsStoreInProject = 1
let g:Lf_GtagsStoreInRootMarker = 1
let g:Lf_ShortcutF = '<m-o>'

"file search setting and ignore path setting
nnoremap <leader>ff :LeaderfFile ~<cr>
nnoremap <leader>f :LeaderfFile<cr>
noremap <m-f> :LeaderfFunction!<cr>
let g:Lf_WildIgnore = {
            \ 'dir': ['.svn','.git','.hg','.vscode','.wine','.deepinwine','.oh-my-zsh', '.repo','out'],
            \ 'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]']
            \}

noremap <leader>t :<C-U><C-R>=printf("Leaderf! bufTag %s ", "")<CR><CR>
noremap <leader>fb :<C-U><C-R>=printf("Leaderf buffer %s", "")<CR><CR>
noremap <leader>fm :<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>
noremap <leader>fu :<C-U><C-R>=printf("Leaderf rg -e %s ", expand("<cword>"))<CR><CR>
noremap <leader>ft :<C-U><C-R>=printf("Leaderf bufTag %s", "")<CR><CR>
noremap <leader>fl :<C-U><C-R>=printf("Leaderf line %s", "")<CR><CR>
noremap <leader>fh :<C-U><C-R>=printf("Leaderf cmdHistory %s", "")<CR><CR>
noremap <leader>fg :<C-U><C-R>=printf("Leaderf gtags %s", "")<CR><CR>

noremap <C-B> :<C-U><C-R>=printf("Leaderf! rg --current-buffer -e %s ", expand("<cword>"))<CR>
noremap <C-F> :<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR>

noremap <leader>fr :<C-U><C-R>=printf("Leaderf! gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <leader>fd :<C-U><C-R>=printf("Leaderf! gtags -d %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <leader>fo :<C-U><C-R>=printf("Leaderf! gtags --recall %s", "")<CR><CR>
noremap zn :<C-U><C-R>=printf("Leaderf gtags --next %s", "")<CR><CR>
noremap zp :<C-U><C-R>=printf("Leaderf gtags --previous %s", "")<CR><CR>
xnoremap gf :<C-U><C-R>=printf("Leaderf! rg -F -e %s ", leaderf#Rg#visual())<CR>

noremap gd :<C-U><C-R>=printf("Leaderf! gtags --by-context --match-path --auto-jump")<CR><CR>

let $GTAGSLABEL = 'native-pygments'
let $GTAGSCONF = '/home/docker/bin/share/gtags/gtags.conf'
" +++++++++++++++++ LeaderF end +++++++++++++++++++++++++++++++++++
