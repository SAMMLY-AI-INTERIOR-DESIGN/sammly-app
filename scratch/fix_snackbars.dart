import 'dart:io';

void main() {
  final dir = Directory('lib');
  final files = dir.listSync(recursive: true).whereType<File>().where((f) => f.path.endsWith('.dart'));

  int totalReplacements = 0;

  for (final file in files) {
    if (file.path.contains('functions.dart')) continue;

    String content = file.readAsStringSync();
    bool changed = false;

    // Pattern 1: ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    // Pattern 2: ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg), backgroundColor: Colors.red));
    // It's tricky to use regex for nested parentheses. I'll just find ScaffoldMessenger.of(context).showSnackBar and add hideCurrentSnackBar before it.

    // A simpler fix: everywhere `ScaffoldMessenger.of(context).showSnackBar` is used,
    // we prefix it with `ScaffoldMessenger.of(context).hideCurrentSnackBar(); `
    
    // First, remove existing hideCurrentSnackBar to avoid double
    content = content.replaceAll(RegExp(r'ScaffoldMessenger\.of\(context\)\.hideCurrentSnackBar\(\);\s*'), '');

    // Now, replace showSnackBar with hideCurrentSnackBar followed by showSnackBar
    if (content.contains('ScaffoldMessenger.of(context).showSnackBar(')) {
      content = content.replaceAll(
        'ScaffoldMessenger.of(context).showSnackBar(', 
        'ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar('
      );
      changed = true;
      totalReplacements++;
    }

    if (changed) {
      file.writeAsStringSync(content);
      print('Fixed in ${file.path}');
    }
  }

  print('Done. Modified $totalReplacements files.');
}
