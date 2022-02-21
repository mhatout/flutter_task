import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../util/sharedPrefs.dart';
import '../../main.dart';
import 'graph_screen.dart';
import 'metrics_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String langCode = Localizations.localeOf(context).languageCode;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.theme.primaryColor,
        elevation: 0,
        title: Text(
          'homeScreen_header'.tr,
          style: Get.theme.textTheme.headline1,
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => _changeLang(context, langCode),
              icon: Icon(Icons.translate))
        ],
      ),
      body: _BuildPageBody(),
    );
  }

  _changeLang(context, String? langCode) {
    SharedPrefs prefs = SharedPrefs.getInstance()!;
    if (langCode == 'ar') {
      // step one, save the chosen locale
      prefs.saveData('langCode', 'en');
      // step two, rebuild the whole app, with the new locale
      Get.updateLocale(Locale('en'));
      MyApp.setLocale(context, Locale('en'));
    } else {
      // step one, save the chosen locale
      prefs.saveData('langCode', 'ar');
      // step two, rebuild the whole app, with the new locale
      Get.updateLocale(Locale('ar'));
      MyApp.setLocale(context, Locale('ar'));
    }
  }
}

class _BuildPageBody extends StatelessWidget {
  const _BuildPageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double shortestSide = MediaQuery.of(context).size.shortestSide;
    // Determine if we should use mobile layout or not, 600 here is
    // a common breakpoint for a typical 7-inch tablet.
    bool useMobileLayout = shortestSide < 600;
    return Container(
      padding: EdgeInsets.all(40),
      child: useMobileLayout
          ? Column(
              children: [
                _buildMobileButton(
                    'assets/img/metrics.jpg',
                    'homeScreen_metricsBtn'.tr,
                    () => Get.to(() => MetricsScreen())),
                const SizedBox(
                  height: 20,
                ),
                _buildMobileButton(
                    'assets/img/graph.jpeg',
                    'homeScreen_graphBtn'.tr,
                    () => Get.to(() => GraphScreen())),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildMobileButton(
                    'assets/img/metrics.jpg',
                    'homeScreen_metricsBtn'.tr,
                    () => Get.to(() => MetricsScreen()),
                    isMobile: useMobileLayout),
                const SizedBox(
                  width: 20,
                ),
                _buildMobileButton('assets/img/graph.jpeg',
                    'homeScreen_graphBtn'.tr, () => Get.to(() => GraphScreen()),
                    isMobile: useMobileLayout),
              ],
            ),
    );
  }

  Widget _buildMobileButton(String img, String title, Function callback,
      {bool isMobile = true}) {
    return GestureDetector(
      onTap: () => callback(),
      child: Container(
        height: 200,
        width: isMobile ? Get.width : Get.width * 0.3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          image: DecorationImage(image: AssetImage(img), fit: BoxFit.cover),
        ),
        child: Stack(
          children: [
            Positioned(
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                  //color: Colors.black.withOpacity(0.5),
                  gradient: LinearGradient(
                      begin: FractionalOffset.topCenter,
                      end: FractionalOffset.bottomCenter,
                      colors: [
                        Get.theme.primaryColorDark.withOpacity(0.0),
                        Get.theme.primaryColorDark.withOpacity(0.8),
                      ],
                      stops: [
                        0.0,
                        1.0
                      ]),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Container(
                  // padding: EdgeInsets.all(5),
                  child: Center(
                    child: Text(
                      title,
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              bottom: 0,
              left: 0,
              right: 0,
            ),
          ],
        ),
      ),
    );
  }
}
