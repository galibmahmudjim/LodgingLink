const express = require("express");
const dbRoutes = require("./DB/routes");
const app = express();

app.use(express.json());

const port = 6969;


app.use("/login",dbRoutes);
app.listen(port,function(){
      console.log("app listen at port "+ port);
})
