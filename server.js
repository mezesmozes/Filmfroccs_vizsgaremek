const express = require("express");

const app = express();
const PORT = process.env.PORT || 3000;

// Alap GET API
app.get("/api", (req, res) => {
  res.json({
    success: true,
    message: "Hello World API!",
    timestamp: new Date().toISOString(),
  });
});

// Root endpoint
app.get("/", (req, res) => {
  res.send("Szerver fut ✅");
});

app.listen(PORT, () => {
  console.log(`Szerver elindult a ${PORT} porton`);
});