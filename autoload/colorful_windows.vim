vim9script

if exists('g:colorful_windows_border_color')
  execute $'highlight BorderHighlightGroup guifg={g:colorful_windows_color} guibg=NONE'
else
  highlight BorderHighlightGroup guifg=#FF8686 guibg=NONE
endif

export def CreateColorfulWindow(): void
  popup_clear()

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

  if win_row > 2
    popup_mask[0][2] = 2
    popup_mask[0][3] = -2
    win_row -= 1
  endif

  popup_create('',
    {
      line: win_row,
      col: win_col,
      minwidth: max_width - 1,
      minheight: max_height - 1,
      border: [1, 1, 1, 1],
      borderchars: border_chars,
      borderhighlight: ['BorderHighlightGroup'],
      highlight: 'Normal',
      zindex: 1,
      mask: popup_mask
    }
  )
enddef
