import 'dart:io';

import 'package:flutter/material.dart';
import 'package:myapp/ui/home_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:myapp/providers/main_provider.dart';


class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MainProvider mainProvider = MainProvider();
    mainProvider.fetchMainModel();
    return ChangeNotifierProvider.value(
      value: mainProvider,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Inovola Task',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Cairo',
          textTheme: TextTheme(
            headline1: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold, color: Color(0xff9398ac)),
            headline2: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Color(0xffadb1c4)),
            headline3: TextStyle(fontSize: 27.0, fontWeight: FontWeight.bold, color: Color(0xff9398ac)),
            headline4: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold, color: Color(0xffadb1c4)),
            bodyText1: TextStyle(fontSize: 14.0, color: Color(0xffadb1c4), fontWeight: FontWeight.w600),
            bodyText2: TextStyle(fontSize: 24.0, color: Color(0xffadb1c4), fontWeight: FontWeight.w600),
          ),
        ),
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
        locale: Locale('ar'),
      ),
    );
  }
}

