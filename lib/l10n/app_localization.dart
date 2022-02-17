import 'package:arbo/app/modules/core/app_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class S extends AppLocalizations {
  S(String locale) : super(locale);

  static AppLocalizations get to => AppLocalizations.of(globalMessangerKey.currentState!.context)!;

  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
