import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sammly/core/networking/api_constants.dart';
import 'package:sammly/core/networking/dio_helper.dart';
import 'package:sammly/core/theme/text_styles.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/shared_pref/shared_pref.dart';

class AppVersionChecker {
  /// Returns true if a forced update dialog was shown, meaning the app should halt.
  static Future<bool> checkVersion(BuildContext context) async {
    try {
      final response = await DioHelper.getData(
        endPoint: ApiConstants.appVersion,
      );

      if (response.statusCode == 200 && response.data['status'] == 'success') {
        final data = response.data['data'] as Map<String, dynamic>;
        final latestVersion = data['latestVersion'] as String?;
        final minRequiredVersion = data['minRequiredVersion'] as String?;
        final downloadUrl = data['downloadUrl'] as String? ?? 'https://drive.google.com/drive/folders/1J-vtrMlETkIt9Yk0VGE2CcPrc8ttdvoG?usp=sharing';
        final forceUpdate = data['forceUpdate'] as bool? ?? false;
        final releaseNotes = data['releaseNotes'] as String?;
        final releaseNotesAr = data['releaseNotesAr'] as String?;

        if (latestVersion == null || minRequiredVersion == null) return false;

        final packageInfo = await PackageInfo.fromPlatform();
        final currentVersion = packageInfo.version;

        final isUpdateAvailable = _isVersionGreaterThan(latestVersion, currentVersion);
        final isUpdateRequired = _isVersionGreaterThan(minRequiredVersion, currentVersion) || forceUpdate;

        if (!context.mounted) return false;

        if (isUpdateAvailable) {
          await _showUpdateDialog(
            context,
            downloadUrl: downloadUrl,
            isForced: isUpdateRequired,
            releaseNotes: releaseNotes,
            releaseNotesAr: releaseNotesAr,
          );
          return isUpdateRequired;
        }
      }
    } catch (e) {
      log('Version check failed: $e');
    }
    return false;
  }

  static bool _isVersionGreaterThan(String v1, String v2) {
    try {
      final v1Parts = v1.split('.').map(int.parse).toList();
      final v2Parts = v2.split('.').map(int.parse).toList();

      for (int i = 0; i < 3; i++) {
        final p1 = i < v1Parts.length ? v1Parts[i] : 0;
        final p2 = i < v2Parts.length ? v2Parts[i] : 0;
        if (p1 > p2) return true;
        if (p1 < p2) return false;
      }
    } catch (e) {
      log('Version parse error: $e');
    }
    return false;
  }

  static Future<void> _showUpdateDialog(
    BuildContext context, {
    required String downloadUrl,
    required bool isForced,
    String? releaseNotes,
    String? releaseNotesAr,
  }) async {
    final isArabic = (SharedPref.getData(key: 'language_code') ?? 'en') == 'ar';
    final notes = isArabic ? releaseNotesAr ?? releaseNotes : releaseNotes;

    await showDialog(
      context: context,
      barrierDismissible: !isForced,
      builder: (context) {
        return PopScope(
          canPop: !isForced,
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            backgroundColor: AppColors.whiteColor,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.system_update_rounded,
                    size: 64,
                    color: AppColors.primaryColor,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    isArabic ? 'تحديث جديد متاح' : 'New Update Available',
                    style: AppTextStyles.title20Bold.copyWith(
                      color: AppColors.blackColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    isArabic
                        ? 'لقد أطلقنا إصداراً جديداً بتحديثات رائعة. يرجى التحديث للحصول على أفضل تجربة.'
                        : 'We have released a new version with great features. Please update for the best experience.',
                    style: AppTextStyles.body16Regular.copyWith(
                      color: AppColors.greyColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  if (notes != null && notes.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        notes,
                        style: AppTextStyles.body14Regular.copyWith(
                          color: AppColors.primaryColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      if (!isForced) ...[
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(context),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              side: const BorderSide(color: AppColors.greyColor),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              isArabic ? 'لاحقاً' : 'Later',
                              style: AppTextStyles.body16Medium.copyWith(
                                color: AppColors.greyColor,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                      ],
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: AppColors.primaryGradient3,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ElevatedButton(
                            onPressed: () async {
                              final uri = Uri.parse(downloadUrl);
                              try {
                                await launchUrl(uri, mode: LaunchMode.externalApplication);
                              } catch (e) {
                                log('Could not launch update URL: $e');
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              isArabic ? 'تحديث الآن' : 'Update Now',
                              style: AppTextStyles.body16Medium.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
