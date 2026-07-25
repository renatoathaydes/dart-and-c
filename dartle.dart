import 'package:dartle/dartle_dart.dart';

import 'dartle-src/compile_c.dart';
import 'dartle-src/embed_lib.dart';

final dartleDart = DartleDart();

Future<void> main(List<String> args) async {
  final cc = compileCTask();
  final embed = embedLibTask();
  embed.dependsOn({cc.name});
  dartleDart.analyzeCode.dependsOn({embed.name});
  dartleDart.formatCode.dependsOn({embed.name});
  await run(
    args,
    tasks: {cc, embed, ...dartleDart.tasks},
    defaultTasks: {dartleDart.build},
  );
}
