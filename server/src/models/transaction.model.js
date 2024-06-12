const db = require('../config/db.config');
const { v4: uuidv4 } = require('uuid');
const moment = require('moment');

const Transaction = {};

// Mendapatkan semua transaksi dengan nama item
Transaction.getAll = (result) => {
  const query = `
    SELECT 
      t.id, t.itemId, t.quantity, t.transactionDate, i.name as itemName 
    FROM 
      transactions t 
    JOIN 
      items i 
    ON 
      t.itemId = i.id
  `;

  db.query(query, (err, res) => {
    if (err) {
      console.log('Error fetching transactions:', err);
      result(null, err);
      return;
    }
    result(null, res);
  });
};

// Membuat transaksi baru
Transaction.create = (newTransaction, result) => {
  const transactionId = uuidv4();
  newTransaction.id = transactionId;
  newTransaction.transactionDate = moment(newTransaction.transactionDate).format('YYYY-MM-DD HH:mm:ss');

  db.beginTransaction(err => {
    if (err) {
      console.log('Error beginning transaction:', err);
      result(null, err);
      return;
    }

    const { id, itemId, quantity, transactionDate } = newTransaction;

    db.query('INSERT INTO transactions (id, itemId, quantity, transactionDate) VALUES (?, ?, ?, ?)',
      [id, itemId, quantity, transactionDate], (err, res) => {
        if (err) {
          db.rollback(() => {
            console.log('Error creating transaction:', err);
            result(null, err);
          });
          return;
        }

        const { itemId, quantity } = newTransaction;

        // Mengurangi jumlah stok pada barang setelah transaksi dibuat
        db.query('UPDATE items SET stock = stock - ? WHERE id = ?', [quantity, itemId], (err, res) => {
          if (err) {
            db.rollback(() => {
              console.log('Error updating stock:', err);
              result(null, err);
            });
            return;
          }

          db.commit(err => {
            if (err) {
              db.rollback(() => {
                console.log('Error committing transaction:', err);
                result(null, err);
              });
              return;
            }

            result(null, { id: transactionId, ...newTransaction });
          });
        });
      });
  });
};

// Mendapatkan transaksi berdasarkan ID dengan nama item
Transaction.findById = (id, result) => {
  const query = `
    SELECT 
      t.id, t.itemId, t.quantity, t.transactionDate, i.name as itemName 
    FROM 
      transactions t 
    JOIN 
      items i 
    ON 
      t.itemId = i.id 
    WHERE 
      t.id = ?
  `;

  db.query(query, [id], (err, res) => {
    if (err) {
      console.log('Error fetching transaction:', err);
      result(null, err);
      return;
    }
    if (res.length) {
      result(null, res[0]);
      return;
    }
    result({ kind: 'not_found' }, null);
  });
};

// Memperbarui transaksi berdasarkan ID
Transaction.updateById = (id, transaction, result) => {
  db.query(
    'UPDATE transactions SET itemId = ?, quantity = ?, transactionDate = ? WHERE id = ?',
    [transaction.itemId, transaction.quantity, transaction.transactionDate, id],
    (err, res) => {
      if (err) {
        console.log('Error updating transaction:', err);
        result(null, err);
        return;
      }
      if (res.affectedRows == 0) {
        result({ kind: 'not_found' }, null);
        return;
      }
      result(null, { id: id, ...transaction });
    }
  );
};

// Menghapus transaksi berdasarkan ID
Transaction.remove = (id, result) => {
  db.query('DELETE FROM transactions WHERE id = ?', [id], (err, res) => {
    if (err) {
      console.log('Error deleting transaction:', err);
      result(null, err);
      return;
    }
    if (res.affectedRows == 0) {
      result({ kind: 'not_found' }, null);
      return;
    }
    result(null, res);
  });
};

module.exports = Transaction;