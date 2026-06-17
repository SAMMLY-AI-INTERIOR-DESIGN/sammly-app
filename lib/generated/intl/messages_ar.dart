// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ar locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ar';

  static String m0(error) => "خطأ في حفظ الصورة: ${error}";

  static String m1(count) =>
      "${Intl.plural(count, zero: 'لا توجد منشورات', one: 'منشور واحد', two: 'منشوران', few: '${count} منشورات', many: '${count} منشورًا', other: '${count} منشور')}";

  static String m2(name) => "مرحباً بك مجدداً، ${name}!";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "addImageOptional": MessageLookupByLibrary.simpleMessage(
      "إضافة صورة (اختياري)",
    ),
    "addReferenceImageOnly": MessageLookupByLibrary.simpleMessage(
      "إضافة صورة مرجعية",
    ),
    "addReferenceImageOptional": MessageLookupByLibrary.simpleMessage(
      "إضافة صورة مرجعية (اختياري)",
    ),
    "addYourImage": MessageLookupByLibrary.simpleMessage("إضافة صورتك"),
    "addingDetails": MessageLookupByLibrary.simpleMessage(
      "إضافة التفاصيل واللمسات النهائية.",
    ),
    "aiBannerSubtitle": MessageLookupByLibrary.simpleMessage(
      "اكتب ما تتخيله وسيقوم الذكاء الاصطناعي بإنشاء غرفتك.",
    ),
    "aiBannerTitle": MessageLookupByLibrary.simpleMessage(
      "تصور غرفتك بالذكاء الاصطناعي",
    ),
    "aiRoomGeneration": MessageLookupByLibrary.simpleMessage(
      "إنشاء الغرف بالذكاء الاصطناعي",
    ),
    "aiRoomGenerationDesc": MessageLookupByLibrary.simpleMessage(
      "صف غرفة أحلامك بكلمات بسيطة وقم بإنشاء تصميمات داخلية واقعية على الفور.",
    ),
    "aiTag": MessageLookupByLibrary.simpleMessage("مدعوم بالذكاء الاصطناعي"),
    "all": MessageLookupByLibrary.simpleMessage("الكل"),
    "alreadyHaveAccount": MessageLookupByLibrary.simpleMessage(
      "لديك حساب بالفعل؟",
    ),
    "and": MessageLookupByLibrary.simpleMessage(" و "),
    "appdesc": MessageLookupByLibrary.simpleMessage(
      "تصميم داخلي بالذكاء الاصطناعي",
    ),
    "appname": MessageLookupByLibrary.simpleMessage("صمملي"),
    "back": MessageLookupByLibrary.simpleMessage("رجوع"),
    "backToLogin": MessageLookupByLibrary.simpleMessage("العودة لتسجيل الدخول"),
    "bathroom": MessageLookupByLibrary.simpleMessage("حمام"),
    "bedroom": MessageLookupByLibrary.simpleMessage("غرفة نوم"),
    "bohemian": MessageLookupByLibrary.simpleMessage("بوهيمي"),
    "boho": MessageLookupByLibrary.simpleMessage("بوهيمي"),
    "browseCategories": MessageLookupByLibrary.simpleMessage("تصفح الفئات"),
    "buildYourRoom": MessageLookupByLibrary.simpleMessage(
      "اختر الغرف للبناء بناءً على صورتك",
    ),
    "cancel": MessageLookupByLibrary.simpleMessage("إلغاء"),
    "cancelShare": MessageLookupByLibrary.simpleMessage("إلغاء المشاركة"),
    "changeImage": MessageLookupByLibrary.simpleMessage("تغيير الصورة"),
    "changePassword": MessageLookupByLibrary.simpleMessage("تغيير كلمة المرور"),
    "coastal": MessageLookupByLibrary.simpleMessage("ساحلي"),
    "confirmNewPassword": MessageLookupByLibrary.simpleMessage(
      "تأكيد كلمة المرور الجديدة",
    ),
    "confirmPassword": MessageLookupByLibrary.simpleMessage(
      "تأكيد كلمة المرور",
    ),
    "copyLink": MessageLookupByLibrary.simpleMessage("نسخ الرابط"),
    "country": MessageLookupByLibrary.simpleMessage("البلد"),
    "createNewAccount": MessageLookupByLibrary.simpleMessage(
      "إنشاء حسابك الجديد",
    ),
    "createNewPassword": MessageLookupByLibrary.simpleMessage(
      "إنشاء كلمة مرور جديدة",
    ),
    "createNewPasswordDesc": MessageLookupByLibrary.simpleMessage(
      "يجب أن تكون كلمة المرور الجديدة فريدة ولم يتم استخدامها من قبل.",
    ),
    "cropImage": MessageLookupByLibrary.simpleMessage("قص الصورة"),
    "currentPassword": MessageLookupByLibrary.simpleMessage(
      "كلمة المرور الحالية",
    ),
    "dateOfBirth": MessageLookupByLibrary.simpleMessage("تاريخ الميلاد"),
    "describe": MessageLookupByLibrary.simpleMessage("وصف"),
    "describeChangesHint": MessageLookupByLibrary.simpleMessage(
      "صف التغييرات التي تريدها.......",
    ),
    "describeDreamRoomHint": MessageLookupByLibrary.simpleMessage(
      "صف غرفة أحلامك.......",
    ),
    "describeYourChanges": MessageLookupByLibrary.simpleMessage("صف تغييراتك"),
    "designIdNotAvailable": MessageLookupByLibrary.simpleMessage(
      "لا يتوفر مُعرف التصميم لهذا العنصر.",
    ),
    "didntReceiveCode": MessageLookupByLibrary.simpleMessage("لم تستلم الرمز؟"),
    "diningRoom": MessageLookupByLibrary.simpleMessage("غرفة السفرة"),
    "dontHaveAccount": MessageLookupByLibrary.simpleMessage("ليس لديك حساب؟"),
    "downloadBtn": MessageLookupByLibrary.simpleMessage("تنزيل"),
    "downloadingImage": MessageLookupByLibrary.simpleMessage(
      "جاري تنزيل الصورة...",
    ),
    "drawMaskInstruction": MessageLookupByLibrary.simpleMessage(
      "ارسم على المناطق التي تريد إزالتها أو تغييرها.",
    ),
    "drawMaskTitle": MessageLookupByLibrary.simpleMessage("تحديد الجزء"),
    "dummyInviteLink": MessageLookupByLibrary.simpleMessage(
      "https://invite.Sammly.com/\nASDGFJKHHUHSULWDIH",
    ),
    "editBtn": MessageLookupByLibrary.simpleMessage("تعديل"),
    "editProfile": MessageLookupByLibrary.simpleMessage("تعديل الملف الشخصي"),
    "egp150": MessageLookupByLibrary.simpleMessage("150 ج.م"),
    "egp370": MessageLookupByLibrary.simpleMessage("370 ج.م"),
    "egp955": MessageLookupByLibrary.simpleMessage("955 ج.م"),
    "email": MessageLookupByLibrary.simpleMessage("البريد الإلكتروني"),
    "enterCodeSentTo": MessageLookupByLibrary.simpleMessage(
      "أدخل الرمز المرسل إلى",
    ),
    "enterYourEmail": MessageLookupByLibrary.simpleMessage(
      "أدخل بريدك الإلكتروني",
    ),
    "enterYourEmailHint": MessageLookupByLibrary.simpleMessage(
      "أدخل بريدك الإلكتروني",
    ),
    "enterYourMessage": MessageLookupByLibrary.simpleMessage("أدخل رسالتك"),
    "enterYourName": MessageLookupByLibrary.simpleMessage("أدخل اسمك"),
    "enterYourPasswordHint": MessageLookupByLibrary.simpleMessage(
      "أدخل كلمة المرور",
    ),
    "errorSavingImage": m0,
    "explore": MessageLookupByLibrary.simpleMessage("استكشاف"),
    "exploreBrowseCategories": MessageLookupByLibrary.simpleMessage(
      "تصفح فئات التصميم",
    ),
    "exploreBrowseCategoriesDesc": MessageLookupByLibrary.simpleMessage(
      "استكشف الأنماط والغرف الجاهزة المنظمة حسب الفئة.",
    ),
    "exploreSharedDesigns": MessageLookupByLibrary.simpleMessage(
      "استكشف التصميمات المُشارَكة",
    ),
    "exploreSharedDesignsDesc": MessageLookupByLibrary.simpleMessage(
      "تصفح الغرف التي صممها مستخدمون آخرون واستلهم منها.",
    ),
    "exploreStyles": MessageLookupByLibrary.simpleMessage("استكشف الأنماط"),
    "failedToExtractMask": MessageLookupByLibrary.simpleMessage(
      "فشل في استخراج التحديد. يرجى المحاولة مرة أخرى.",
    ),
    "favorite": MessageLookupByLibrary.simpleMessage("المفضلة"),
    "favorites": MessageLookupByLibrary.simpleMessage("المفضلة"),
    "follow": MessageLookupByLibrary.simpleMessage("متابعة"),
    "following": MessageLookupByLibrary.simpleMessage("أتابعهم"),
    "forgotPassword": MessageLookupByLibrary.simpleMessage(
      "هل نسيت كلمة المرور؟",
    ),
    "forgotPasswordDesc": MessageLookupByLibrary.simpleMessage(
      "أدخل عنوان بريدك الإلكتروني وسنرسل لك رمز تحقق لإعادة تعيين كلمة المرور",
    ),
    "forgotPasswordTitle": MessageLookupByLibrary.simpleMessage(
      "نسيت كلمة المرور",
    ),
    "foundSimilarItems": MessageLookupByLibrary.simpleMessage(
      "لقد وجدنا عناصر مشابهة لتصميمك.",
    ),
    "free": MessageLookupByLibrary.simpleMessage("مجاني"),
    "freeGenerations": MessageLookupByLibrary.simpleMessage("إنشاءات مجانية"),
    "fullHomeDesign": MessageLookupByLibrary.simpleMessage(
      "تصميم المنزل بالكامل",
    ),
    "fullHomeDesignDesc": MessageLookupByLibrary.simpleMessage(
      "قم برفع صورة غرفة واحدة وقم بإنشاء تصميمات مطابقة لبقية منزلك.",
    ),
    "fullHomeTag": MessageLookupByLibrary.simpleMessage("منزل كامل"),
    "fullName": MessageLookupByLibrary.simpleMessage("الاسم الكامل"),
    "gender": MessageLookupByLibrary.simpleMessage("الجنس"),
    "generateDesign": MessageLookupByLibrary.simpleMessage("إنشاء التصميم"),
    "generateDesignBtn": MessageLookupByLibrary.simpleMessage("توليد التصميم"),
    "generateMaskBtn": MessageLookupByLibrary.simpleMessage("تأكيد التحديد"),
    "generatedBySammly": MessageLookupByLibrary.simpleMessage(
      "تم الإنشاء بواسطة صمملي",
    ),
    "generations10": MessageLookupByLibrary.simpleMessage("10 إنشاءات مميزة"),
    "generations100": MessageLookupByLibrary.simpleMessage("100 إنشاء مميز"),
    "generations30": MessageLookupByLibrary.simpleMessage("30 إنشاء مميز"),
    "generations5": MessageLookupByLibrary.simpleMessage("3 إنشاءات مميزة"),
    "greatForStarters": MessageLookupByLibrary.simpleMessage("رائع للبدايات"),
    "greetingPrefix": MessageLookupByLibrary.simpleMessage("مرحباً،"),
    "history": MessageLookupByLibrary.simpleMessage("السجل"),
    "home": MessageLookupByLibrary.simpleMessage("الرئيسية"),
    "iAgreeToAll": MessageLookupByLibrary.simpleMessage("أوافق على جميع "),
    "imageSavedSuccess": MessageLookupByLibrary.simpleMessage(
      "تم حفظ الصورة في المعرض بنجاح!",
    ),
    "inviteFriends": MessageLookupByLibrary.simpleMessage("دعوة الأصدقاء"),
    "inviteFriendsDesc": MessageLookupByLibrary.simpleMessage(
      "أخبر صديقك أنه مجاني وسهل لإنشاء تصميمك الخاص",
    ),
    "kitchen": MessageLookupByLibrary.simpleMessage("مطبخ"),
    "likeYourSharedDesign": MessageLookupByLibrary.simpleMessage(
      "أعجب بتصميمك المشترك",
    ),
    "linkCopied": MessageLookupByLibrary.simpleMessage("تم نسخ الرابط!"),
    "livingRoom": MessageLookupByLibrary.simpleMessage("غرفة معيشة"),
    "loadingDisclaimer": MessageLookupByLibrary.simpleMessage(
      "أبقِ التطبيق مفتوحًا ولا تقفل جهازك لأن العملية قد تستغرق حوالي 10 ثوانٍ",
    ),
    "logIn": MessageLookupByLibrary.simpleMessage("تسجيل الدخول"),
    "logOut": MessageLookupByLibrary.simpleMessage("تسجيل الخروج"),
    "loginToAccount": MessageLookupByLibrary.simpleMessage(
      "تسجيل الدخول إلى حسابك",
    ),
    "logoutConfirmMsg": MessageLookupByLibrary.simpleMessage(
      "هل أنت متأكد أنك تريد تسجيل الخروج؟",
    ),
    "manageSubscription": MessageLookupByLibrary.simpleMessage(
      "إدارة الاشتراك",
    ),
    "mask": MessageLookupByLibrary.simpleMessage("تحديد"),
    "maskInpainting": MessageLookupByLibrary.simpleMessage(
      "تعديل الجزء المحدد",
    ),
    "maskInpaintingDesc": MessageLookupByLibrary.simpleMessage(
      "قم برفع صورة، ثم ارسم على المنطقة التي تريد تغييرها، وصف رؤيتك.",
    ),
    "maskInpaintingTag": MessageLookupByLibrary.simpleMessage("رسم تكميلي"),
    "message": MessageLookupByLibrary.simpleMessage("الرسالة:"),
    "midCenturyModern": MessageLookupByLibrary.simpleMessage(
      "مودرن منتصف القرن",
    ),
    "modernLivingRoom": MessageLookupByLibrary.simpleMessage(
      "غرفة معيشة حديثة",
    ),
    "mostLiked": MessageLookupByLibrary.simpleMessage("الأكثر إعجاباً"),
    "mostRecent": MessageLookupByLibrary.simpleMessage("الأحدث"),
    "myProfile": MessageLookupByLibrary.simpleMessage("حسابي"),
    "newPassword": MessageLookupByLibrary.simpleMessage("كلمة المرور الجديدة"),
    "next": MessageLookupByLibrary.simpleMessage("التالي"),
    "noDesignDetailsFound": MessageLookupByLibrary.simpleMessage(
      "لم يتم العثور على تفاصيل التصميم",
    ),
    "noDesigns": MessageLookupByLibrary.simpleMessage("لا يوجد تصميمات"),
    "noDesignsFound": MessageLookupByLibrary.simpleMessage(
      "لم يتم العثور على تصميمات",
    ),
    "noFavorites": MessageLookupByLibrary.simpleMessage("لا توجد مفضلة"),
    "noFavoritesDesc": MessageLookupByLibrary.simpleMessage(
      "قائمة المفضلة لديك فارغة",
    ),
    "noFollowings": MessageLookupByLibrary.simpleMessage("لا توجد متابعات"),
    "noFollowingsDesc": MessageLookupByLibrary.simpleMessage(
      "تصفح التصميمات وتابع الآخرين",
    ),
    "noHistory": MessageLookupByLibrary.simpleMessage("لا يوجد سجل"),
    "noHistoryDesc": MessageLookupByLibrary.simpleMessage(
      "قائمة السجل الخاصة بك فارغة",
    ),
    "noNotifications": MessageLookupByLibrary.simpleMessage("لا توجد إشعارات"),
    "noNotificationsDesc": MessageLookupByLibrary.simpleMessage(
      "صندوق الإشعارات فارغ",
    ),
    "noSharedDesigns": MessageLookupByLibrary.simpleMessage(
      "لا يوجد تصميمات مشاركة",
    ),
    "noSharedDesignsFound": MessageLookupByLibrary.simpleMessage(
      "لم يتم العثور على تصميمات مشاركة",
    ),
    "notification": MessageLookupByLibrary.simpleMessage("الإشعارات"),
    "onboarding1Subtitle": MessageLookupByLibrary.simpleMessage(
      "قم بإنشاء تصميمات غرف جديدة من النصوص أو قم بتعديل الغرف الحالية باستخدام الصور المرفوعة.",
    ),
    "onboarding1Title": MessageLookupByLibrary.simpleMessage(
      "صمم مساحتك بالذكاء الاصطناعي",
    ),
    "onboarding2Subtitle": MessageLookupByLibrary.simpleMessage(
      "حدد أي عنصر في الصورة المُنشأة واكتشف أين يتوفر.",
    ),
    "onboarding2Title": MessageLookupByLibrary.simpleMessage(
      "ابحث عن عناصر في تصميمك",
    ),
    "onboarding3Subtitle": MessageLookupByLibrary.simpleMessage(
      "استكشف تصميمات المجتمع، شارك إبداعاتك، واكسب عملات مجانية كمكافآت.",
    ),
    "onboarding3Title": MessageLookupByLibrary.simpleMessage(
      "شارك واكسب عملات",
    ),
    "orLoginWith": MessageLookupByLibrary.simpleMessage(
      "أو تسجيل الدخول باستخدام",
    ),
    "orShareOn": MessageLookupByLibrary.simpleMessage("أو شارك على...."),
    "orSignupWith": MessageLookupByLibrary.simpleMessage("أو التسجيل باستخدام"),
    "passwordAtLeast8Chars": MessageLookupByLibrary.simpleMessage(
      "يجب أن تتكون كلمة المرور من 8 أحرف على الأقل",
    ),
    "passwordChanged": MessageLookupByLibrary.simpleMessage(
      "تم تغيير كلمة المرور!",
    ),
    "passwordChangedDesc": MessageLookupByLibrary.simpleMessage(
      "تم تغيير كلمة المرور بنجاح.",
    ),
    "passwordChangedSuccess": MessageLookupByLibrary.simpleMessage(
      "تم تغيير كلمة المرور بنجاح!",
    ),
    "passwordsDoNotMatch": MessageLookupByLibrary.simpleMessage(
      "كلمتا المرور غير متطابقتين",
    ),
    "perPack": MessageLookupByLibrary.simpleMessage("/باقة"),
    "perfectWayToTry": MessageLookupByLibrary.simpleMessage(
      "طريقة مثالية لتجربة SAMMLY\nواستكشاف الميزات المميزة",
    ),
    "phoneNumber": MessageLookupByLibrary.simpleMessage("رقم الهاتف"),
    "pickPerfectPlan": MessageLookupByLibrary.simpleMessage(
      "اختر الخطة المثالية لتحويل مساحات\nأحلامك إلى حقيقة",
    ),
    "planDesc1": MessageLookupByLibrary.simpleMessage("رائع للبداية"),
    "planDesc2": MessageLookupByLibrary.simpleMessage("الأكثر طلباً"),
    "planDesc3": MessageLookupByLibrary.simpleMessage("الخيار الأفضل للمصممين"),
    "planDesc4": MessageLookupByLibrary.simpleMessage(
      "للاستخدام المكثف والاحترافي",
    ),
    "planPremium": MessageLookupByLibrary.simpleMessage("مميز"),
    "planPro": MessageLookupByLibrary.simpleMessage("احترافي"),
    "planStarter": MessageLookupByLibrary.simpleMessage("البداية"),
    "pleaseAcceptTerms": MessageLookupByLibrary.simpleMessage(
      "يرجى الموافقة على الشروط والأحكام",
    ),
    "pleaseConfirmYourNewPassword": MessageLookupByLibrary.simpleMessage(
      "الرجاء تأكيد كلمة المرور الجديدة",
    ),
    "pleaseConfirmYourPassword": MessageLookupByLibrary.simpleMessage(
      "الرجاء تأكيد كلمة المرور",
    ),
    "pleaseDescribeYourDreamRoom": MessageLookupByLibrary.simpleMessage(
      "الرجاء وصف غرفة أحلامك.",
    ),
    "pleaseEnter6DigitCode": MessageLookupByLibrary.simpleMessage(
      "يرجى إدخال الرمز المكون من 6 أرقام",
    ),
    "pleaseEnterAllDigits": MessageLookupByLibrary.simpleMessage(
      "يرجى إدخال جميع الأرقام الأربعة",
    ),
    "pleaseEnterDescription": MessageLookupByLibrary.simpleMessage(
      "يرجى كتابة وصف للتصميم.",
    ),
    "pleaseEnterValidEmail": MessageLookupByLibrary.simpleMessage(
      "يرجى إدخال عنوان بريد إلكتروني صالح",
    ),
    "pleaseEnterYourEmail": MessageLookupByLibrary.simpleMessage(
      "يرجى إدخال بريدك الإلكتروني",
    ),
    "pleaseEnterYourMessage": MessageLookupByLibrary.simpleMessage(
      "يرجى إدخال رسالتك",
    ),
    "pleaseEnterYourName": MessageLookupByLibrary.simpleMessage(
      "الرجاء إدخال اسمك",
    ),
    "pleaseEnterYourNewPassword": MessageLookupByLibrary.simpleMessage(
      "الرجاء إدخال كلمة المرور الجديدة",
    ),
    "pleaseEnterYourOldPassword": MessageLookupByLibrary.simpleMessage(
      "الرجاء إدخال كلمة المرور القديمة",
    ),
    "pleaseEnterYourPassword": MessageLookupByLibrary.simpleMessage(
      "الرجاء إدخال كلمة المرور",
    ),
    "pleaseSelectARoom": MessageLookupByLibrary.simpleMessage(
      "الرجاء اختيار غرفة",
    ),
    "pleaseSelectAStyle": MessageLookupByLibrary.simpleMessage(
      "الرجاء اختيار نمط",
    ),
    "pleaseSelectAtLeastOneRoom": MessageLookupByLibrary.simpleMessage(
      "الرجاء اختيار غرفة واحدة على الأقل",
    ),
    "pleaseSelectSubject": MessageLookupByLibrary.simpleMessage(
      "يرجى اختيار موضوع",
    ),
    "pleaseUploadImage": MessageLookupByLibrary.simpleMessage(
      "الرجاء رفع صورة أولاً",
    ),
    "pleaseUploadImageFirst": MessageLookupByLibrary.simpleMessage(
      "يرجى رفع صورة أولاً",
    ),
    "pleaseVerifyEmail": MessageLookupByLibrary.simpleMessage(
      "يرجى التحقق من بريدك الإلكتروني للمتابعة.",
    ),
    "postsCountLabel": m1,
    "privacyPolicy": MessageLookupByLibrary.simpleMessage("سياسة الخصوصية"),
    "privacyPolicyText": MessageLookupByLibrary.simpleMessage(
      "نحن نحترم خصوصيتك ونلتزم بحماية معلوماتك الشخصية.\n\nقد يقوم تطبيقنا بجمع معلومات محدودة مثل عنوان بريدك الإلكتروني، ومدخلات المستخدم (الأوامر النصية)، والصور التي يتم إنشاؤها داخل التطبيق.\n\nتُستخدم هذه المعلومات فقط لتحسين تجربة المستخدم وتقديم خدمات أفضل.\n\nنحن لا نبيع معلوماتك الشخصية أو نتاجر بها أو نشاركها مع أطراف ثالثة.\n\nيتم التعامل مع جميع البيانات بأمان واستخدامها فقط لغرض تشغيل التطبيق وتحسينه.\n\nباستخدامك هذا التطبيق، فإنك توافق على جمع المعلومات واستخدامها وفقًا لسياسة الخصوصية هذه.",
    ),
    "profile": MessageLookupByLibrary.simpleMessage("حسابي"),
    "profileUpdatedSuccess": MessageLookupByLibrary.simpleMessage(
      "تم تحديث الملف الشخصي بنجاح!",
    ),
    "promptLabel": MessageLookupByLibrary.simpleMessage("الوصف : "),
    "registrationSuccessVerifyEmail": MessageLookupByLibrary.simpleMessage(
      "تم التسجيل بنجاح! يرجى التحقق من بريدك الإلكتروني لتأكيد حسابك.",
    ),
    "remove": MessageLookupByLibrary.simpleMessage("إزالة"),
    "removeDesc": MessageLookupByLibrary.simpleMessage(
      "قم برفع صورة، ثم ارسم على المنطقة التي تريد إزالتها",
    ),
    "removeObject": MessageLookupByLibrary.simpleMessage("إزالة كائن"),
    "replace": MessageLookupByLibrary.simpleMessage("استبدال"),
    "replaceObject": MessageLookupByLibrary.simpleMessage("استبدال كائن"),
    "resendCode": MessageLookupByLibrary.simpleMessage("إعادة إرسال الرمز"),
    "resetPassword": MessageLookupByLibrary.simpleMessage(
      "إعادة تعيين كلمة المرور",
    ),
    "restyleRoomTag": MessageLookupByLibrary.simpleMessage(
      "إعادة تنسيق الغرفة",
    ),
    "restyleThisDesign": MessageLookupByLibrary.simpleMessage(
      "إعادة تصميم هذا التصميم",
    ),
    "restyleYourSpace": MessageLookupByLibrary.simpleMessage(
      "إعادة تنسيق مساحتك",
    ),
    "retry": MessageLookupByLibrary.simpleMessage("إعادة المحاولة"),
    "roomRedesign": MessageLookupByLibrary.simpleMessage("إعادة تصميم الغرفة"),
    "roomRedesignDesc": MessageLookupByLibrary.simpleMessage(
      "حوّل غرفتك الحالية إلى نمط جديد تمامًا مع الحفاظ على نفس التصميم.",
    ),
    "roomRestyle": MessageLookupByLibrary.simpleMessage("إعادة تنسيق الغرفة"),
    "rustic": MessageLookupByLibrary.simpleMessage("ريفي"),
    "sammlyPro": MessageLookupByLibrary.simpleMessage("SAMMLY Pro"),
    "savingImage": MessageLookupByLibrary.simpleMessage(
      "جاري حفظ الصورة في المعرض...",
    ),
    "searchDesigns": MessageLookupByLibrary.simpleMessage(
      "البحث في التصميمات...",
    ),
    "searchHint": MessageLookupByLibrary.simpleMessage("ابحث عن......"),
    "security": MessageLookupByLibrary.simpleMessage("الأمان"),
    "select": MessageLookupByLibrary.simpleMessage("اختيار"),
    "selectRoom": MessageLookupByLibrary.simpleMessage("اختر الغرفة"),
    "selectStyle": MessageLookupByLibrary.simpleMessage("اختر النمط"),
    "selectSubject": MessageLookupByLibrary.simpleMessage("اختر الموضوع"),
    "selectYourGender": MessageLookupByLibrary.simpleMessage("اختر جنسك"),
    "sendCode": MessageLookupByLibrary.simpleMessage("إرسال الرمز"),
    "share": MessageLookupByLibrary.simpleMessage("مشاركة"),
    "shared": MessageLookupByLibrary.simpleMessage("تمت المشاركة"),
    "sharedDesign": MessageLookupByLibrary.simpleMessage("تصميم مُشارَك"),
    "sharedDesigns": MessageLookupByLibrary.simpleMessage("التصميمات المشاركة"),
    "sharedImages": MessageLookupByLibrary.simpleMessage("الصور المُشارَكة"),
    "signUp": MessageLookupByLibrary.simpleMessage("إنشاء حساب"),
    "signUpTitle": MessageLookupByLibrary.simpleMessage("إنشاء حساب"),
    "similarItems": MessageLookupByLibrary.simpleMessage("عناصر مشابهة"),
    "skip": MessageLookupByLibrary.simpleMessage("تخطي"),
    "smartLens": MessageLookupByLibrary.simpleMessage("العدسة الذكية"),
    "startGenerateBtn": MessageLookupByLibrary.simpleMessage("بدء الإنشاء"),
    "style": MessageLookupByLibrary.simpleMessage("النمط"),
    "subject": MessageLookupByLibrary.simpleMessage("الموضوع"),
    "subjectAccountProblem": MessageLookupByLibrary.simpleMessage(
      "مشكلة في الحساب",
    ),
    "subjectBugReport": MessageLookupByLibrary.simpleMessage("الإبلاغ عن خطأ"),
    "subjectFeatureRequest": MessageLookupByLibrary.simpleMessage("طلب ميزة"),
    "subjectLoginIssue": MessageLookupByLibrary.simpleMessage(
      "مشكلة في تسجيل الدخول",
    ),
    "subjectOther": MessageLookupByLibrary.simpleMessage("أخرى"),
    "subjectPasswordReset": MessageLookupByLibrary.simpleMessage(
      "إعادة تعيين كلمة المرور",
    ),
    "subjectRegistrationProblem": MessageLookupByLibrary.simpleMessage(
      "مشكلة في التسجيل",
    ),
    "subjectReportUser": MessageLookupByLibrary.simpleMessage(
      "الإبلاغ عن مستخدم",
    ),
    "subjectTechnicalSupport": MessageLookupByLibrary.simpleMessage(
      "الدعم الفني",
    ),
    "subjectVerificationCode": MessageLookupByLibrary.simpleMessage(
      "رمز التحقق",
    ),
    "submit": MessageLookupByLibrary.simpleMessage("إرسال"),
    "subscribe": MessageLookupByLibrary.simpleMessage("اشترك"),
    "subtitle": MessageLookupByLibrary.simpleMessage("دعنا نصمم مساحة أحلامك."),
    "support": MessageLookupByLibrary.simpleMessage("الدعم"),
    "supportEagerToAssist": MessageLookupByLibrary.simpleMessage(
      "نحن حريصون على مساعدتك.",
    ),
    "supportQuestion": MessageLookupByLibrary.simpleMessage("هل تواجه مشكلة؟"),
    "supportReachOut": MessageLookupByLibrary.simpleMessage(
      "تواصل معنا عبر البريد الإلكتروني.",
    ),
    "supportRequestSuccess": MessageLookupByLibrary.simpleMessage(
      "تم إرسال طلب الدعم بنجاح!",
    ),
    "termsConditions": MessageLookupByLibrary.simpleMessage("الشروط والأحكام"),
    "termsConditionsText": MessageLookupByLibrary.simpleMessage(
      "من خلال الوصول إلى هذا التطبيق واستخدامه، فإنك توافق على الالتزام بالشروط والأحكام الموضحة أدناه.\n\nالمستخدمون مسؤولون عن المحتوى الذي يقومون بإنشائه أو مشاركته داخل التطبيق.\n\nيُحظر تماماً أي استخدام ضار أو غير قانوني أو غير لائق للتطبيق.\n\nالتطبيق مخصص للاستخدام الشخصي وغير التجاري فقط.\n\nنحتفظ بالحق في تحديث أو تعديل هذه الشروط في أي وقت دون إشعار مسبق.\n\nالاستمرار في استخدام التطبيق يعني قبولك لأي تغييرات تطرأ على هذه الشروط.",
    ),
    "tokens": MessageLookupByLibrary.simpleMessage("نقطة"),
    "traditional": MessageLookupByLibrary.simpleMessage("تقليدي"),
    "type": MessageLookupByLibrary.simpleMessage("النوع"),
    "unfollow": MessageLookupByLibrary.simpleMessage("إلغاء المتابعة"),
    "update": MessageLookupByLibrary.simpleMessage("تحديث"),
    "upgradePro": MessageLookupByLibrary.simpleMessage("الترقية لـ Pro"),
    "upload": MessageLookupByLibrary.simpleMessage("رفع"),
    "uploadImage": MessageLookupByLibrary.simpleMessage("رفع صورة"),
    "uploadReferenceImage": MessageLookupByLibrary.simpleMessage(
      "رفع صورة مرجعية",
    ),
    "uploadRoom": MessageLookupByLibrary.simpleMessage("رفع غرفة"),
    "uploadRoomImage": MessageLookupByLibrary.simpleMessage("رفع صورة الغرفه"),
    "uploadYourImage": MessageLookupByLibrary.simpleMessage("رفع صورتك"),
    "userName": MessageLookupByLibrary.simpleMessage("اسم المستخدم"),
    "verification": MessageLookupByLibrary.simpleMessage("التحقق"),
    "verificationCodeResent": MessageLookupByLibrary.simpleMessage(
      "تم إعادة إرسال رمز التحقق إلى بريدك الإلكتروني",
    ),
    "verificationCodeSent": MessageLookupByLibrary.simpleMessage(
      "تم إرسال رمز التحقق!",
    ),
    "verify": MessageLookupByLibrary.simpleMessage("تحقق"),
    "viewAll": MessageLookupByLibrary.simpleMessage("عرض الكل"),
    "viewMyPosts": MessageLookupByLibrary.simpleMessage("عرض منشوراتي"),
    "visualizeYourSpace": MessageLookupByLibrary.simpleMessage("تصور مساحتك"),
    "waitText": MessageLookupByLibrary.simpleMessage("انتظر..."),
    "welcomeBack": MessageLookupByLibrary.simpleMessage("مرحباً بعودتك"),
    "welcomeBackSnackbar": m2,
    "yourGeneratedDesign": MessageLookupByLibrary.simpleMessage(
      "تصميماتك المُنشأة",
    ),
    "yourRoomIsComingSoon": MessageLookupByLibrary.simpleMessage(
      "غرفتك قادمة قريباً...",
    ),
  };
}
