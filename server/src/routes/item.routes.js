const express = require('express')
const router = express.Router()
const items = require('../controllers/item.controller')

router.get('/', items.getAllItems)
router.post('/', items.createItem)
router.get('/:id', items.getItemById)
router.put('/:id', items.updateItemById)
router.delete('/:id', items.deleteItemById)

module.exports = router;