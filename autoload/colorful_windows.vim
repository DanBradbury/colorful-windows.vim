vim9script

if exists('g:colorful_windows_border_color')
  execute $'highlight BorderHighlightGroup guifg={g:colorful_windows_color} guibg=NONE'
else
  highlight BorderHighlightGroup guifg=#FF8686 guibg=NONE
endif

var ignore_filetypes = exists('g:colorful_windows_ignore_filetypes')
  ? g:colorful_windows_ignore_filetypes
  : ['nerdtree', 'qf']

def Filter(winid: number, key: string): number
  if key ==? "\<LeftMouse>"
    var details = getmousepos()
    cursor(details.winrow, details.wincol - 4)
    return 0
  endif
  return 0
enddef

export def CreateColorfulWindow(): void
  popup_clear()

  if index(ignore_filetypes, &filetype) >= 0
    return
  endif

  if &filetype == 'help'
    set number
  endif

  if tabpagewinnr(tabpagenr(), '$') == 1
    return
  endif

  var border_chars = ['─', '│', '─', '│', '┌', '┐', '┘', '└']
  var max_height = winheight(0)
  var max_width = winwidth(0)
  var pos = win_screenpos(0)
  var win_row = pos[0]
  var win_col = pos[1]
  var popup_mask = [[2, -2, 1, -1]]
  #var popup_mask = [[2, -2, 2, -2]]

  if win_col != 1
    win_col -= 1
  endif

  if win_row > 2
    popup_mask[0][2] = 2
    #popup_mask[0][3] = -2
    win_row -= 1
    #max_height += 1
  endif

  if winnr('l') != winnr() || winnr('h') != winnr()
    max_width -= 1
  else
    max_width -= 2
  endif

  popup_create('',
    {
      line: win_row,
      col: win_col,
      minwidth: max_width,
      minheight: max_height - 1,
      border: [1, 1, 1, 1],
      borderchars: border_chars,
      borderhighlight: ['BorderHighlightGroup'],
      highlight: 'Normal',
      zindex: 1,
      mask: popup_mask,
      filter: Filter
    }
  )
enddef
