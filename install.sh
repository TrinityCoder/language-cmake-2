#!/bin/bash
#
# Description:
#
# 1) Finds the first of `apm`, `apm-beta` and `apm-nightly` commands.
# 2) Makes sure that `language-cmake` and `language-cmake-2`
# packages are not installed (both release and dev versions).
# 3) Installs the `language-cmake-2` package.

err_trap() {
  echo "Script FAILED." 1>&2
}

exit_trap() {
  echo "Script SUCCEEDED." 1>&2
}

trap err_trap ERR
trap exit_trap EXIT

set -o errexit

# Checks if "$1" is a command.
command_exists() {
  (( $# == 1 )) && command "$1" &>/dev/null
}

# Checks if `apm` is a command. If not, also checks `apm-beta`
# and `apm-nightly`.
find_apm_command() {
  command_exists "apm" && echo -n "apm" && return 0
  command_exists "apm-beta" && echo -n "apm-beta" && return 0
  command_exists "apm-nightly" && echo -n "apm-nightly" && return 0
  return 1
}

readonly LOCAL_APM_COMMAND="${LOCAL_APM_COMMAND:-$(find_apm_command)}"
echo "LOCAL_APM_COMMAND: '$LOCAL_APM_COMMAND'" 1>&2

# Retrieve the path of the directory, where is this script saved.
readonly CURR_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")" &&
  cd "$CURR_DIR"
echo "pwd: '$CURR_DIR'" 1>&2

# Returns "true" iff "$1" package is installed in Atom.
installed() {
  (( $# == 1 )) && "$LOCAL_APM_COMMAND" list --bare | grep "$@" &>/dev/null
}

# Uninstall all "$@" packages, that are installed.
apm_uninstall() {
  for NAME in "$@"; do
    installed "$NAME" && "$LOCAL_APM_COMMAND" uninstall --hard "$NAME"
  done
}

# 0) Make sure that both `language-cmake` and `language-cmake-2`
# packages are not present.
apm_uninstall "language-cmake" "language-cmake-2"

# 1) Install the `language-cmake-2` package into Atom.
[[ "$1" = "--link" || "$1" = "link" ]] &&
  "$LOCAL_APM_COMMAND" link ||
  "$LOCAL_APM_COMMAND" install language-cmake-2
