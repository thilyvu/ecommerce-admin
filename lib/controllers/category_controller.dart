import 'package:ecommerce_admin/models/models.dart';
import 'package:ecommerce_admin/services/database_service.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  final DatabaseService database = DatabaseService();
  var catagories = <Category>[].obs;
  @override
  void onInit() {
    catagories.bindStream(database.getCategories());
    super.onInit();
  }

  var newCategory = {}.obs;
}
