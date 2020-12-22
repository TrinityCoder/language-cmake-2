#!/bin/bash

set -o errexit

# Returns "true" <==> "$1" package is installed in Atom.
apm_installed() {
  (( $# == 1)) && apm list | grep "$@"
}

# Uninstalls all "$@" packages, which are installed.
apm_uninstall() {
  for NAME in "$@"; do
    apm_installed "$NAME" && apm uninstall --hard "$NAME"
  done
}

# 0a) Get rid of `language-cmake` and `language-cmake-2` as well.
apm_uninstall "language-cmake@" "language-cmake-2"

# 1) Install the `language-cmake-2` package into Atom.
# If `--link` arg is specified, the current directory's package
# gets linked into Atom.
# Otherwise, the newest officially published version is downloaded
# and installed.
[[ "$1" = "--link" ]] &&
  apm link --no-dev ||
  apm install language-cmake-2
