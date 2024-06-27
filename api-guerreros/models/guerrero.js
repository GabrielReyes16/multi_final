const mongoose = require('mongoose');

const guerreroSchema = new mongoose.Schema({
    nombre: { type: String, required: true },
    nivelPoder: { type: Number, required: true },
    estado: { type: Boolean, default: true },
    fechaRegistro: { type: Date, default: Date.now }
});

module.exports = mongoose.model('Guerrero', guerreroSchema);
