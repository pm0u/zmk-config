#! /bin/bash
keymap -c ./keymap_drawer.config.yaml parse -z ./config/lily58.keymap > draw/lily58.yaml &&\
keymap -c ./keymap_drawer.config.yaml draw draw/lily58.yaml -k "lily58/rev1" > ./draw/lily58.svg

keymap -c ./keymap_drawer.config.yaml parse -z ./config/corne.keymap > draw/corne.yaml
keymap -c ./keymap_drawer.config.yaml draw draw/corne.yaml -k "crkbd/rev4_1/mini" -l "LAYOUT_split_3x5_3" > ./draw/corne.svg