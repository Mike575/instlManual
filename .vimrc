
set nocompatible              " required
filetype off                  " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
" let Vundle manage Vundle, required
<strong>Plugin 'gmarik/Vundle.vim'</strong>
Plugin 'vim-scripts/indentpython.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'vim-syntastic/syntastic'
Plugin 'nvie/vim-flake8' "<F7> to run checking
Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'Lokaltog/vim-powerline'
Plugin 'Yggdroot/indentLine'
Plugin 'tell-k/vim-autopep8'
Plugin 'jiangmiao/auto-pairs'
Plug 'scrooloose/nerdcommenter'
Plugin 'jnurmine/Zenburn'
Plugin 'kien/ctrlp.vim'
" Add all your plugins here (note older versions of Vundle used Bundle instead of Plugin)
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
syntax enable
syntax on
set background = light " dark
"colorscheme solarized
"colorscheme Zenburn
"colorscheme desert
"colorscheme evening
colorscheme default

" Ctrl + n to use Tree
map <C-n> :NERDTreeToggle<CR> 
let NERDTreeIgnore=['\~$', '\.pyc$', '\.swp$']
" <F8> to autoindent
autocmd FileType python noremap <buffer> <F8> :call Autopep8()<CR>

set nocompatible "关闭与vi的兼容模式
set number "显示行号
set nowrap    "不自动折行
set showmatch    "显示匹配的括号
set scrolloff=3        "距离顶部和底部3行"
set encoding=utf-8  "编码
set fenc=utf-8      "编码
set mouse=a        "启用鼠标
set hlsearch        "搜索高亮
syntax on    "语法高亮

au BufNewFile,BufRead *.py
set tabstop=4   "tab宽度
set softtabstop=4 
set shiftwidth=4  
set textwidth=79  "行最大宽度
" set expandtab       "tab替换为空格键
set autoindent      "自动缩进
set fileformat=unix   "保存文件格式

set foldmethod=indent
set foldlevel=3

let mapleader = ","
map <F5> :call RunPython()<CR>
func! RunPython()
    exec "W"
    if &filetype == 'python'
        exec "!time python3.6 %"
	endif
endfunc

map <leader>- <F5>

let g:ycm_auto_trigger = 1   "turn on
"let g:ycm_auto_trigger = 0   "turn off
let g:ycm_min_num_of_chars_for_completion = 2  "开始补全的字符数"
let g:ycm_python_binary_path = 'python'  "jedi模块所在python解释器路径"
let g:ycm_seed_identifiers_with_syntax = 1  "开启使用语言的一些关键字查询"
let g:ycm_autoclose_preview_window_after_completion=1 "补全后自动关闭预览窗口"
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>


hi Number ctermfg = lightblue  
hi Constant ctermfg = lightblue 
hi Statement ctermfg = green 
hi String ctermfg = lightblue 
hi Comment ctermfg = green 
hi Special ctermfg = yellow
hi PreProc ctermfg = green
hi Type ctermfg = lightblue
hi LineNr ctermfg = lightblue
hi Function ctermfg = lightblue

" Ctrl + K 插入模式下光标向上移动
imap <c-k> <Up>

" Ctrl + J 插入模式下光标向下移动
imap <c-j> <Down>

" Ctrl + H 插入模式下光标向左移动
imap <c-h> <Left>

" Ctrl + L 插入模式下光标向右移动
imap <c-l> <Right>

" Ctrl + f 光标跳转到行头
imap <c-f> <ESC>0i

" Ctrl + e 光标跳转到行尾
imap <c-e> <ESC>$i

" 全选
nmap <c-a> ggVG$
imap <c-a> <ESC>ggVG$

" -----------------------------------------------------------------------------
"  < 新文件标题 >
" -----------------------------------------------------------------------------
"新建.c,.h,.sh,.java文件，自动插入文件头
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.rb,*.java,*.py exec ":call SetTitle()"
""定义函数SetTitle，自动插入文件头
func SetTitle()
    "如果文件类型为.sh文件
    if &filetype == 'sh'
        call setline(1,"\#!/bin/bash")
        call append(line("."), "")
    elseif &filetype == 'python'
        call setline(1,"#!/usr/bin/env python")
        call append(line("."),"# coding=utf-8")
        call append(line(".")+1, "")

    elseif &filetype == 'ruby'
        call setline(1,"#!/usr/bin/env ruby")
        call append(line("."),"# encoding: utf-8")
        call append(line(".")+1, "")

"    elseif &filetype == 'mkd'
"        call setline(1,"<head><meta charset=\"UTF-8\"></head>")
    else
        call setline(1, "/*************************************************************************")
        call append(line("."), "    > File Name: ".expand("%"))
        call append(line(".")+1, "  > Author: Hou")
        call append(line(".")+2, "  > Mail: 745189913@qq.com")
        call append(line(".")+3, "  > Created Time: ".strftime("%c"))
        call append(line(".")+4, " ************************************************************************/")
        call append(line(".")+5, "")
    endif
    if expand("%:e") == 'cpp'
        call append(line(".")+6, "#include<iostream>")
        call append(line(".")+7, "using namespace std;")
        call append(line(".")+8, "")
    endif
    if &filetype == 'c'
        call append(line(".")+6, "#include<stdio.h>")
        call append(line(".")+7, "")
    endif
    if expand("%:e") == 'h'
        call append(line(".")+6, "#ifndef _".toupper(expand("%:r"))."_H")
        call append(line(".")+7, "#define _".toupper(expand("%:r"))."_H")
        call append(line(".")+8, "#endif")
    endif
    if &filetype == 'java'
        call append(line(".")+6,"public class ".expand("%:r"))
        call append(line(".")+7,"")
    endif
    "新建文件后，自动定位到文件末尾
endfunc
autocmd BufNewFile * normal G
