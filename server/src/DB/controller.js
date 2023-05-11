const pool = require("../db");
const queries = require("./query");
const jwt = require("jsonwebtoken");

const SECRET_KEY = "Secret key";


const getUser = (req,res)=>{
      console.log("Getting User Info: " + req.body['UserID']);
      const UserID = req.body['UserID'];
      pool.query(queries.getUser,[UserID],(error,results)=>{
            if (results.rows.length != 0) {
                  res.status(200).json(results.rows[0]);
            }
            else {
                  res.status(201);
            }
      });
};

const loginAuth = (req, res) => {
      const { UserID, Password } = req.body;
      const User = {
            'UserID': UserID,
            'Password': Password
      };

      console.log("Login Auth: " + UserID + " " + Password);
      

      pool.query(queries.checkEmail, [UserID], (error, results) => {
            if (results.rows.length) {
                  pool.query(queries.getPassword, [UserID], (error, results) => {
                        if (error) throw error;
                        if (results.rows[0].Password == Password) {
                              jwt.sign({ User }, SECRET_KEY, { expiresIn: "7d" }, (err, token) => {
                                    res.status(200).json(
                                          {
                                                "Message": "Login Successful",
                                                token,
                                                results
                                          }
                                    )
                              });
                        }
                        else {
                              res.status(201).json({ "Message": "Incorrect Password" });
                        };
                  });
            }
            else {
                  res.status(201).json({ "Message": "UserID not found"});
            };
      });

      


}

const addUser = (req,res)=>{
      const {UserID, Password, Role} =  req.body;
      pool.query(queries.checkEmail,[UserID],(error,results)=>{
            if(results.rows.length){
                  res.send("Username already exist.");
            }
            else{
                  pool.query(queries.insertUser,[UserID,Password,Role],(error,results)=>{
                        if(error) throw error;
                        res.status(201).send('User inserted');
                  });
            }
      });
      
}

const verifyToken = (req, res) => {
      const token = req.body['token'];
      if (typeof token !== "undefined") {
            jwt.verify(token, SECRET_KEY, (err, authdata) => {
                  if (err) {
                        res.status(201);
                        console.log("Invalid token error "+token);
                  }
                  else {
                        res.status(200).json({
                              authdata
                        });
                  }
            })
      }     
      else {
            res.status(201);
            console.log("Invalid token"+token);
      }
}


const deleteUser = (req,res)=>{
      const UserID = req.params.UserID;
      pool.query(queries.deleteUser,[UserID], (error,results)=>{
            if(error) throw error;
            res.status(200).json(results.rows);
      });
}

const getPassword = (req, res) =>{
      const id = req.params.id;
      pool.query(queries.getPassword,[id], (error,results)=>{
            if(error) throw error;
            res.status(200).json(results.rows);
      });
};

const updatePassword = (req, res) => {
      const { UserID, Password, Status } = req.body;
      console.log(Password);
      pool.query(queries.updatePassword, [Password, UserID, Status], (error, results) => {
            if (error) { throw error; }
            res.status(200).json({
                  "Message": "Password reset successful",
            });
      })
}

const getroomlist = (req, res) => {
      console.log("getroomlist");
      pool.query(queries.getroomlist, (error, results) => {
            if (error) throw error;
            if (results.rows.length == 0)
                  res.status(201);
            res.status(200).json(results.rows);
      });
}

const getUsers = (req, res) => {
      console.log("get");
      pool.query (queries.get, (error, results) => {
            res.json(results.rows.length);
      });
}

module.exports = {
      getUser,
      getPassword,
      addUser,
      deleteUser,
      loginAuth,
      verifyToken,
      updatePassword,
      getroomlist,
      getUsers
};