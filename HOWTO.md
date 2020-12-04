# Updating the syntax highlighting
By far the most important file of this package is [cmake listfile.cson][1].
It contains two remarkably large arrays:
1. **argument-constants**, containing all the CMake upper case constants
(starts with `ACTION|AFTER|ALIAS|ALL|ALPHABET`); the list of most of them
can be obtained by running the [`arg_separators.rb`][2] script.
2. **command list**, consisting of CMake commands; the list of them can
be obtained by running `cmake --help-command-list`.

These informations can also be obtained from the [release notes][3]
for the new version.

[1]: grammars/cmake%20listfile.cson
[2]: arg_separators.rb
[3]: https://cmake.org/cmake/help/latest/release/index.html
