#!/bin/bash

set -euxo pipefail

function title() {
  echo -ne "\033]0;$1\007"
}

title "Building cross binutils"
"$_SCRIPT_DIR/cross/binutils.sh"

title "Building cross headers"
"$_SCRIPT_DIR/cross/headers.sh"

[[ -L "$_X_DIR/mingw" ]] || ln -s "$_TARGET" "$_X_DIR/mingw"

title "Building cross GCC (phase 1)"
"$_SCRIPT_DIR/cross/gcc-p1.sh"

export PATH="$_X_DIR/bin:$PATH"

title "Building cross CRT"
"$_SCRIPT_DIR/cross/crt.sh"

title "Building cross winpthreads"
"$_SCRIPT_DIR/cross/winpthreads.sh"

title "Building cross GCC (phase 2)"
"$_SCRIPT_DIR/cross/gcc-p2.sh"
