const express = require("express");
const cors = require("cors");

const app = express();
app.use(cors());
app.use(express.json());

app.post("/", (req, res) => {
  const numere = req.body["numere"].split(",");
  const nrarr = [];
  let ok = true;
  numere.forEach((nr) => {
    if (!nr) {
      ok = false;
    }
    nr = Number(nr);
    if (isNaN(nr)) {
      ok = false;
    }
    nrarr.push(nr);
  });
  if (!ok) {
    res.json({
      rasp: "date invalide",
    });
    return;
  }
  const ordine = req.body["ordine"];
  if (ordine === "descrescator") {
    nrarr.sort((a, b) => b - a);
  } else {
    nrarr.sort((a, b) => a - b);
  }
  res.json({
    rasp: nrarr.join(","),
  });
});

app.listen(3000, () => {
  console.log(`Listening at http://localhost:3000`);
});
