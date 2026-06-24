import 'dart:io';
import 'package:intl/intl.dart';

String formatDate(String dateStr) {
  if (dateStr.isEmpty) return '';
  try {
    DateTime? parsedDate;
    String cleaned = dateStr.trim();
    
    // 1. Try parsing as milliseconds timestamp if it's purely digits
    if (RegExp(r'^\d+$').hasMatch(cleaned)) {
      int timestamp = int.parse(cleaned);
      if (cleaned.length == 10) {
        timestamp *= 1000;
      }
      parsedDate = DateTime.fromMillisecondsSinceEpoch(timestamp, isUtc: true);
    } else {
      // 2. Try standard parse first
      parsedDate = DateTime.tryParse(cleaned);
      
      // 3. Try HttpDate parsing
      if (parsedDate == null) {
        try {
          parsedDate = HttpDate.parse(cleaned);
        } catch (_) {}
      }
      
      // 4. Try cleaning timezone name suffixes (UTC/GMT) if still null
      if (parsedDate == null) {
        String customCleaned = cleaned.replaceAll(RegExp(r'\s+(UTC|GMT)$', caseSensitive: false), 'Z');
        if (customCleaned.contains(' ') && !customCleaned.contains('T')) {
          customCleaned = customCleaned.replaceAll(' ', 'T');
        }
        parsedDate = DateTime.tryParse(customCleaned);
      }
      
      // 5. If parsed but isUtc is false and no timezone info was in the original string, treat it as UTC
      if (parsedDate != null) {
        if (!parsedDate.isUtc && !cleaned.toUpperCase().contains('Z') && !cleaned.contains('+')) {
          String formatted = cleaned.replaceAll(' ', 'T');
          if (!formatted.endsWith('Z')) {
            formatted += 'Z';
          }
          parsedDate = DateTime.tryParse(formatted) ?? parsedDate;
        }
      }
    }

    if (parsedDate == null) return dateStr;

    final localDate = parsedDate.toLocal();
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(localDate);
  } catch (e) {
    return dateStr;
  }
}

void main() {
  List<String> dates = [
    "2026-06-24T16:15:00.000Z",
    "2026-06-24 16:15:00",
    "1719260400000",
    "1719260400",
    "2026-06-24T16:15:00.000+00:00",
    "2026-06-24 16:15:00 UTC",
    "2026-06-24 16:15:00 GMT",
    "Wed, 24 Jun 2026 16:15:00 GMT",
    "2026-06-24T16:15:00.000-00:00",
  ];

  for (String dateStr in dates) {
    print("$dateStr -> Local Time: ${formatDate(dateStr)}");
  }
}
