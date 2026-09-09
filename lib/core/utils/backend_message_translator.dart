import 'package:sammly/core/shared_pref/shared_pref.dart';

/// Translates backend API messages from English to Arabic
/// based on the current app locale stored in SharedPreferences.
///
/// Usage: `BackendMessageTranslator.translate('Not enough tokens')`
/// Returns the Arabic translation if locale is 'ar', otherwise returns the original message.
class BackendMessageTranslator {
  /// Translates the given backend message to Arabic if the app locale is Arabic.
  static String translate(String message) {
    final locale = SharedPref.getData(key: 'language_code') ?? 'en';
    if (locale != 'ar') return message;

    // Exact match first
    if (_translations.containsKey(message)) {
      return _translations[message]!;
    }

    // Partial match for dynamic messages (e.g. "Invalid style and style must be one of: ...")
    for (final entry in _partialTranslations.entries) {
      if (message.startsWith(entry.key)) {
        return entry.value;
      }
    }

    return message;
  }

  // ===== Exact Match Translations =====
  static const Map<String, String> _translations = {
    // ── Auth ──
    'All fields are required': 'جميع الحقول مطلوبة',
    'Invalid email': 'بريد إلكتروني غير صالح',
    'Email already exists': 'البريد الإلكتروني مستخدم بالفعل',
    'Email already exists.': 'البريد الإلكتروني مستخدم بالفعل.',
    'Invalid credentials': 'بيانات الدخول غير صحيحة',
    'Email not verified': 'البريد الإلكتروني غير مُتحقق منه',
    'Account created successfully.': 'تم إنشاء الحساب بنجاح.',
    'Email verified.': 'تم التحقق من البريد الإلكتروني.',
    'Verification failed.': 'فشل التحقق.',
    'Verification code resent successfully.': 'تم إعادة إرسال رمز التحقق بنجاح.',
    'Failed to resend verification code.': 'فشل في إعادة إرسال رمز التحقق.',
    'Logged in.': 'تم تسجيل الدخول.',
    'Login failed.': 'فشل تسجيل الدخول.',
    'Registration failed.': 'فشل التسجيل.',
    'Conflict error.': 'خطأ تعارض.',
    'Your account has been deactivated.': 'تم تعطيل حسابك.',
    'Too many requests. Please wait.': 'طلبات كثيرة جداً. يرجى الانتظار.',
    'Reset code sent.': 'تم إرسال رمز إعادة التعيين.',
    'Failed to send reset code.': 'فشل في إرسال رمز إعادة التعيين.',
    'Reset code resent successfully.': 'تم إعادة إرسال رمز إعادة التعيين بنجاح.',
    'Failed to resend reset code.': 'فشل في إعادة إرسال رمز إعادة التعيين.',
    'Code verified.': 'تم التحقق من الرمز.',
    'Invalid or expired code.': 'رمز غير صالح أو منتهي الصلاحية.',
    'Password reset successfully.': 'تم إعادة تعيين كلمة المرور بنجاح.',
    'Failed to reset password.': 'فشل في إعادة تعيين كلمة المرور.',
    'Password changed.': 'تم تغيير كلمة المرور.',
    'Failed to change password.': 'فشل في تغيير كلمة المرور.',

    // ── Profile ──
    'Profile not found': 'الملف الشخصي غير موجود',
    'User not found': 'المستخدم غير موجود',
    'profile updated successfully': 'تم تحديث الملف الشخصي بنجاح',
    'Please, Enter your name': 'الرجاء إدخال اسمك',
    'Please, Enter your username': 'الرجاء إدخال اسم المستخدم',
    'Username already exists': 'اسم المستخدم مستخدم بالفعل',

    // ── Following ──
    'Followed successfully': 'تمت المتابعة بنجاح',
    'Unfollowed successfully': 'تم إلغاء المتابعة بنجاح',
    'You cannot follow yourself': 'لا يمكنك متابعة نفسك',
    'You already follow this user': 'أنت تتابع هذا المستخدم بالفعل',
    'You cannot follow or unfollow yourself': 'لا يمكنك متابعة أو إلغاء متابعة نفسك',
    'Follow not found': 'المتابعة غير موجودة',
    'Failed to follow.': 'فشل في المتابعة.',
    'Failed to unfollow.': 'فشل في إلغاء المتابعة.',

    // ── Design Generation ──
    'design added successfully': 'تمت إضافة التصميم بنجاح',
    'Designs created successfully': 'تم إنشاء التصميمات بنجاح',
    'Not enough tokens': 'لا تملك رصيد كافٍ من التوكنز',
    'style and imageUrl are required': 'النمط ورابط الصورة مطلوبان',
    'image_url and mask_url are required': 'رابط الصورة ورابط القناع مطلوبان',
    'prompt is required': 'الوصف مطلوب',
    'Generation failed.': 'فشل في الإنشاء.',
    'Restyle failed.': 'فشل في إعادة التنسيق.',
    'Full home generation failed.': 'فشل في إنشاء تصميم المنزل الكامل.',
    'Mask design failed.': 'فشل في تصميم القناع.',
    'Unexpected response format.': 'صيغة استجابة غير متوقعة.',

    // ── Design Details & Actions ──
    'Design not found': 'التصميم غير موجود',
    'Design not found.': 'التصميم غير موجود.',
    'Invalid design id': 'معرّف التصميم غير صالح',
    'Invalid design ID.': 'معرّف التصميم غير صالح.',
    'Design shared successfully': 'تمت مشاركة التصميم بنجاح',
    'Design already shared': 'التصميم مُشارَك بالفعل',
    'Sharing canceled successfully': 'تم إلغاء المشاركة بنجاح',
    'Design already private': 'التصميم خاص بالفعل',
    'Design liked successfully': 'تم الإعجاب بالتصميم بنجاح',
    'Design unliked successfully': 'تم إلغاء الإعجاب بنجاح',
    'You already liked this design': 'لقد أعجبت بهذا التصميم بالفعل',
    'Like not found': 'الإعجاب غير موجود',
    'Failed to share design.': 'فشل في مشاركة التصميم.',
    'Failed to cancel sharing.': 'فشل في إلغاء المشاركة.',
    'Failed to like design.': 'فشل في الإعجاب بالتصميم.',
    'Failed to unlike design.': 'فشل في إلغاء الإعجاب.',

    // ── Favorites ──
    'Added to favorites successfully': 'تمت الإضافة للمفضلة بنجاح',
    'Added to favorites.': 'تمت الإضافة للمفضلة.',
    'Removed from favorites successfully': 'تمت الإزالة من المفضلة بنجاح',
    'Removed from favorites.': 'تمت الإزالة من المفضلة.',
    'Design already in favorites': 'التصميم موجود في المفضلة بالفعل',
    'Design already not in favorites': 'التصميم غير موجود في المفضلة',
    'Failed to load favorites.': 'فشل في تحميل المفضلة.',
    'Failed to add to favorites.': 'فشل في الإضافة للمفضلة.',
    'Failed to remove from favorites.': 'فشل في الإزالة من المفضلة.',

    // ── Payment / Subscription ──
    'Free package claimed successfully': 'تم الحصول على الباقة المجانية بنجاح',
    'soon': 'قريباً',
    'Package id is required': 'معرّف الباقة مطلوب',
    'Invalid package': 'باقة غير صالحة',
    'Free package can only be claimed once per month':
        'يمكن الحصول على الباقة المجانية مرة واحدة فقط شهرياً',

    // ── Validation / Pagination ──
    'Invalid pagination values': 'قيم التصفح غير صالحة',
    'Sort must be likes or latest': 'الترتيب يجب أن يكون بالإعجابات أو الأحدث',

    // ── Support ──
    'Support request sent.': 'تم إرسال طلب الدعم.',
    'Failed to send request.': 'فشل في إرسال الطلب.',

    // ── Search / Smart Lens ──
    'Failed to search design.': 'فشل في البحث عن التصميم.',

    // ── Generic / Fallback ──
    'An unexpected error occurred.': 'حدث خطأ غير متوقع.',
    'Network error occurred': 'حدث خطأ في الاتصال بالشبكة',
    'Server Failed Connection , Try again': 'فشل الاتصال بالسيرفر، حاول مرة أخرى',
    'Server Failed Connection, Try again': 'فشل الاتصال بالسيرفر، حاول مرة أخرى',
    'Unauthorized: No token found.': 'غير مصرح: لم يتم العثور على رمز الدخول.',
    'Unknown error': 'خطأ غير معروف',

    // ── Repo-level fallback messages ──
    'Failed to load packages.': 'فشل في تحميل الباقات.',
    'Failed to claim package.': 'فشل في الحصول على الباقة.',
    'Failed to get profile data.': 'فشل في تحميل بيانات الملف الشخصي.',
    'Failed to update profile.': 'فشل في تحديث الملف الشخصي.',
    'Failed to get settings data.': 'فشل في تحميل بيانات الإعدادات.',
    'Failed to get home data.': 'فشل في تحميل بيانات الصفحة الرئيسية.',
    'Failed to load design history.': 'فشل في تحميل سجل التصميمات.',
    'Failed to load design details.': 'فشل في تحميل تفاصيل التصميم.',
    'Failed to load notifications.': 'فشل في تحميل الإشعارات.',
    'Failed to load followings.': 'فشل في تحميل المتابعات.',
    'Failed to load designs.': 'فشل في تحميل التصميمات.',
  };

  // ===== Partial Match Translations (for dynamic messages) =====
  static const Map<String, String> _partialTranslations = {
    'Invalid style and style must be one of':
        'نمط غير صالح، يجب أن يكون النمط واحداً من الأنماط المتاحة',
    'Invalid room and room must be one of':
        'غرفة غير صالحة، يجب أن تكون الغرفة واحدة من الغرف المتاحة',
    'Bad response:': 'استجابة خاطئة من السيرفر',
    'Error:': 'خطأ في الاتصال',
  };
}
