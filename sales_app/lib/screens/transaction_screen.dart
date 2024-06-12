import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sales_app/screens/transaction_form.dart';
import '../controllers/transaction_controller.dart';

class TransactionScreen extends StatelessWidget {
  final TransactionController transactionController = Get.put(TransactionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions'),
      ),
      body: Obx(() {
        if (transactionController.transactions.isEmpty) {
          return Center(child: Text('No transactions available'));
        }
        return ListView.builder(
          itemCount: transactionController.transactions.length,
          itemBuilder: (context, index) {
            final transaction = transactionController.transactions[index];
            return ListTile(
              title: Text('${transaction.itemName}', style: TextStyle(fontWeight: FontWeight.bold),),
              subtitle: Text('Terjual: ${transaction.quantity} \nPada Tanggal: ${DateFormat('dd MMMM yyyy, HH:mm').format(DateTime.parse(transaction.transactionDate))}'),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  transactionController.deleteTransaction(transaction.id!);
                },
              ),
              onTap: () {
                Get.to(() => TransactionForm(transaction: transaction));
              },
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => TransactionForm());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
