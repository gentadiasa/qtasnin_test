import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_app/screens/item_form.dart';
import '../controllers/item_controller.dart';

class ItemScreen extends StatelessWidget {
  final ItemController itemController = Get.put(ItemController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Items'),
      ),
      body: Obx(() {
        if (itemController.items.isEmpty) {
          return Center(child: Text('No items available'));
        }
        return ListView.builder(
          itemCount: itemController.items.length,
          itemBuilder: (context, index) {
            final item = itemController.items[index];
            return ListTile(
              title: Text(item.name,style: TextStyle(fontWeight: FontWeight.bold),),
              subtitle: Text('Type: ${item.type}\nStock:${item.stock}'),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  itemController.deleteItem(item.id!);
                },
              ),
              onTap: () {
                Get.to(() => ItemForm(item: item));
              },
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => ItemForm());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
