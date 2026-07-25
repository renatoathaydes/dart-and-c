import 'dart:io';

import 'package:dartle/dartle.dart';
import 'package:path/path.dart' as p;

import '../bin/lib_helper.dart' show helloLibName;

/// Get the C compiler.
String _cc() {
  return Platform.environment['CC'] ?? 'cc';
}

final cSource = p.join('c', 'hello.c');
final buildDir = p.join('c', 'build');

Task compileCTask() => Task(
  compileC,
  description: 'Compile the C code',
  runCondition: RunOnChanges(inputs: file(cSource), outputs: dir(buildDir)),
);

Future<void> compileC(List<String> _) async {
  await Directory(buildDir).create(recursive: true);

  final exitCode = await exec(
    Process.start(_cc(), [
      '-dynamiclib',
      '-o',
      p.join(buildDir, helloLibName),
      cSource,
    ]),
  );
  if (exitCode != 0) {
    throw Exception('Compilation failed');
  }
}
