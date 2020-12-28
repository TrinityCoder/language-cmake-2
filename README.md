# language-cmake-2 package

Syntax highlighting for CMake in atom. Converted from the
[Textmate bundle](https://github.com/textmate/cmake.tmbundle)

---

This is continuation of the [`lucas-clemente/language-cmake`][1] Atom package,
which has been discontinued in 2020, with [last commit from 30 May 2019][2]
and the last supported CMake version 3.14.

`language-cmake-2` is a continuation of this project, which starts at the same
place where the original left.

## How to install
### a) By hand
First, you should remove the old, unupdated `language-cmake` package by
running

```sh
# The `--hard` switch uninstalls both normal and dev versions
# of the package (from ~/.atom/packages and ~/.atom/dev/packages).
apm uninstall --hard language-cmake
```

Then, install the `language-cmake-2` package:

```sh
apm install language-cmake-2
```

### b) Using the [`install.sh`][3] script
Simply run the `install.sh` script. This script gets automatically rid
of the `language-cmake` package.

```sh
./install.sh
```

If you want to link the current directory to Atom (instead of the last
officially published version), run:

```sh
./install.sh --link
```

## License
Licensed under the [MIT license](LICENSE).

[1]: https://github.com/lucas-clemente/language-cmake
[2]: https://github.com/lucas-clemente/language-cmake/commit/61af86425a75b16f5b1bfb74be18544b97ba9c02
[3]: install.sh
