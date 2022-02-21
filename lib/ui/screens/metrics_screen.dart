// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/app_controller.dart';
import '../../models/orders.dart';

class MetricsScreen extends StatelessWidget {
  MetricsScreen({Key? key}) : super(key: key);
  AppController appController = Get.find<AppController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Get.theme.primaryColor,
          elevation: 0,
          title: Text(
            'metricsScreen_header'.tr,
            style: Get.theme.textTheme.headline1,
          ),
        ),
        body: GetBuilder<AppController>(builder: (appController) {
          return appController.loading
              ? CircularProgressIndicator()
              : SingleChildScrollView(
                  child: _BuildPageBody(),
                );
        }));
  }
}

class _BuildPageBody extends StatelessWidget {
  _BuildPageBody({Key? key}) : super(key: key);
  AppController appController = Get.find<AppController>();
  @override
  Widget build(BuildContext context) {
    double shortestSide = MediaQuery.of(context).size.shortestSide;
    // Determine if we should use mobile layout or not, 600 here is
    // a common breakpoint for a typical 7-inch tablet.
    bool useMobileLayout = shortestSide < 600;
    return Container(
      width: Get.width,
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: useMobileLayout
          ? Column(
              children: [
                _buildStatSection(
                    'metricsScreen_orderCount'.tr,
                    appController.orders.length.toString(),
                    Icons.shopping_cart_rounded),
                _buildStatSection(
                    'metricsScreen_priceAverage'.tr,
                    _calculatePricesAverage(appController.orders),
                    Icons.attach_money_rounded),
                _buildStatSection(
                    'metricsScreen_returnCount'.tr,
                    _countReturnedOrders(appController.orders),
                    Icons.remove_shopping_cart_rounded),
              ],
            )
          : Wrap(
              alignment: WrapAlignment.center,
              children: [
                _buildStatSection(
                    'metricsScreen_orderCount'.tr,
                    appController.orders.length.toString(),
                    Icons.shopping_cart_rounded,
                    isMobile: useMobileLayout),
                const SizedBox(
                  width: 20,
                ),
                _buildStatSection(
                    'metricsScreen_priceAverage'.tr,
                    _calculatePricesAverage(appController.orders),
                    Icons.attach_money_rounded,
                    isMobile: useMobileLayout),
                _buildStatSection(
                    'metricsScreen_returnCount'.tr,
                    _countReturnedOrders(appController.orders),
                    Icons.remove_shopping_cart_rounded,
                    isMobile: useMobileLayout),
              ],
            ),
    );
  }

  Widget _buildStatSection(String title, String val, IconData icon,
      {bool isMobile = true}) {
    return Container(
      width: isMobile ? Get.width * 0.7 : Get.width * 0.45,
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/img/metric_background.png'),
            fit: BoxFit.cover),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: Get.theme.textTheme.headline1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Get.theme.primaryColorLight,
                size: 23,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                val,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Get.theme.primaryColorLight,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  String _calculatePricesAverage(List<Orders> orders) {
    double? pricesSum = orders
        .map((e) => double.tryParse(e.price!.substring(1).replaceAll(',', '')))
        .toList()
        .reduce((a, b) => a! + b!);
    return (pricesSum! / orders.length).toStringAsFixed(2);
  }

  String _countReturnedOrders(List<Orders> orders) => orders
      .where((e) => e.status == Status.RETURNED)
      .toList()
      .length
      .toString();
}
