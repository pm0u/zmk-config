# ZMK Config — Agent Reference

36-key Corne split keyboard. Left half: 5×3 + 3 thumb keys. Right half: same.

## Key Position Naming

```
╭─────────────────────────────╮ ╭─────────────────────────────╮
│ LT4 LT3 LT2 LT1 LT0        │ │ RT0 RT1 RT2 RT3 RT4         │
│ LM4 LM3 LM2 LM1 LM0        │ │ RM0 RM1 RM2 RM3 RM4         │
│ LB4 LB3 LB2 LB1 LB0        │ │ RB0 RB1 RB2 RB3 RB4         │
╰────────╮ LH2 LH1 LH0       │ │       RH0 RH1 RH2 ╭─────────╯
         ╰────────────────────╯ ╰────────────────────╯
```

Numeric equivalents (used in combo `keypos` and HRM `hold-trigger-key-positions`):
- Left top row: 0–4 (LT4=0 … LT0=4)
- Left home row: 10–14 (LM4=10 … LM0=14)
- Left bottom row: 20–24 (LB4=20 … LB0=24)
- Left thumbs: 30–32 (LH2=30, LH1=31, LH0=32)
- Right mirrors: +5 for top/home/bottom, RH0=33, RH1=34, RH2=35

Key clusters used by HRM trigger positions:
```c
#define KEYS_L  LT0 LT1 LT3 LT4 LM0 LM1 LM2 LM3 LM4 LB0 LB1 LB2 LB3 LB4
#define KEYS_R  RT0 RT1 RT3 RT4 RM0 RM1 RM2 RM3 RM4 RB0 RB1 RB2 RB3 RB4
#define THUMBS  LH0 LH1 LH2 RH0 RH1 RH2
```

## Layers

| # | Name | Activation |
|---|------|-----------|
| 0 | BASE | Default |
| 1 | NUM  | Hold RH2 (`&lt NUM K_CANCEL`) |
| 2 | NAV  | Hold LH2 (`&nav`, single tap) |
| 3 | MV   | Double-tap LH2 (`&nav`) |
| 4 | UTIL | Conditional: NUM + NAV simultaneously |
| 5 | FKEY | Chord: LH0 + RH0 (space + return) |

UTIL is defined in `behaviors.dtsi`:
```c
ZMK_CONDITIONAL_LAYER(util, NAV NUM, UTIL)
```

## Spatial Convention — the Numpad Grid

NAV, MV, and UTIL all use the same spatial layout on the left hand, mirroring the numpad. When adding new bindings to these layers, follow this grid:

```
_    7    8    9    _       ← LT row
_    4    5    6    _       ← LM row  (home row mods on NAV)
_    1    2    3    _       ← LB row
          .    0    _       ← thumb (LH2=special, LH1=0, LH0=dot)
```

- `LM4` and `LB4` (outer left column) are used for special/mode keys (e.g., `OUT_BLE`, `OUT_USB`)
- `LM0` (inner left column, home row) is for actions like `BT_CLR` or `LG(SEMI)`

## File Organization

```
config/
├── base.keymap          # All layer bindings — edit this for layout changes
├── corne.keymap         # Device entry point; defines KEYS_L/R/THUMBS
├── corne.conf           # Hardware config (BLE power, sleep, keyboard name)
└── shared/
    ├── setup.dtsi       # HRM macro, key clusters, inline macros (ARROWS/FOCUS/MOVE)
    ├── behaviors.dtsi   # Mod-morphs, tap-dance wrappers, conditional layer
    ├── combos.dtsi      # All combos
    ├── macros.dtsi      # ZMK_MACRO definitions (fn_opn, fn_impl)
    └── helpers.h        # #define ___ &trans
```

## Home Row Mods

Defined via `MAKE_HRM` in `setup.dtsi`. Two instances:
```c
MAKE_HRM(hml, &kp, &kp, KEYS_R THUMBS)  // left hand: ALT-GUI-SHIFT-CTRL on A-S-D-F
MAKE_HRM(hmr, &kp, &kp, KEYS_L THUMBS)  // right hand: CTRL-SHIFT-GUI-ALT on J-K-L-'
```

Key parameters: `tapping-term-ms = 300`, `require-prior-idle-ms = 200`, `flavor = "balanced"`, `hold-trigger-on-release`.

To use HRMs on other layers (e.g., NUM layer has `&hml LGUI N4`), use the same `hml`/`hmr` behaviors.

## Adding Combos

Use `ZMK_COMBO` from `zmk-helpers`. Standard form (6-arg):
```c
ZMK_COMBO(name, &binding, KEYPOS, LAYERS, COMBO_TERM, COMBO_IDLE)
```

8-arg form (adds hold modifier guard — prevents false triggers during HRM use):
```c
ZMK_COMBO_8(name, &kp KEY, KEYPOS, LAYERS, COMBO_TERM, COMBO_IDLE, HOLD_KEY, BLOCKED_SIDE)
```
The 8-arg form creates a temporary HRM behavior to gate the combo. Used for TAB and ESC on the home row.

Timing constants:
```c
#define COMBO_TERM_FAST 20    // horizontal adjacent keys
#define COMBO_TERM_SLOW 40    // vertical (same-column) keys
#define COMBO_IDLE_FAST 150
#define COMBO_IDLE_SLOW 60
```

All combos are active on `BASE NAV NUM` layers. Add new combos to `shared/combos.dtsi`.

## Behaviors

### Mod-Morphs (`behaviors.dtsi`)

```c
SIMPLE_MORPH(name, MOD, &kp NORMAL, &kp SHIFTED)
```

Existing: `qexcl` (?/!), `lpar_lt` ((/\<), `rpar_gt` ()/\>), `comma_semi` (,/;), `dot_colon` (./:), `smart_shft` (sticky-shift/caps-word).

### Tap-Dance Wrappers

Zero-tapping-term tap-dance behaviors that wrap keys to sidestep HRM timing in combos:
```c
ZMK_BEHAVIOR(tab, tap_dance, tapping-term-ms = <0>; bindings = <&kp TAB>;)
ZMK_BEHAVIOR(esc, tap_dance, tapping-term-ms = <0>; bindings = <&kp ESC>;)
```
Also `l_than`, `g_than`. Use this pattern when a combo key would be swallowed by HRM hold detection.

### Nav Tap-Dance

```c
ZMK_BEHAVIOR(nav, tap_dance, tapping-term-ms = <250>; bindings = <&mo NAV>, <&mo MV>;)
```
Single tap → NAV layer, double-tap → MV layer.

## Inline Macros (`setup.dtsi`)

Expand to multiple bindings inline in layer definitions:
```c
#define ARROWS  &kp LEFT &kp DOWN &kp UP &kp RIGHT
#define FOCUS   &kp LG(H) &kp LG(J) &kp LG(K) &kp LG(L)
#define MOVE    &kp LS(LG(H)) &kp LS(LG(J)) &kp LS(LG(K)) &kp LS(LG(L))
```
Used to fill 4 consecutive key positions on the right side of NUM/NAV/MV home rows.

## ZMK Macros (`macros.dtsi`)

```c
ZMK_MACRO(name, bindings = <...>;)
```

Current: `fn_opn` (types `(_) => {}`), `fn_impl` (types `(_) =>`). Both triggered via combos on the right-side top and bottom rows.

## Build & Diagrams

- CI builds via `.github/workflows/build.yml` → produces `zmk-firmware-*.uf2`
- SVG diagrams via `.github/workflows/draw.yml` using `keymap-drawer`
- Local diagram generation: `./gen-images.sh`
- Diagram config: `keymap_drawer.config.yaml`
