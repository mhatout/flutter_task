import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import '../models/orders.dart';

class AppController extends GetxController {
  List<Orders> orders = [];

  Future<void> getOrders() async {
    String ordersString = await rootBundle.loadString('assets/orders.json');
    orders = ordersFromMap(ordersString);
  }
}
