import 'package:app_todo/ui/home/home-screen.dart';
import 'package:app_todo/ui/home/list-tasks/list_tasks.dart';
import 'package:app_todo/ui/home/settings/settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ui/home/app-provider/app_provider.dart';
import 'ui/home/my-theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseFirestore.instance.settings = Settings(persistenceEnabled: true);
  FirebaseFirestore.instance.settings =
      Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  await FirebaseFirestore.instance.disableNetwork();
  runApp(ChangeNotifierProvider(
      create: (context) {
        return AppProvider();
      },
      child: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AppProvider provider;
  @override
  void initState() {
    initSharedPrefs();
    
  }
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppProvider>(context);
    return MaterialApp(
      localizationsDelegates: [
        AppLocalizations.delegate, // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'),
        Locale('ar'),
      ],
      locale: Locale(provider.appLanguage),
      debugShowCheckedModeBanner: false,
      title: "TodoApp",
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        TapListTasks.routeName: (context) => TapListTasks(),
        TapSettings.routeName: (context) => TapSettings(),
        EditTask.routeName: (context) => EditTask(),
      },
      initialRoute: HomeScreen.routeName,
      theme: MyThemeData.lightTheme,
      darkTheme: MyThemeData.darkTheme,
      themeMode: provider.appTheme,
    );
  }

  void initSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    provider.changeAppLanguage(prefs.getString('language') ?? 'en');
    if (prefs.getString('theme') == 'light') {
      provider.changeAppTheme(ThemeMode.light);
    } else if (prefs.getString('theme') == 'dark') {
      provider.changeAppTheme(ThemeMode.dark);
    }
  }
}
