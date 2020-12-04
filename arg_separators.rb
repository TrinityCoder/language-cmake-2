#!/usr/bin/env -vS ruby -wKU
#
# A Ruby script to obtain a list of CMake upper case constants.
#
# This file originates in the [textmate/cmake.tmbundle][1] repository,
# specifically it's the [Support/arg_separators.rb][2]
# file.
#
# [1]: https://github.com/textmate/cmake.tmbundle
# [2]: https://github.com/textmate/cmake.tmbundle/blob/master/Support/arg_separators.rb

commands = `/usr/bin/env cmake --help-command-list`.lines
commands.shift # Skip version number

constants = []

commands.each do |cmd|
  cmd = cmd.strip.upcase
  help = `/usr/bin/env cmake --help-command #{cmd}`
  help.scan(/[a-zA-Z_]+\((.+?)\)/m) do |example|
    example[0].scan(/[A-Z_\d]{2,}/) do |constant|
      constants << constant
    end
  end
end

constants.uniq.sort.each { |constant| puts constant }
