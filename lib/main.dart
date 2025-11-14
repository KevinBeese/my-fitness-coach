import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'scr/presentation/app/application.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  const supabaseUrl = String.fromEnvironment('SUPABASE_URL');
  const supabaseAnonKey = String.fromEnvironment('SUPABASE_ANON_KEY');
  const flavor = String.fromEnvironment('FLAVOR', defaultValue: 'dev');

  debugPrint('🚀 Starting my-fitness-coach [$flavor]');
  debugPrint('Supabase URL: $supabaseUrl');

  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseAnonKey,
    authOptions: const FlutterAuthClientOptions(authFlowType: AuthFlowType.pkce, autoRefreshToken: true),
  );

  runApp(
    ProviderScope(
      child: EasyLocalization(
        supportedLocales: const [Locale('de'), Locale('en')],
        path: 'assets/translations',
        fallbackLocale: const Locale('de'),
        child: const Application(),
      ),
    ),
  );
}
