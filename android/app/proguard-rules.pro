# R8 / ProGuard rules for SAMMLY

# Ignore missing classes warnings from optional dependencies
-dontwarn **
-ignorewarnings

# Flutter
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.embedding.** { *; }

# Google Billing (in_app_purchase)
-keep class com.android.vending.billing.** { *; }
-keep class com.google.android.gms.** { *; }
