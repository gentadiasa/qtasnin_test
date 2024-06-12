import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/item_controller.dart';
import '../models/item.dart';

class ItemForm extends StatelessWidget {
  final ItemController itemController = Get.find();
  final Item? item;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final TextEditingController typeController = TextEditingController();

  ItemForm({this.item}) {
    if (item != null) {
      nameController.text = item!.name;
      stockController.text = item!.stock.toString();
      typeController.text = item!.type;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item == null ? 'Add Item' : 'Edit Item'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: typeController,
              decoration: InputDecoration(labelText: 'Type'),
            ),
            TextField(
              controller: stockController,
              decoration: InputDecoration(labelText: 'Stock'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if(nameController.text == '' || typeController.text == '' || stockController.text == ''){
                  Get.snackbar('Missing Input', 'Please Fill ${nameController.text == '' ? 'Name' : typeController.text == '' ? 'Type' : stockController.text == '' ? 'Stock' : ''}');
                  return;
                }
                Item newItem = Item(
                  name: nameController.text,
                  type: typeController.text,
                  stock: int.parse(stockController.text),
                );
                if (item == null) {
                  itemController.addItem(newItem);
                } else {
                  itemController.updateItem(
                    item!.id!,
                    newItem,
                  );
                }
                // Get.back();
              },
              child: Text(item == null ? 'Add' : 'Update'),
            ),
          ],
        ),
      ),
    );
  }
}
