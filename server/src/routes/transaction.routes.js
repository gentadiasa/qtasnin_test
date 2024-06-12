const express = require('express')
const router = express.Router()
const transactions = require('../controllers/transaction.controller')

router.get('/', transactions.getAllTransactions)
router.post('/', transactions.createTransaction)
router.get('/:id', transactions.getTransactionById)
router.put('/:id', transactions.updateTransactionById)
router.delete('/:id', transactions.deleteTransactionById)

module.exports = router;
