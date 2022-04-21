import 'package:ecommerce_admin/models/order_model.dart';
import 'package:ecommerce_admin/services/database_service.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  final DatabaseService database = DatabaseService();
  var orders = <Order>[].obs;
  var pendingOrders = <Order>[].obs;
  @override
  void onInit() {
    orders.bindStream(database.getOrders());
    pendingOrders.bindStream(database.getPendingOrders());
    super.onInit();
  }

  void updateOrder(
    Order order,
    String field,
    bool value,
  ) {
    database.updateOrder(order, field, value);
  }
}
