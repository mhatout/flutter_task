import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import '../models/orders.dart';

class AppController extends GetxController {
  List<Orders> orders = [];

  bool _loading = false;

  bool get loading => _loading;

  Future<void> getOrders() async {
    _loading = true;
    update();
    String ordersString = await rootBundle.loadString('assets/orders.json');
    orders = ordersFromMap(ordersString);
    _loading = false;
    update();
  }
}
