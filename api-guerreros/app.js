const express = require('express');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');
const guerrerosRouter = require('./routes/guerreros');

const app = express();
app.use(bodyParser.json());

// Conexión a MongoDB
mongoose.connect('mongodb://127.0.0.1/guerreros', {
});
const db = mongoose.connection;
db.on('error', (error) => console.error(error));
db.once('open', () => console.log('Conectado a la base de datos'));

// Rutas
app.use('/guerreros', guerrerosRouter);

// Puerto de escucha
const port = process.env.PORT || 3000;
app.listen(port, () => {
    console.log(`Guerreros convocados en el puerto ${port}`);
});