colorscheme desert

if &diff
    "colors delek 
    colors peaksea
    "colors mydiff
endif

set tags+=./.tags

"11 c/h文件间相互切换 -- 插件: A
""下载地址   http://www.vim.org/scripts/script.php?script_id=31
""将a.vim 放到 ~/.vim/plugin 文件夹中
"":A     在新Buffer中切换到c/h文件
"":AS    横向分割窗口并打开c/h文件
"":AV    纵向分割窗口并打开c/h文件
"":AT    新建一个标签页并打开c/h文件
""快速切换C H源文件
nmap <Leader>aa :A<CR>
nmap <Leader>av :AV<CR>

nnoremap <Leader>gr :Rgrep<CR>
"nnoremap <Leader>gr :cs f e <CR>

"QuickFix窗口
"":cw        // 打开QuickFix窗口
"":cn        // 切换到下一个结果
"":cp        // 切换到上一个结果
""关闭quickfix 
nnoremap <Leader>cq :cclose<CR>
nnoremap <Leader>cw :cw<CR>

"覆盖colorscheme的高亮颜色设置
hi Search term=standout ctermfg=0 ctermbg=3 guifg=Black guibg=Yellow "设置搜索时的高亮颜色,可以通过:hi命令查看有哪些颜色
set nocursorline

"7 文件浏览器和窗口管理器 -- 插件: WinManager
""let g:winManagerWindowLayout='FileExplorer'
"let g:winManagerWindowLayout='TagList'
"nmap wm :WMToggle<cr>
"let g:winManagerWidth=20
"

nmap wn :TlistToggle<cr>
"nnoremap <Leader>sf :TlistToggle<CR>

let NERDTreeWinSize=25
let NERDTreeWinPos="right" " 设置NERDTree子窗口位置
nmap wm :NERDTreeToggle<cr>

"let g:coc_enable_locationlist = 0
"autocmd User CocLocationsChange CocList --no-quit --normal location
"nmap <leader>u <Plug>(coc-references)
nnoremap <c-l> :CocNext<cr>
nnoremap <c-h> :CocPrev<cr>


"nmap <C-]> g]

"10.快速浏览和操作Buffer -- 插件: MiniBufExplorer
nnoremap <Leader>b1 :b1<CR>
nnoremap <Leader>b2 :b2<CR>
nnoremap <Leader>b3 :b3<CR>
nnoremap <Leader>b4 :b4<CR>
nnoremap <Leader>b5 :b5<CR>
nnoremap <Leader>b6 :b6<CR>
nnoremap <Leader>b7 :b7<CR>
nnoremap <Leader>b8 :b8<CR>
nnoremap <Leader>b9 :b9<CR>
nnoremap <Leader>vb1 :vertical sb1<CR>
nnoremap <Leader>vb2 :vertical sb2<CR>
nnoremap <Leader>vb3 :vertical sb3<CR>
nnoremap <Leader>vb4 :vertical sb4<CR>
nnoremap <Leader>vb5 :vertical sb5<CR>
nnoremap <Leader>vb6 :vertical sb6<CR>
nnoremap <Leader>vb7 :vertical sb7<CR>
nnoremap <Leader>vb8 :vertical sb8<CR>
nnoremap <Leader>vb9 :vertical sb9<CR>
let g:miniBufExplMapCTabSwitchBufs = 1

let g:NERDTreeGlyphReadOnly = "RO"

"不显示tabs页签--https://zhuanlan.zhihu.com/p/25946307
set showtabline=0
set shiftwidth=2
set ts=2
set expandtab
set paste

" clang-format                                                                
if has('python')
    map <expr> <C-M> ":pyf " . $HOME . "/local/bin/clang-format.py" . "<cr>"
elseif has('python3')
    map <expr> <C-M> ":py3f " . $HOME . "/local/bin/clang-format.py" . "<cr>"
endif

