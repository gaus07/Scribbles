const express = require('express')
const router = express.Router()
const {Posts} = require('../models')

router.get('/', async (req, res) => {
    const listOfPosts = await Posts.findAll()
    res.json(listOfPosts)
})

router.get('/byId/:id', async (req, res) => {
    const id = req.params.id
    const post = await Posts.findByPk(id)
    console.log(post);
    res.json(post)
})

router.post('/', async (req, res) => {
    const post = req.body
    let a =  await Posts.create(post)
    console.log(a);
    res.json(post)
})

module.exports = router