import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/transaction_controller.dart';
import '../models/transaction.dart';

class TransactionForm extends StatelessWidget {
  final TransactionController transactionController = Get.find();
  final Transaction? transaction;
  final TextEditingController itemIdController = TextEditingController();
  final TextEditingController itemNameController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController transactionDateController = TextEditingController();

  TransactionForm({this.transaction}) {
    if (transaction != null) {
      itemIdController.text = transaction!.itemId.toString();
      itemNameController.text = transaction!.itemName.toString();
      quantityController.text = transaction!.quantity.toString();
      transactionDateController.text = transaction!.transactionDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(transaction == null ? 'Add Transaction' : 'Edit Transaction'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: itemIdController,
              decoration: InputDecoration(labelText: 'Item ID'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: itemNameController,
              decoration: InputDecoration(labelText: 'Item Name'),
            ),
            TextField(
              controller: quantityController,
              decoration: InputDecoration(labelText: 'Quantity'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: transactionDateController,
              decoration: InputDecoration(labelText: 'Transaction Date'),
              keyboardType: TextInputType.datetime,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (transaction == null) {
                  transactionController.addTransaction(
                    Transaction(
                      itemId: itemNameController.text,
                      itemName: itemNameController.text,
                      quantity: int.parse(quantityController.text),
                      transactionDate: transactionDateController.text,
                    ),
                  );
                } else {
                  transactionController.updateTransaction(
                    transaction!.id!,
                    Transaction(
                      itemId: itemNameController.text,
                      itemName: itemNameController.text,
                      quantity: int.parse(quantityController.text),
                      transactionDate: transactionDateController.text,
                    ),
                  );
                }
                Get.back();
              },
              child: Text(transaction == null ? 'Add' : 'Update'),
            ),
          ],
        ),
      ),
    );
  }
}
