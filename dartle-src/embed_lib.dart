import 'dart:convert';
import 'dart:io';

import 'package:dartle/dartle.dart';
import 'package:path/path.dart' as p;

import '../bin/lib_helper.dart' show helloLibName;
import 'compile_c.dart';

final generatedLibDartFile = p.join('bin', 'hello_lib.g.dart');

Task embedLibTask() => Task(
  embedLib,
  description: 'Embed the C library in the Dart sources.',
  runCondition: RunOnChanges(
    inputs: file(p.join(buildDir, helloLibName)),
    outputs: file(generatedLibDartFile),
  ),
);

Future<void> embedLib(List<String> _) async {
  final libBytes = await File(p.join(buildDir, helloLibName)).readAsBytes();
  final contents =
      '''
// GENERATED CODE - DO NOT MODIFY BY HAND
const helloLib = "${base64.encode(libBytes)}";
''';
  await File(generatedLibDartFile).writeAsString(contents);
}
