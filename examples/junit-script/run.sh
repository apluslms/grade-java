#!/bin/sh

files="HelloWorld.java /exercise/HelloWorldTest.java /exercise/AllTests.java"
files=$(move-to-package-dirs -v $files)

if ! capture pre java-compile -M; then
    title -e p "Compilation failed, no tests were run. Compilation errors:"
    err-to-out
elif capture pre junit -r AllTests; then
    title -e p "Everything is ok and you got full points. Well done!"
fi
