import 'package:flutter/material.dart';
import 'package:ices_live_viewer/pages/home.dart';
import 'package:ices_live_viewer/pages/v2/newhome.dart';
import 'package:ices_live_viewer/utils/theme.dart';
import 'package:ices_live_viewer/provider/themeprovider.dart';
import 'package:ices_live_viewer/utils/init/ioinit.dart'
    if (dart.library.html) 'package:ices_live_viewer/utils/init/htmlinit.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  init();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  final bool enableNewHome = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (context) => AppLocalizations.of(context)!.app_title,
      themeMode: Provider.of<AppThemeProvider>(context).themeMode,
      theme: MyTheme(Provider.of<AppThemeProvider>(context).themeColor)
          .lightThemeData,
      darkTheme: MyTheme(Provider.of<AppThemeProvider>(context).themeColor)
          .darkThemeData,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English
        Locale('zh', ''), // Chinese
      ],
      home: enableNewHome ? const NewHome() : const Home(),
    );
  }
}
