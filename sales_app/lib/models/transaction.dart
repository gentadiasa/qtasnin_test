class Transaction {
  final String? id;
  final String itemId;
  final String itemName;
  final int quantity;
  final String transactionDate;

  Transaction({
    this.id,
    required this.itemId,
    required this.itemName,
    required this.quantity,
    required this.transactionDate,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      itemId: json['itemId'],
      itemName: json['itemName'],
      quantity: json['quantity'],
      transactionDate: json['transactionDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'itemId': itemId,
      'itemName': itemName,
      'quantity': quantity,
      'transactionDate': transactionDate,
    };
  }
}
