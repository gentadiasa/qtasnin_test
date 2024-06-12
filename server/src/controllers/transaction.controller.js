const Transaction = require('../models/transaction.model');

exports.getAllTransactions = (req, res) => {
  Transaction.getAll((err, data) => {
    if (err) res.status(500).send({ message: err.message });
    else res.send(data);
  });
};

exports.createTransaction = (req, res) => {
  const newTransaction = {
    itemId: req.body.itemId,
    quantity: req.body.quantity,
    transactionDate: req.body.transactionDate,
  };

  Transaction.create(newTransaction, (err, data) => {
    if (err) res.status(500).send({ message: err.message });
    else res.send(data);
  });
};

exports.getTransactionById = (req, res) => {
  Transaction.findById(req.params.id, (err, data) => {
    if (err) {
      if (err.kind === 'not_found') {
        res.status(404).send({ message: `Transaction not found with id ${req.params.id}.` });
      } else {
        res.status(500).send({ message: `Error retrieving transaction with id ${req.params.id}.` });
      }
    } else res.send(data);
  });
};

exports.updateTransactionById = (req, res) => {
  Transaction.updateById(req.params.id, new Transaction(req.body), (err, data) => {
    if (err) {
      if (err.kind === 'not_found') {
        res.status(404).send({ message: `Transaction not found with id ${req.params.id}.` });
      } else {
        res.status(500).send({ message: `Error updating transaction with id ${req.params.id}.` });
      }
    } else res.send(data);
  });
};

exports.deleteTransactionById = (req, res) => {
  Transaction.remove(req.params.id, (err, data) => {
    if (err) {
      if (err.kind === 'not_found') {
        res.status(404).send({ message: `Transaction not found with id ${req.params.id}.` });
      } else {
        res.status(500).send({ message: `Could not delete transaction with id ${req.params.id}.` });
      }
    } else res.send({ message: `Transaction was deleted successfully!` });
  });
};
