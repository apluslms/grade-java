Grading environment with specific Java version in path.
In addition, following convenience scripts are provided in path.

* `java-compile [-M] [-m ok_message] [files/dirs..]`

    Passes `files/dirs` to `move-to-package-dirs` and then executes `javac` with all matched files.
    If `files/dirs` is empty (no argument), then all `*.java` files in the working tree are moved and compiled.

    You can control classpath via `CLASSPATH` environment variable.

    If compilation is successfull, then `ok_message` is printed.
    By default, it is `ok`, but it can be suppressed with `-M`.

* `move-to-package-dirs [-v] [-d delim] [-f filter] [files/dirs..]`

    Reads `package` and `package object` (scala) directives from files and moves files to correct locations.
    For example, a file 'example.java` containing `package foo.bar;` is moved to `foo/bar/example.java`.
    All directories are recursively seached and all files that match `filter` pattern are handled.

    If no files or directories are specified, then current tree is searched for files matching filters `*.java` and `*.scala`.

    The utility prints final paths of all processed files.
    By default, paths are separated by space, but you can change this with `-d` (e.g. newlines with `-d '\n'` or nulls with `-d '\0'`).
    This can be used to pass files for `javac` for example (e.g. `javac $(move-to-package-dirs)`).

    In case of readonly files (e.g. /exercise mount), files are copied instead.

    The argument `-v` ands verbose flag for `mv` and `cp` commands with output redirected to stderr.
