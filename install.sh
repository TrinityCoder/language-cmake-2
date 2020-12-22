#!/bin/bash

set -o errexit

# Retrieve the path of the directory, where is this script saved.
readonly CURR_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")" &&
  cd "$CURR_DIR"

echo "pwd: '$CURR_DIR'"

# Returns "true" iff "$1" package is installed in Atom.
function installed {
  (( $# == 1)) && apm list --bare | grep "$@"
}

# Uninstall all "$@" packages, that are installed.
function apm_uninstall {
  for NAME in "$@"; do
    installed "$NAME" && apm uninstall --hard "$NAME"
  done
}

# 0) Make sure that both `language-cmake` and `language-cmake-2`
# packages are not present.
apm_uninstall "language-cmake@" "language-cmake-2"

# 1) Install the `language-cmake-2` package into Atom.
[[ "$1" = "--link" ]] &&
  apm link --no-dev ||
  apm install language-cmake-2
