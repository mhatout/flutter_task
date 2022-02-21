import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:myapp/ui/screens/graph_screen.dart';
import 'package:myapp/ui/screens/metrics_screen.dart';

import 'controllers/app_controller.dart';
import 'ui/screens/home_screen.dart';
import 'util/sharedPrefs.dart';
import 'util/theme.dart';
import 'util/translations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    print(newLocale.languageCode);
    // ignore: invalid_use_of_protected_member
    state!.setState(() => state.locale = newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale? locale;
  AppController appController = Get.put(AppController());

  @override
  void initState() {
    super.initState();
    _setInitialData();
    setState(() => this.locale = _fetchLocale());
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Task',
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaleFactor: 1.0,
          ),
          child: child!,
        );
      },
      theme: AppTheme.theme,
      translations: MyTranslation(),
      home: HomeScreen(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en'), // English
        const Locale('ar'), // Arabic
      ],
      locale: this.locale,
      localeResolutionCallback: (deviceLocale, supportedLocales) {
        if (this.locale == null) {
          this.locale = deviceLocale!.languageCode == 'en' ||
                  deviceLocale.languageCode == 'ar'
              ? deviceLocale
              : Locale('ar');
          Get.locale = deviceLocale.languageCode == 'en' ||
                  deviceLocale.languageCode == 'ar'
              ? deviceLocale
              : Locale('ar');
        }
        return this.locale;
      },
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        "/MetricsScreen": (context) => MetricsScreen(),
        "/GraphScreen": (context) => GraphScreen(),
      },
    );
  }

  Future<void> _setInitialData() async => await appController.getOrders();

  _fetchLocale() {
    if (SharedPrefs.getInstance()!.getData('langCode') == null) return null;
    return Locale(SharedPrefs.getInstance()!.getData('langCode'));
  }
}
