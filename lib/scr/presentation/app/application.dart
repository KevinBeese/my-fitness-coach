import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../app/routes/app_routes.dart';
import '../theme/style/styles.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Fitness Coach',
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: ThemeMode.system,
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      initialRoute: AppRoutes.root,
      routes: appRoutes,
    );
  }
}
