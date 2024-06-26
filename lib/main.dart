import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/config/constants/application_theme_manager.dart';
import 'package:todo_app/core/config/constants/page_routes.dart';
import 'package:todo_app/core/config/constants/routes.dart';
import 'package:todo_app/core/config/constants/settings_provider.dart';
import 'package:todo_app/core/services/loading_service.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
    create: (context) => SettingsProvider()..getLanguage()..getTheme()..checkCurrentUser(),
    child: const TodoApp(),
  ));
  configLoading();
}

class TodoApp extends StatefulWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  @override
  void initState() {
    super.initState();
    SettingsProvider().checkCurrentUser();
  }
  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<SettingsProvider>(context);
    return MaterialApp(
      builder: EasyLoading.init(
        builder: BotToastInit(),
      ),
      navigatorKey: navigatorKey,
      navigatorObservers: [BotToastNavigatorObserver()],
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(vm.currentLanguage),
      debugShowCheckedModeBanner: false,
      themeMode: vm.currentTheme,
      theme: ApplicationThemeManager.lightTheme,
      darkTheme: ApplicationThemeManager.darkTheme,
      initialRoute: PageRoutesName.splash,
      onGenerateRoute: Routes.onGenerate,
    );
  }
}
