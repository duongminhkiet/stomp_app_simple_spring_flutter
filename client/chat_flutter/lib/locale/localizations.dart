import 'package:flutter/material.dart';

class ZMKLocalizations {
  ZMKLocalizations(this.locale);

  final Locale locale;

  static ZMKLocalizations of(BuildContext context) {
    return Localizations.of<ZMKLocalizations>(context, ZMKLocalizations);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'ok_btn': 'OK',
      'cancel_btn': 'Cancel',
      'title': 'Realtime chat App Stomp',
      'first_screen_1': 'first_screen_1 EN',
      'login_title_home': '',
      'login_title_home_username': 'Tài khoản',
      'login_title_home_password': 'Mật khẩu',
      'login_title_home_login': 'Đăng nhập',
      'home_title': 'Danh sách chát',
      'home_right_btn': 'Tạo Room',
      'chat_hint_enterchat': 'Nhập nội dung chát',
    },
    'vi': {
      'ok_btn': 'OK',
      'cancel_btn': 'Cancel',
      'title': 'Realtime chat App Stomp',
      'first_screen_1': 'first_screen_1 việt',
      'login_title_home': '',
      'login_title_home_username': 'Tài khoản',
      'login_title_home_password': 'Mật khẩu',
      'login_title_home_login': 'Đăng nhập',
      'home_title': 'Danh sách chát',
      'home_right_btn': 'Tạo Room',
      'chat_hint_enterchat': 'Nhập nội dung chát',
    },
  };
  String get chat_hint_enterchat {
    return _localizedValues[locale.languageCode]['chat_hint_enterchat'];
  }

  String get cancel_btn {
    return _localizedValues[locale.languageCode]['cancel_btn'];
  }

  String get ok_btn {
    return _localizedValues[locale.languageCode]['ok_btn'];
  }

  String get home_right_btn {
    return _localizedValues[locale.languageCode]['home_right_btn'];
  }

  String get home_title {
    return _localizedValues[locale.languageCode]['home_title'];
  }

  String get title {
    return _localizedValues[locale.languageCode]['title'];
  }

  String get first_screen_1 {
    return _localizedValues[locale.languageCode]['first_screen_1'];
  }

  String get login_title_home {
    return _localizedValues[locale.languageCode]['login_title_home'];
  }

  String get login_title_home_username {
    return _localizedValues[locale.languageCode]['login_title_home_username'];
  }

  String get login_title_home_password {
    return _localizedValues[locale.languageCode]['login_title_home_password'];
  }

  String get login_title_home_login {
    return _localizedValues[locale.languageCode]['login_title_home_login'];
  }
}
