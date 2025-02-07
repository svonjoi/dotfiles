set number                     " Show current line number
set relativenumber             " Show relative line numbers
filetype plugin on
syntax on


function SetEnglish()
  let $vimlayout = system('xkb-switch -p')
  !xkb-switch -s us
endfunction
function SetOldLayout()
  if $vimlayout != ""
    !xkb-switch -s $vimlayout
  endif
endfunction

autocmd InsertLeave * silent! call SetEnglish()
autocmd InsertEnter * silent! call SetOldLayout()

function! MyFeedKeys()
  call feedkeys("iHello\<CR>Universe!")
endfunction

nmap C :call MyFeedKeys()<CR>
