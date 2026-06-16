import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sammly/core/shared_pref/shared_pref.dart';

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit() : super(const Locale('en')) {
    _loadLocale();
  }

  void _loadLocale() {
    final String? languageCode = SharedPref.getData(key: 'language_code');
    if (languageCode != null) {
      emit(Locale(languageCode));
    }
  }

  void toggleLanguage() {
    final newLocale = state.languageCode == 'en'
        ? const Locale('ar')
        : const Locale('en');
    SharedPref.saveData(key: 'language_code', value: newLocale.languageCode);
    emit(newLocale);
  }
}
