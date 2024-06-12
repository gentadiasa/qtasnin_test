import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sales_app/services/constant.dart';
import '../models/transaction.dart';

class TransactionService {
  final String baseUrlTransactions = '$baseUrl/transactions';

  Future<List<Transaction>> getTransactions() async {
    final response = await http.get(Uri.parse(baseUrlTransactions));
    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      List<Transaction> transactions = body.map((dynamic transaction) => Transaction.fromJson(transaction)).toList();
      return transactions;
    } else {
      throw Exception('Failed to load transactions');
    }
  }

  Future<Transaction> createTransaction(Transaction transaction) async {
    final response = await http.post(
      Uri.parse(baseUrlTransactions),
      headers: {"Content-Type": "application/json"},
      body: json.encode(transaction.toJson()),
    );
    if (response.statusCode == 201) {
      return Transaction.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create transaction');
    }
  }

  Future<Transaction> updateTransaction(String id, Transaction transaction) async {
    final response = await http.put(
      Uri.parse('$baseUrlTransactions/$id'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(transaction.toJson()),
    );
    if (response.statusCode == 200) {
      return Transaction.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update transaction');
    }
  }

  Future<void> deleteTransaction(String id) async {
    final response = await http.delete(Uri.parse('$baseUrlTransactions/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete transaction');
    }
  }
}
