# ZMK Config

## Philosophy

- heavily inspired by [urob config](https://github.com/urob/zmk-config) (combos > layers)
- common symbols for JS/TS are prioritized (some deviaton from urob config here)
  - Brace is available on bottom row, bracket on top row. I keep a dedicated backspace and don't really use delete (I use `x` in vim)
  - Swap back vertical combo & to be below 7 with | below - I do more logical compares than maths so this made sense for my use and it follows the number symbol row more closely
  - Horizontal combos on the left middle row for undo, redo, and select all. Along with cut/copy/paste (bottom row combos) this allows for most text related actions I need while using a mouse, all on left hand.
- homerow mods ("Timeless" per urob) Homerow follows ACGS mods
  - This leaves my tiling window navigation keys (Gui, Gui + SHIFT) close by (_\* see [OS Accommmodations](#os-accommodations) below_)
- navigation layers
  - with the tiling window shortcuts above, i have the `space` and `move` layers set up for single handed window movement if needed (eg, while using mouse)
- Key / shift remap (per urob)
  - ? / ! are combined, with f slash (/) available via combo (per urob)
  - , / ; and . / : on tap, shift tap. < / > are available as shifted parens combos (homerow)
- Macros
  - javascript function macros on top, bottom rows via combo. these place the cursor inside the parens.
- vim like nav on base/nav layers

## OS Accommodations

- Mods - Karabiner remaps Gui -> Ctrl and Ctrl -> Gui, this keeps consistent mod "intentions" across OS

## Layer Explanation

- combos are available on base, nav, num layers.
- `num` layer provides a southpaw numpad.
- `nav` layer overlays arrow keys over hjkl for easier navigation in non-vim settings. The numpad also has `LG()` applied to all numbers for space changing. there are shortcuts for alfred and mission control on the homerow.
- `mv` provides single handed window space movement (mod+shift applied over num layer). This is accessed via a double tap of the `NAV` layer key.
- `util` is a conditional layer triggered by activating num/nav. this is a bit of a dumping ground for os/media/zmk utils.

### Combos

![keymap](/draw/combos.svg)

### Layers

![keymap](/draw/corne.svg)
