/// In-App Purchase Product IDs.
///
/// These must match exactly with the product IDs created in
/// Google Play Console and App Store Connect.
class IapProductIds {
  IapProductIds._();

  // Consumable (one-time purchase, can buy again)
  static const homeownerPack = 'sammly_homeowner_30';

  // Subscriptions (auto-renewable monthly)
  static const designerProMonthly = 'sammly_designer_pro_monthly';
  static const studioMonthly = 'sammly_studio_monthly';

  /// All product IDs to query from the store.
  static const Set<String> all = {
    homeownerPack,
    designerProMonthly,
    studioMonthly,
  };

  /// Consumable product IDs (must be consumed after purchase).
  static const Set<String> consumables = {homeownerPack};

  /// Subscription product IDs.
  static const Set<String> subscriptions = {
    designerProMonthly,
    studioMonthly,
  };
}
