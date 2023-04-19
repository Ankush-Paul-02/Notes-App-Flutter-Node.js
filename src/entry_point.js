//! Express Server

//! STEP 1: INITIALIZATION
const express = require("express");
const app = express();

const mongoose = require("mongoose");
const Note = require("./models/note");
const bodyParser = require("body-parser");
const router = require("./routes/note_routes");
app.use(bodyParser.urlencoded({ extended: false })); //!  extended == true ? Nested Object Allowed : Nested Object Not Allowed
app.use(bodyParser.json());


const mongoDbPath = "mongodb+srv://ankushpaul:mongodbwithankush@cluster0.i2dstx1.mongodb.net/notesDB";
mongoose
  .connect(
    mongoDbPath
  )
  .then((_, __) => {
    //! STEP 2: DEFINE APP ROUTES
    //! Home Route
    app.get("/", (req, res) => {
      //? request we send to the server & server send us the response
      const response = { message: "API WORKS" };
      res.json(response);
    });

    //! Note's Route
    const noteRouter = router;
    app.use("/notes", noteRouter);
  });

//! STEP 3: STARTING THE SERVER ON A PORT
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
  console.log("Server started al PORT: " + PORT);
});
