// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../models/orders.dart';
import '../../controllers/app_controller.dart';

class GraphScreen extends StatelessWidget {
  const GraphScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.theme.primaryColor,
        elevation: 0,
        title: Text(
          'graphScreen_header'.tr,
          style: Get.theme.textTheme.headline1,
        ),
      ),
      body: SingleChildScrollView(
        child: _BuildPageBody(),
      ),
    );
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
    return Center(
      child: Container(
        width: useMobileLayout ? Get.width : Get.width * 0.7,
        padding: EdgeInsets.all(20),
        child: SfCartesianChart(
            title: ChartTitle(
              text: 'graphScreen_chartHeader'.tr,
              textStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Get.theme.indicatorColor,
              ),
            ),
            primaryXAxis: DateTimeAxis(
              title: AxisTitle(
                text: 'graphScreen_chartXTitle'.tr,
                textStyle: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Get.theme.indicatorColor,
                ),
              ),
            ),
            primaryYAxis: NumericAxis(
              title: AxisTitle(
                text: 'graphScreen_chartYTitle'.tr,
                textStyle: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Get.theme.indicatorColor,
                ),
              ),
            ),
            tooltipBehavior: TooltipBehavior(
                enable: true, header: 'graphScreen_toolTipHeader'.tr),
            series: <ChartSeries>[
              // Renders line chart
              LineSeries<_OrdersFrequency, DateTime>(
                  dataSource: _buildChartData(appController.orders),
                  xValueMapper: (_OrdersFrequency sales, _) => sales.date,
                  yValueMapper: (_OrdersFrequency sales, _) =>
                      sales.ordersCount,
                  markerSettings: MarkerSettings(isVisible: true))
            ]),
      ),
    );
  }

  List<_OrdersFrequency> _buildChartData(List<Orders> orders) {
    orders.sort((a, b) => a.registered!.compareTo(b.registered!));
    Map<DateTime, int> orderDatesFrequncy = {};
    orders.forEach((e) {
      DateTime orderDate = DateTime(e.registered!.year, e.registered!.month);
      if (orderDatesFrequncy[orderDate] != null)
        orderDatesFrequncy[orderDate] = orderDatesFrequncy[orderDate]! + 1;
      else
        orderDatesFrequncy[orderDate] = 1;
    });
    return orderDatesFrequncy.entries
        .map((entry) => _OrdersFrequency(entry.key, entry.value))
        .toList();
  }
}

class _OrdersFrequency {
  _OrdersFrequency(this.date, this.ordersCount);

  final DateTime date;
  final int ordersCount;
}
