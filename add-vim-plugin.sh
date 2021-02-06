#!/bin/bash
cd ~/.vim
mkdir -p pack/$1/start
git submodule add https://github.com/$1.git pack/$(echo $1 | sed 's/\//\/start\//g')
git commit -m "add plugin $1"
