import 'dart:io';

void main() {
  final dir = Directory('lib');
  final files = dir.listSync(recursive: true).whereType<File>().where((f) => f.path.endsWith('.dart'));

  int totalReplacements = 0;

  for (final file in files) {
    String content = file.readAsStringSync();
    
    if (content.contains('.withOpacity(')) {
      content = content.replaceAll('.withOpacity(', '.withValues(alpha: ');
      file.writeAsStringSync(content);
      print('Fixed in ${file.path}');
      totalReplacements++;
    }
  }

  print('Done. Modified $totalReplacements files.');
}
