import 'package:sammly/core/constant/app_strings.dart';

/// Maps UI display values to API-accepted values and vice versa.
///
/// API style values: mid century modern, bohemian, rustic, coastal, traditional
/// API room values: bedroom, bathroom, kitchen, livingroom, diningroom
abstract class GenerateMappers {
  // ── Style Mapping ──

  static const Map<String, String> _styleUiToApi = {
    AppStrings.traditional: 'traditional',
    AppStrings.coastal: 'coastal',
    AppStrings.rustic: 'rustic',
    AppStrings.midCenturyModern: 'mid century modern',
    AppStrings.boho: 'bohemian',
  };

  static const Map<String, String> _styleApiToUi = {
    'traditional': AppStrings.traditional,
    'coastal': AppStrings.coastal,
    'rustic': AppStrings.rustic,
    'mid century modern': AppStrings.midCenturyModern,
    'bohemian': AppStrings.boho,
    'modern': AppStrings.midCenturyModern,
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

  static const Map<String, String> _roomUiToApi = {
    AppStrings.bathroom: 'bathroom',
    AppStrings.bedroom: 'bedroom',
    AppStrings.diningRoom: 'diningroom',
    AppStrings.kitchen: 'kitchen',
    AppStrings.livingRoom: 'livingroom',
  };

  static const Map<String, String> _roomApiToUi = {
    'bathroom': AppStrings.bathroom,
    'bedroom': AppStrings.bedroom,
    'diningroom': AppStrings.diningRoom,
    'kitchen': AppStrings.kitchen,
    'livingroom': AppStrings.livingRoom,
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
