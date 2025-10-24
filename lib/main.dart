import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/core.dart';
import 'features/auth/presentation/providers/providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FirebaseInitializer.initialize();
  final sharedPreferences = await SharedPreferences.getInstance();
  await initializeDateFormatting('es_PE', null);

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'TaskMaster Pro',
      debugShowCheckedModeBanner: false,
      locale: const Locale('es', 'PE'),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF007AFF)),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
