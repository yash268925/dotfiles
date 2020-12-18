#!/bin/sh

DEST="$HOME"

make_dir() {
  if [ ! -e $1 ] ; then
    mkdir $1
  fi
}

make_link() {
  files="$(ls $1)"
  for filename in $files ; do
    src="$1/$filename"
    dst="$2/$(echo $filename | sed 's/\$/./g')"
    echo "$src -> $dst"
    if [ -d $src ] ; then
      make_dir $dst
      make_link $src $dst
    else
      ln -sf $src $dst
    fi
  done
}

make_dir $DEST
make_dir $DEST/.config

make_link "$(pwd)/dots" $DEST
make_link "$(pwd)/config" $DEST/.config
