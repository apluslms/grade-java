#!/bin/sh

files="HelloWorld.java /exercise/HelloWorldTest.java /exercise/AllTests.java"
files=$(move-to-package-dirs -v $files)

if capture pre java-compile -M; then
    if capture pre junit -r AllTests; then
        title -e p "Everything is ok and you got full points. Well done!"
    fi
else
    title -e p "Cimpilation failed, no tests are run. Compilation errors:"
    err-to-out
fi
