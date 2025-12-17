vim9script

import autoload 'colorful_windows.vim' as colorful

if exists('g:loaded_colorful_windows')
  finish
endif
g:loaded_colorful_windows = 1

augroup ColorfulWindows
  autocmd!
  autocmd WinEnter,WinResized,BufWinEnter,VimResized * call colorful.CreateColorfulWindow()
augroup END
