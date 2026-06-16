import 'package:sammly/generated/l10n.dart';

/// Maps UI display values to API-accepted values and vice versa.
///
/// API style values: mid century modern, bohemian, rustic, coastal, traditional
/// API room values: bedroom, bathroom, kitchen, livingroom, diningroom
abstract class GenerateMappers {
  // ── Style Mapping ──

  static Map<String, String> get _styleUiToApi => {
    S.current.traditional: 'traditional',
    S.current.coastal: 'coastal',
    S.current.rustic: 'rustic',
    S.current.midCenturyModern: 'mid century modern',
    S.current.boho: 'bohemian',
  };

  static Map<String, String> get _styleApiToUi => {
    'traditional': S.current.traditional,
    'coastal': S.current.coastal,
    'rustic': S.current.rustic,
    'mid century modern': S.current.midCenturyModern,
    'bohemian': S.current.boho,
    'modern': S.current.midCenturyModern,
  };

  /// Converts a UI style display value to its API equivalent.
  /// e.g. "Boho" → "bohemian", "Mid-century modern" → "mid century modern"
  static String styleToApi(String uiValue) {
    return _styleUiToApi[uiValue] ?? uiValue.toLowerCase();
  }

  /// Converts an API style value to its UI display equivalent.
  /// e.g. "bohemian" → "Boho"
  static String styleToUi(String apiValue) {
    return _styleApiToUi[apiValue] ?? apiValue;
  }

  // ── Room Mapping ──

  static Map<String, String> get _roomUiToApi => {
    S.current.bathroom: 'bathroom',
    S.current.bedroom: 'bedroom',
    S.current.diningRoom: 'diningroom',
    S.current.kitchen: 'kitchen',
    S.current.livingRoom: 'livingroom',
  };

  static Map<String, String> get _roomApiToUi => {
    'bathroom': S.current.bathroom,
    'bedroom': S.current.bedroom,
    'diningroom': S.current.diningRoom,
    'kitchen': S.current.kitchen,
    'livingroom': S.current.livingRoom,
  };

  /// Converts a UI room display value to its API equivalent.
  /// e.g. "Dining Room" → "diningroom", "Living Room" → "livingroom"
  static String roomToApi(String uiValue) {
    return _roomUiToApi[uiValue] ?? uiValue.toLowerCase();
  }

  /// Converts an API room value to its UI display equivalent.
  /// e.g. "diningroom" → "Dining Room"
  static String roomToUi(String apiValue) {
    return _roomApiToUi[apiValue] ?? apiValue;
  }
}
