import 'dart:async';
import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import 'lib_helper.dart';

const version = '0.0.1';

// FFI signature of the get_message C function
typedef GetMessageNative = ffi.Pointer<Utf8> Function();

// Dart type definition for calling the C foreign function
typedef GetMessage = ffi.Pointer<Utf8> Function();

Future<void> main(List<String> args) async {
  if (args.length > 1 || (args.length == 1 && args[0] != '--unpack')) {
    throw Exception('At most 1 arg (--unpack) expected.');
  }
  final lib = await resolveCLib(unpack: args.isNotEmpty);

  printHelloFromDart();
  printHelloFromC(lib);
}

FutureOr<ffi.DynamicLibrary> resolveCLib({required bool unpack}) {
  if (unpack) {
    return unpackLibHello();
  }
  return openLibHello();
}

void printHelloFromDart() {
  print('Hello from Dart');
}

void printHelloFromC(ffi.DynamicLibrary lib) {
  final getMessage = lib.lookupFunction<GetMessageNative, GetMessage>(
    'get_message',
  );
  final message = getMessage().toDartString();
  print(message);
}
