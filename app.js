
const express = require('express')
const app = express()
// Azure App Service sets the PORT environment variable
const port = process.env.PORT || 3000

app.get('/', (req, res) => {
<<<<<<< HEAD
  res.send("<html><head><title>ajwa</title></head><body><p><h1>It works!</h1></p><p>" + process.env.Environment + "</p><p>" + process.env.Property + "</p></body></html>");
=======
  res.send("<html><head><title>ajwa</title></head><body><p><h1>It works!</h1></p><p>" + process.env.Environment + "</p></body></html>");
>>>>>>> 361718532c38ac8063905458b563435c211597ea
})

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`);
})
