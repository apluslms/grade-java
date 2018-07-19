Grading environment with specific Java version in path.

This image extends [grading-base](https://github.com/apluslms/grading-base).
In addition, following convenience scripts are provided in path.

* `java-compile [-M] [-m ok_message] [files/dirs..]`

    Passes `files/dirs` to `move-to-package-dirs` and then executes `javac` with all matched files.
    If `files/dirs` is empty (no argument), then all `*.java` files in the working tree are moved and compiled.

    You can control classpath via `CLASSPATH` environment variable.
    You can define options for `javac` using `JAVACFLAGS` environment variable.
    Default options are `-encoding utf-8 -deprecation`.

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

* `junit [-r runner] [files..]`

    Executes java using `runner` as the class, `files` as arguments and filters output with `filter-junit-stack`.
    Default `runner` is `org.junit.runner.JUnitCore`.
    To run test stuite or custom main, use something like `junit -r MyTests` or `filter-junit-stack java MyTests`.

* `filter-junit-stack CMD..`

    Executes CMD and removes all lines starting with `\tat ` from stdout and stderr.
    For example, junit prints stack traces in this format.

* `run-all-junits [-C] [-p points_per_test_class]`

    Command to do it all.
    Can replace `run.sh` in trivial cases.

    First, script compiles all `*.java` files from the current tree and /exercise, unless `-C` is provided.
    If compilation fails, then no tests are run.
    Second, script finds all files matching `*Test*.java` pattern from the current tree.
    Then, it runs all files that contain string `org.junit.Test` using `testcase` and `junit`.
    Testcase will give `points_per_test_class` many points per successful execution of junit.
