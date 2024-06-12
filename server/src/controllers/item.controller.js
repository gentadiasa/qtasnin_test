const Item = require('../models/item.model');

exports.getAllItems = (req, res) => {
  Item.getAll((err, data) => {
    if (err) res.status(500).send({ message: err.message });
    else res.send(data);
  });
};

exports.createItem = (req, res) => {
  const newItem = {
    name: req.body.name,
    type: req.body.type,
    stock: req.body.stock,
  };

  Item.create(newItem, (err, data) => {
    if (err) res.status(500).send({ message: err.message });
    else res.send(data);
  });
};

exports.getItemById = (req, res) => {
  Item.findById(req.params.id, (err, data) => {
    if (err) {
      if (err.kind === 'not_found') {
        res.status(404).send({ message: `Item not found with id ${req.params.id}.` });
      } else {
        res.status(500).send({ message: `Error retrieving item with id ${req.params.id}.` });
      }
    } else res.send(data);
  });
};

exports.updateItemById = (req, res) => {
  const updatedItem = {
    name: req.body.name,
    type: req.body.type,
    stock: req.body.stock,
  };

  Item.updateById(req.params.id, updatedItem, (err, data) => {
    if (err) {
      if (err.kind === 'not_found') {
        res.status(404).send({ message: `Item not found with id ${req.params.id}.` });
      } else {
        res.status(500).send({ message: `Error updating item with id ${req.params.id}.` });
      }
    } else res.send(data);
  });
};

exports.deleteItemById = (req, res) => {
  Item.remove(req.params.id, (err, data) => {
    if (err) {
      if (err.kind === 'not_found') {
        res.status(404).send({ message: `Item not found with id ${req.params.id}.` });
      } else {
        res.status(500).send({ message: `Could not delete item with id ${req.params.id}.` });
      }
    } else res.send({ message: `Item was deleted successfully!` });
  });
};
