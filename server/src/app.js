const express = require('express')
const bodyParser = require('body-parser')
const cors = require('cors')

const app = express()
app.use(cors())
app.use(bodyParser.json())

const itemRoutes = require('./routes/item.routes')
const transactionRoutes = require('./routes/transaction.routes')

app.use('/items', itemRoutes)
app.use('/transactions', transactionRoutes)

// dokumentasi
const swaggerUi = require('swagger-ui-express')
const swaggerDocument = require('../swagger.json')
app.use('/', swaggerUi.serve, swaggerUi.setup(swaggerDocument))

const PORT = process.env.PORT || 3000
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}.`)
})
