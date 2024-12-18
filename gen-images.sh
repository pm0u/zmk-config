#! /bin/bash
keymap -c ./keymap_drawer.config.yaml parse -z ./config/lily58.keymap > draw/lily58.yml &&\
keymap -c ./keymap_drawer.config.yaml draw draw/lily58.yml -k "lily58/rev1" > ./draw/lily58.svg

keymap -c ./keymap_drawer.config.yaml parse -z ./config/corne.keymap > draw/corne.yml
keymap -c ./keymap_drawer.config.yaml draw draw/corne.yml -k "crkbd/rev4_1/mini" -l "LAYOUT_split_3x5_3" > ./draw/corne.svg