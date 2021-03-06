" Map leader to which_key
nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>

" Create map to add keys to
let g:leader_map =  {}
let g:localleader_map =  {}
" Define a separator
let g:which_key_sep = '→'
" set timeoutlen=100
" Don't float
let g:which_key_use_floating_win = 0

" Change the colors if you want
highlight default link WhichKey          Operator
highlight default link WhichKeySeperator DiffAdded
highlight default link WhichKeyGroup     Identifier
highlight default link WhichKeyDesc      Function

" Hide status line
autocmd! FileType which_key
autocmd  FileType which_key set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 noshowmode ruler

" leader mappings
let g:leader_map['c'] = [ ':!pwd'                            , 'Current working dir' ]
let g:leader_map['f'] = [ 'Files'                            , 'Search all files in current Git Repo' ]
let g:leader_map['F'] = [ 'Find'                             , 'Custom Find() Use Rg + Fzf to find files' ]
let g:leader_map['h'] = [ '<C-W>s'                           , 'split below']
let g:leader_map['j'] = [ '<C-W>w'                           , 'jump splits']
"let g:leader_map['t'] = [ ':Reserved - Don't use            , 'This is already being mapped via floaterm.vim, do not re-use it.']
let g:leader_map['t'] = [ ':FloatermToggle'                  , 'Toggle Floaterm, space space also does this']
let g:leader_map['o'] = [ ':set conceallevel=0'              , 'No Conceal' ]
let g:leader_map['p'] = [ '<M-p>'                            , 'Toggle Autopairs' ]
let g:leader_map['q'] = [ '<c-c>'                            , 'Quit FZF search' ]
let g:leader_map['w'] = [ ':!tmux new-window bash -ci fp'    , 'Switch tmux sessions' ]
"let g:leader_map['r'] = [ ':Reserved - Don't use            , 'Plan to use this to run files similar to F8.' ]
let g:leader_map['v'] = [ '<C-W>v'                           , 'split right']
let g:leader_map['y'] = [ ':FloatermSend pytest'             , 'Send pytest to floatterm' ]
let g:leader_map['1'] = [ '<Plug>AirlineSelectTab1'          , 'Switch to airline tab 1' ]
let g:leader_map['2'] = [ '<Plug>AirlineSelectTab2'          , 'Switch to airline tab 2' ]
let g:leader_map['3'] = [ '<Plug>AirlineSelectTab3'          , 'Switch to airline tab 3' ]
let g:leader_map['4'] = [ '<Plug>AirlineSelectTab4'          , 'Switch to airline tab 4' ]
let g:leader_map['5'] = [ '<Plug>AirlineSelectTab5'          , 'Switch to airline tab 5' ]
let g:leader_map['6'] = [ '<Plug>AirlineSelectTab6'          , 'Switch to airline tab 6' ]
let g:leader_map['7'] = [ '<Plug>AirlineSelectTab7'          , 'Switch to airline tab 7' ]
let g:leader_map['8'] = [ '<Plug>AirlineSelectTab8'          , 'Switch to airline tab 8' ]
let g:leader_map['9'] = [ '<Plug>AirlineSelectTab9'          , 'Switch to airline tab 9' ]

let g:leader_map.a = {
      \ 'name' : '+neoformat' ,
      \ 'p' : ['Neoformat'        , 'Run Neoformat on Python files'],
      \ }

let g:leader_map.e = {
      \ 'name' : '+edit' ,
      \ 'r' : [':call EditLangFile("rb")'            , 'Open a ruby tmp file for editing'],
      \ 'g' : [':call EditLangFile("go")'            , 'Open a go tmp file for editing'],
      \ }

let g:leader_map.n = {
      \ 'name' : '+floatterm: ' ,
      \ 'f' : [':Floaterms'           , 'Use fzf to find terms'],
      \ 'n' : [':FloatermNext'        , 'Next Floaterm'],
      \ 'p' : [':FloatermPrev'        , 'Prev Floaterm'],
      \ 'a' : [':FloatermSend mp a'   , 'Make public algorithms'],
      \ 'd' : [':FloatermSend mp d'   , 'Make public dky'],
      \ 'k' : [':FloatermSend mp k'   , 'Make public keycap'],
      \ 'g' : [':call FtGo()'         , 'Open go specific floaterm'],
      \ 't' : [':FloatermSend --name=go go test'      , 'Go test to a term'],
      \ }


let g:leader_map.m = {
      \ 'name' : '+misc' ,
      \ 'c' : [':call CloseAllBuffersButCurrent()'   , 'close all buffers except current'],
      \ '1' : [':call CreateDailyFolder()'           , 'create folder with current date'],
      \ '2' : [':call CopyCurrentFile()'             , 'create copy of current file'],
      \ 'b' : [':set ft=sh'                          , 'Set filetype to sh'],
      \ 'p' : [':set ft=python'                      , 'Set filetype to python'],
      \ 'r' : [':FloatermNew ranger'                 , 'Call ranger from floaterm'],
      \ }

let g:leader_map.s = {
      \ 'name' : '+search' ,
      \ 'b' : [':BLines'        , 'Search current buffer'],
      \ 'B' : [':Lines'         , 'Search all **open** buffers'],
      \ 'f' : [':GFiles'        , 'Search only Git checked in files'],
      \ }

" localleader \ mappings
let g:localleader_map['t'] = [ 'TestFile'                   , 'TestFile']
let g:localleader_map['q'] = [ '<c-c>'                      , 'Quit FZF search' ]

let g:localleader_map.g = {
      \ 'name' : '+go' ,
      \ 'f' : [':GoFmt'         , 'Go Fmt']
      \ }

let g:localleader_map.c = {
      \ 'name' : '+codi' ,
      \ 'c' : [':Codi'         , 'Start Codi'],
      \ 'd' : [':Codi!'        , 'Deactivate Codi'],
      \ 't' : [':Codi!!'       , 'Toggle Codi'],
      \ }

let g:localleader_map.1 = {
      \ 'name' : '+test' ,
      \ 't' : [':TestFile'        , 'TestFile'],
      \ }

" Register which key map
call which_key#register('<Space>', "g:leader_map")
call which_key#register(',', "g:localleader_map")

"Clear out highlighting from search
map <silent><leader>l :nohl<CR>
" Space + Space brings up toggles floaterm
nmap <silent><leader><leader> :FloatermToggle<CR>
