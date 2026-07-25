import 'dart:convert';
import 'dart:ffi' as ffi;
import 'dart:io';

import 'package:path/path.dart' as p;

import 'hello_lib.g.dart';

final String _libExtension = Platform.isWindows
    ? '.dll'
    : Platform.isMacOS
    ? '.dylib'
    : '.so';

final String helloLibName = 'libhello$_libExtension';

ffi.DynamicLibrary openLibHello() {
  final libDir = p.absolute('c', 'build');
  final lib = p.join(libDir, helloLibName);
  return ffi.DynamicLibrary.open(lib);
}

Future<ffi.DynamicLibrary> unpackLibHello() async {
  final unpackedLib = File('unpacked-$helloLibName');
  if (!await unpackedLib.exists()) {
    print('Unpacking hellolib at ${p.absolute(unpackedLib.path)}');
    await unpackedLib.writeAsBytes(base64Decode(helloLib));
  }
  return ffi.DynamicLibrary.open(p.absolute(unpackedLib.path));
}
