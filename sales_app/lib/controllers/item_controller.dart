import 'package:get/get.dart';
import '../models/item.dart';
import '../services/item_service.dart';

class ItemController extends GetxController {
  var items = <Item>[].obs;
  final ItemService _itemService = ItemService();

  @override
  void onInit() {
    fetchItems();
    super.onInit();
  }

  Future<void> fetchItems() async {
    try {
      var fetchedItems = await _itemService.getItems();
      items.value = fetchedItems;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> addItem(Item item) async {
    try {
      await _itemService.createItem(item);
      fetchItems();
    } catch (e) {
      print(e);
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> updateItem(String id, Item item) async {
    try {
      await _itemService.updateItem(id, item);
      fetchItems();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> deleteItem(String id) async {
    try {
      await _itemService.deleteItem(id);
      fetchItems();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}