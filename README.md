# Dart-And-C

Sample project where Dart includes a C library that works on Linux, Windows and MacOS.

## Structure

There's a single C file at [c/hello.c](c/hello.c). The file is automatically compiled when the Dartle build runs.

```shell
➜  dart-and-c git:(main) ✗ dartle
2026-07-25 19:52:16.807403 - dartle[main 8993] - INFO - Executing 6 tasks out of a total of 9 tasks: 1 task (default), 6 dependencies, 1 up-to-date
2026-07-25 19:52:16.807444 - dartle[main 8993] - INFO - Running task 'compileC'
2026-07-25 19:52:16.864829 - dartle[main 8993] - INFO - Running task 'embedLib'
2026-07-25 19:52:16.867440 - dartle[main 8993] - INFO - Running task 'format'
2026-07-25 19:52:20.047529 - dartle[main 8993] - INFO - Running task 'analyzeCode'
Analyzing ....
No issues found!

2026-07-25 19:52:20.725137 - dartle[main 8993] - INFO - Running task 'test'

Tests finished in  1s, 48ms

2026-07-25 19:52:21.773668 - dartle[main 8993] - INFO - Running task 'build'
✔ Build succeeded in 4s, 982ms
```

The Dartle tasks (in [dartle-src](dartle-src)) do the following:

* `compileC` - compiles the C source code into a dynamic library.
* `embedLib` - generates [bin/hello_lib.g.dart](bin/hello_lib.g.dart), embedding the C dynamic library into Dart source code.
* the other tasks come from `DartleDart` (See the [Dartle Documentation](https://renatoathaydes.github.io/dartle-website/dartle-for-dart.html)).

## Running

After building with Dart, you can run the code with:

```shell
dart run
```

Compile a single executable containing everything with:

```shell
dartle compExe
```

The executable, by default, tries to find the C dynamic lib at `c/build/libhello.[ext]`.
So it won't work if you copy it elsewhere.

However, if you enable the `--unpack` option, the executable extracts the embedded lib and then opens that instead,
so it works anywhere.

Example:

```shell
$ dart_and_c --unpack
Unpacking hellolib at /Users/renato/tests/unpacked-libhello.dylib
Hello from Dart
Hello there from C
```