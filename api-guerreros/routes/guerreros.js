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

// Ruta para actualizar un guerrero
router.put('/:id', async (req, res) => {
    const { id } = req.params;

    try {
        const guerrero = await Guerrero.findById(id);
        if (!guerrero) {
            return res.status(404).json({ message: 'Guerrero no encontrado' });
        }

        guerrero.nombre = req.body.nombre;
        guerrero.nivelPoder = req.body.nivelPoder;
        guerrero.estado = req.body.estado;
        guerrero.fechaRegistro = req.body.fechaRegistro;

        const updatedGuerrero = await guerrero.save();
        res.json(updatedGuerrero);
    } catch (err) {
        res.status(400).json({ message: err.message });
    }
});


// Ruta para eliminar un guerrero
router.delete('/:id', async (req, res) => {
    const { id } = req.params;

    try {
        const guerrero = await Guerrero.findById(id);
        if (!guerrero) {
            return res.status(404).json({ message: 'Guerrero no encontrado' });
        }

        const deletedGuerrero = await guerrero.deleteOne(); // Utiliza deleteOne() para eliminar el guerrero

        res.json({ message: 'Guerrero eliminado correctamente', deletedGuerrero });
    } catch (err) {
        res.status(500).json({ message: err.message });
    }
});


module.exports = router;
