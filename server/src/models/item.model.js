const db = require('../config/db.config');
const { v4: uuidv4 } = require('uuid');

const Item = {};

// Mendapatkan semua item
Item.getAll = (result) => {
  db.query('SELECT * FROM items', (err, res) => {
    if (err) {
      console.log('Error fetching items:', err);
      result(null, err);
      return;
    }
    result(null, res);
  });
};

// Membuat item baru
Item.create = (newItem, result) => {
  const transactionId = uuidv4();
  newItem.id = transactionId;
  console.log('aaa');
  db.query('INSERT INTO items SET ?', newItem, (err, res) => {
    if (err) {
      console.log('Error creating item:', err);
      result(null, err);
      return;
    }
    result(null, { id: res.insertId, ...newItem });
  });
};

// Mendapatkan item berdasarkan ID
Item.findById = (id, result) => {
  db.query('SELECT * FROM items WHERE id = ?', [id], (err, res) => {
    if (err) {
      console.log('Error fetching item:', err);
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

// Memperbarui item berdasarkan ID
Item.updateById = (id, item, result) => {
  db.query(
    'UPDATE items SET name = ?, type = ?, stock = ? WHERE id = ?',
    [item.name, item.type, item.stock, id],
    (err, res) => {
      if (err) {
        console.log('Error updating item:', err);
        result(null, err);
        return;
      }
      if (res.affectedRows == 0) {
        result({ kind: 'not_found' }, null);
        return;
      }
      result(null, { id: id, ...item });
    }
  );
};

// Menghapus item berdasarkan ID
Item.remove = (id, result) => {
  db.query('DELETE FROM items WHERE id = ?', [id], (err, res) => {
    if (err) {
      console.log('Error deleting item:', err);
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

module.exports = Item;
