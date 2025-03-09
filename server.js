const express = require("express");
const cors = require("cors");
const axios = require("axios");

const app = express();
app.use(cors());

app.get("/proxy", async (req, res) => {
    const targetUrl = req.query.url;
    if (!targetUrl) {
        return res.status(400).json({ error: "Falta el parámetro 'url'" });
    }

    try {
        const response = await axios.get(targetUrl);
        res.send(response.data);
    } catch (error) {
        res.status(500).json({ error: "No se pudo obtener la página" });
    }
});

const PORT = 3000;
app.listen(PORT, () => console.log(`Proxy en ejecución en http://localhost:${PORT}`));
