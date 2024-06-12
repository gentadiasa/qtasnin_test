import 'package:get/get.dart';
import 'package:sales_app/controllers/item_controller.dart';
import 'package:sales_app/controllers/transaction_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ItemController>(() => ItemController());
    Get.lazyPut<TransactionController>(() => TransactionController());
  }
}
