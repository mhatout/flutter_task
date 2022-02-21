import 'package:get/get.dart';

class MyTranslation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': {
          "homeScreen_header": "METRICS & GRAPH",
          "homeScreen_metricsBtn": "METRICS",
          "homeScreen_graphBtn": "CHARTS",
          /***********************************************/
          "metricsScreen_header": "METRICS",
          "metricsScreen_orderCount": "Orders Count",
          "metricsScreen_priceAverage": "Prices Average",
          "metricsScreen_returnCount": "Returns Count",
          /***********************************************/
          "graphScreen_header": "CHARTS",
          "graphScreen_chartHeader": "Orders Count By Month",
          "graphScreen_chartXTitle": "Month",
          "graphScreen_chartYTitle": "Order Count",
          "graphScreen_toolTipHeader": "Orders/Month",
        },
        'ar': {
          "homeScreen_header": "إحصائيات و رسم بياني",
          "homeScreen_metricsBtn": "إحصائيات",
          "homeScreen_graphBtn": "رسم بياني",
          /***********************************************/
          "metricsScreen_header": "إحصائيات",
          "metricsScreen_orderCount": "عدد الطلبات",
          "metricsScreen_priceAverage": "متوسط الأسعار",
          "metricsScreen_returnCount": "عدد المرتجع",
          /***********************************************/
          "graphScreen_header": "رسم بياني",
          "graphScreen_chartHeader": "عدد الطلبات بالشهر",
          "graphScreen_chartXTitle": "الشهر",
          "graphScreen_chartYTitle": "عدد الطلبات",
          "graphScreen_toolTipHeader": "الطلبات/شهر",
        }
      };
}
