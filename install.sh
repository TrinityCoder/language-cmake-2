#!/bin/bash

set -o errexit
set -o xtrace

# Returns "true" <==> "$1" package is installed in Atom.
is_installed() {
  (( $# == 1)) && apm list | grep "$@"
}

# Uninstalls all "$@" packages, which are installed.
uninstall_if_installed() {
  for NAME in "$@"; do
    is_installed "$NAME" && apm uninstall --hard "$NAME"
  done
}

# 0a) Get rid of `language-cmake` and `language-cmake-2` as well.
uninstall_if_installed "language-cmake@" "language-cmake-2"

# 1) If `--link` is specified, link current directory into Atom
#    as the current `language-cmake-2` version.
#
#    Otherwise, install the last officially published `language-cmake-2`.
[[ "$1" = "--link" ]] &&
  apm link --no-dev ||
  apm install language-cmake-2
