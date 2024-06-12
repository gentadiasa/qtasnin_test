import 'package:get/get.dart';
import '../models/transaction.dart';
import '../services/transaction_service.dart';

class TransactionController extends GetxController {
  var transactions = <Transaction>[].obs;
  final TransactionService _transactionService = TransactionService();

  @override
  void onInit() {
    fetchTransactions();
    super.onInit();
  }

  Future<void> fetchTransactions() async {
    try {
      var fetchedTransactions = await _transactionService.getTransactions();
      transactions.value = fetchedTransactions;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> addTransaction(Transaction transaction) async {
    try {
      await _transactionService.createTransaction(transaction);
      fetchTransactions();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> updateTransaction(String id, Transaction transaction) async {
    try {
      await _transactionService.updateTransaction(id, transaction);
      fetchTransactions();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> deleteTransaction(String id) async {
    try {
      await _transactionService.deleteTransaction(id);
      fetchTransactions();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
