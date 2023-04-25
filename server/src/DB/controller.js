const pool = require("../db");
const queries = require("./query");

const getUser = (req,res)=>{
      console.log("GetUser");
      pool.query(queries.getUser,(error,results)=>{
            res.status(200).json(results.rows);
      });
};

const loginAuth = (req, res) => {
      const {UserID,Password} = req.body;
      console.log(UserID);
      pool.query(queries.checkEmail, [UserID], (error, results) => {
            if (results.rows.length) {
                  pool.query(queries.getPassword, [UserID], (error, results) => {
                        if (error) throw error;
                        if (results.rows[0].Password == Password)
                        {
                              res.status(200).send("Login Successful");
                        }
                        else {
                              res.status(200).send("Incorrect Password");     
                        }
                  });
            }
            else {
                  res.status(200).send("UserID not found");
            }
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

module.exports = {
      getUser,
      getPassword,
      addUser,
      deleteUser,
      loginAuth
};