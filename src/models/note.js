//! STEPS
//! 1.DEFINE SCHEMA => Model details in schema => Note: id, userId, title, content, dateAdded => These fields are called schema
//! 2. CREATE MODEL => <Model name> <Schema> Note

const mongoose = require("mongoose");

//? Schema
const noteSchema = mongoose.Schema({
  id: {
    type: String,
    unique: true,
    required: true,
  },
  userId: {
    type: String,
    required: true,
  },
  title: {
    type: String,
    required: true,
  },
  content: {
    type: String
  },
  dateAdded: {
    type: Date,
    default: Date.now
  },
});

//? Model
module.exports = mongoose.model("Note", noteSchema)

