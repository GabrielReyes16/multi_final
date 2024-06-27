const express = require('express');
const router = express.Router();
const Guerrero = require('../models/guerrero');

// Ruta para obtener todos los guerreros
router.get('/', async (req, res) => {
    try {
        const guerreros = await Guerrero.find();
        res.json(guerreros);
    } catch (err) {
        res.status(500).json({ message: err.message });
    }
});

// Ruta para crear un nuevo guerrero
router.post('/', async (req, res) => {
    const guerrero = new Guerrero({
        nombre: req.body.nombre,
        nivelPoder: req.body.nivelPoder,
        estado: req.body.estado,
        fechaRegistro: req.body.fechaRegistro
    });

    try {
        const newGuerrero = await guerrero.save();
        res.status(201).json(newGuerrero);
    } catch (err) {
        res.status(400).json({ message: err.message });
    }
});

module.exports = router;
