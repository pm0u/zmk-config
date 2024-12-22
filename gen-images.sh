#! /bin/bash
keymap -c ./keymap_drawer.config.yaml parse -z ./config/corne.keymap > draw/corne.yaml
keymap -c ./keymap_drawer.config.yaml draw draw/corne.yaml -k "crkbd/rev4_1/mini" -l "LAYOUT_split_3x5_3" --keys-only > ./draw/corne.svg
keymap -c ./keymap_drawer.config.yaml draw draw/corne.yaml -k "crkbd/rev4_1/mini" -l "LAYOUT_split_3x5_3" -s base --combos-only> ./draw/combos.svg
