require('dotenv').config();
const express = require('express');
const morganBody = require('morgan-body'); // 1. Import morgan-body
const itemRoutes = require('./routes/itemRoutes');
const healthRoutes = require('./routes/healthRoutes');

const app = express();
const PORT = process.env.PORT || 3000;

// 2. Body parser must come BEFORE morganBody
app.use(express.json());

// 3. Initialize morgan-body
morganBody(app, {
  logRequestBody: true,
  logResponseBody: true,
  dateTime: true,
});
app.use('/api/health', healthRoutes);
app.use('/api/items', itemRoutes);

app.listen(PORT, () => {
  console.log(`Server running at http://localhost:${PORT}`);
  console.log('Server running with Auto-Deploy!');
});
