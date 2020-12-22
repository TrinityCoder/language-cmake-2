#!/bin/bash

set -o errexit
set -o xtrace

is_installed() {
  (( $# >= 1)) &&
    apm list | grep "$@" || { return 1; }
}

# 0a) Get rid of `language-cmake` and `language-cmake-2` as well.
is_installed "language-cmake@" &&
  apm uninstall --hard language-cmake
is_installed "language-cmake-2" &&
  apm uninstall --hard language-cmake-2

# 1) If `--link` is specified, link current directory into Atom
#    as the current `language-cmake-2` version.
#
#    Otherwise, install the last officially published `language-cmake-2`.
[[ "$1" = "--link" ]] && {
  apm link --no-dev
} || {
  apm install language-cmake-2
}
