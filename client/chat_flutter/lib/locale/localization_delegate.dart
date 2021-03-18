import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show SynchronousFuture;

import 'localizations.dart';
class ZMKLocalizationsDelegate extends LocalizationsDelegate<ZMKLocalizations> {
  const ZMKLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'vi'].contains(locale.languageCode);

  @override
  Future<ZMKLocalizations> load(Locale locale) {
    // Returning a SynchronousFuture here because an async "load" operation
    // isn't needed to produce an instance of DemoLocalizations.
    return SynchronousFuture<ZMKLocalizations>(ZMKLocalizations(locale));
  }

  @override
  bool shouldReload(ZMKLocalizationsDelegate old) => false;
}