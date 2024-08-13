#!/bin/env bash

result=0
if ! command -v gum &>/dev/null; then
	read -p "Are you sure? " -n 1 -r
	echo

else
	result="$(gum confirm "Clear the neovim folders?" --no-show-help && echo 'y' || echo 0  )"
fi

if [[ $result =~ ^[Yy]$ ]]
then
  # do dangerous stuff
  cdirs=(\
    ~/.cache/nvim \
    ~/.local/share/nvim \
    ~/.local/state/nvim \
  )

  for i in "${cdirs[@]}"
  do
    rm -rf $i
    echo "cleard: $i"
  done
  echo "OK ..."
else
  echo "Aborted"
fi
