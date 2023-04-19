const express = require("express");
const router = express.Router();

const Note = require("./../models/note");

router.post("/list", async (req, res) => {
  var notes = await Note.find({ userId: req.body.userId });
  res.json(notes);
});

router.post("/add", async (req, res) => {
  //? Create a newNote which is instance of Note

  await Note.deleteOne({ id: req.body.id }); //? For update

  const newNote = new Note({
    id: req.body.id,
    userId: req.body.userId,
    title: req.body.title,
    content: req.body.content,
  });
  await newNote.save();
  const response = { message: "New note is created " + `id: ${req.body.id}` };
  res.json(response);
});

router.post("/delete", async (req, res) => {
  await Note.deleteOne({ id: req.body.id });
  const response = {
    message: "Note is deleted successfully " + `id: ${req.body.id}`,
  };
  res.json(response);
});

module.exports = router;
