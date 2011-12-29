"put must frequently changed items on top

let s:ext_vimfiles_dir = expand('<sfile>:h')

" local default var values
if filereadable(s:ext_vimfiles_dir . '/local_settings.default.vim')
	exec 'source ' . s:ext_vimfiles_dir . '/local_settings.default.vim'
endif

" user can use ~/local_settings.vim file to set some vars
" that is truely local to current system.
if filereadable(expand('~/local_settings.vim'))
	source ~/local_settings.vim
endif

" here begins our main comment settings.

set hidden

execute 'source ' . s:ext_vimfiles_dir . '/load_plugins.vim'

" for clang_complete
if has('win32')
	if !exists('g:my_clang_bin_dir') && exists('g:win_tools_dir')
		let g:my_clang_bin_dir = g:win_tools_dir . '\clang'
	endif
	if !exists('g:my_clang_lib_dir') && exists('g:win_tools_dir')
		let g:my_clang_lib_dir = g:win_tools_dir . '\clang'
	endif
endif

if exists('g:my_clang_bin_dir')
	let g:clang_exec = g:my_clang_bin_dir . '/clang.exe'
endif
if exists('g:my_clang_lib_dir')
	let g:clang_library_path = g:my_clang_lib_dir . '/libclang.dll'
endif


"colo molokai
colo darkblue

" depends on terminal settings
"set tenc=gbk

" remember more command history
set history=1000

" we always use utf-8 as the internal char encoding of vim.
" but 'tenc' should depends on the system's locale
let &tenc = &enc	" because 'enc' defaults is set according to env.
set enc=utf-8
set fileencodings=gbk,utf-8

try
  lang en_US
catch
endtry

"set so=7
set wildmenu
set ruler
set hls

set nocompatible

syn on
filetype plugin on

if has('gui_running')
	set go-=T
else
	set mouse=a
	set ttymouse=xterm2
endif

" from
" http://stackoverflow.com/questions/5547943/display-number-of-current-buffer?1322283757
" Status Line {  
        set laststatus=2                             " always show statusbar  
        set statusline=  
        set statusline+=%-10.3n\                     " buffer number  
        set statusline+=%f\                          " filename   
        set statusline+=%h%m%r%w                     " status flags  
        set statusline+=\[%{strlen(&ft)?&ft:'none'}] " file type  
        set statusline+=%=                           " right align remainder  
        set statusline+=0x%-8B                       " character value  
        set statusline+=%-14(%l,%c%V%)               " line, character  
        set statusline+=%<%P                         " file position  
"}  

" don't need help windows to be restored
set sessionoptions-=help

" always persist Vim's window size
set sessionoptions+=resize

" see
" http://vim.1045645.n5.nabble.com/How-to-store-the-color-scheme-td1172369.html
nmap <F6> :exec ":wa \| mksession! " . v:this_session<CR>
           \ :call writefile(
           \   ['set bg='.&bg, 'color '.colors_name],
           \   fnamemodify(v:this_session, ':p:r') . 'x.vim')<CR> 

" for 'session' plugin
let g:session_autosave = 'yes'
if has('win32')
	let g:session_directory = 's:\ruiheng\vimfiles\sessions'
endif


" ====== for taglist == begin ==
if !exists('Tlist_Ctags_Cmd') || !executable('Tlist_Ctags_Cmd')
	" if user has not set this Tlist_Ctags_Cmd
	if has("win32")
		if exists('g:win_tools_dir')
			" assuming that ctags is installed under 'tools' dir
			let Tlist_Ctags_Cmd = g:win_tools_dir. '\ctags.exe'
		endif
	else
		" for unix
		let Tlist_Ctags_Cmd = '/usr/local/bin/ctags'
	endif
endif

" the trailing ';' is magic
set tags=tags;
" ====== for taglist == end ==


" ====== for vimwiki == begin ==
let wiki_1 = {}
let wiki_1.path = 'z:/svn/vimwiki/default'

let g:vimwiki_list = [wiki_1]

" because ctrl-space will toggle IME
map <leader>tt <Plug>VimwikiToggleListItem

" ====== for vimwiki == end ==


" .................... all settings ends ..............................


" user can use ~/local.vimrc to adjust some settings finally.
" for example, override some settings above.
if filereadable(expand('~/local.vimrc'))
	source ~/local.vimrc
endif

