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
      console.log(Role);
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

const addInventory = (req,res)=>{
      const {Name, Details, Cost, Timestamps} =  req.body;
      pool.query(queries.addInventory, [Name, Details, Cost, Timestamps], (error, results) => {
            if (error) throw error;
            res.status(200).send('User inserted');
      });
      
}


const resetPassword = (req,res)=>{
      const {UserID} =  req.body;
      pool.query(queries.resetPassword, ["12345678","pass_init",UserID], (error, results) => {
            if (error) throw error;
            res.status(200).send('Pass reset');
      });
      
}

const getInventory = (req,res)=>{
      pool.query(queries.getInventory, (error, results) => {
            if (error) throw error;
            res.status(200).json(results.rows);
      });
      
}


const addusers = (req,res)=>{
      const { UserID, Password, Role, Status } = req.body;
      pool.query(queries.checkEmail,[UserID],(error,results)=>{
            if(results.rows.length){
                  res.status(201).send("Username already exist.");
            }
            else{
                  pool.query(queries.addUser,[UserID, Password, Role, Status],(error,results)=>{
                        if(error) throw error;
                        res.status(200).send('User inserted');
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
const updateemployee = (req, res) => {
      const { CurrentStatus, EmployeeID } = req.body;
      pool.query(queries.updateemployee, [CurrentStatus, EmployeeID], (error, results) => {
            if (error) { throw error; }
            res.status(200).json({
                  "Message": "successful",
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

const addCustomerUpdate = (req,res)=>{
      const {CustomerID,Name,PhoneNumber,Email,Address,NID,DateOfBirth} =  req.body;
      pool.query(queries.addCustomerUpdate,[CustomerID,Name,PhoneNumber,Email,Address,NID,DateOfBirth],(error,results)=>{
            if (error) throw error;
            res.status(200).json(results);
            
      });
      
}

const addReservation = (req,res)=>{
      const { ReservationID, ReservationDate, DurationOfStay, CheckInDate, CheckOutDate, CustomerID, TotalRoom, RoomNumber, DuePayment, TotalAmmount, ReservationStatus, paymentMethod, Payment } = req.body;
      pool.query(queries.addreservation,[ReservationID, ReservationDate, DurationOfStay, CheckInDate, CheckOutDate, CustomerID, TotalRoom, RoomNumber, DuePayment, TotalAmmount, ReservationStatus, paymentMethod, Payment],(error,results)=>{
            if (error) throw error;
            res.status(200).json(results);
            
      });
      
}

const getcustomerNid = (req,res)=>{
      const { NID } = req.body;
      console.log(NID);
      pool.query(queries.getcustomerNid,[NID],(error,results)=>{
            if (error) throw error;
            if (results.rows.length != 0) {
                  res.status(200).json(results.rows[0]);
            }
            else {
                  res.status(201).json({ "msg": "Not Found" });
            }
            
      });
      
}

const getcustomerid = (req,res)=>{
      const { CustomerID } = req.body;
      console.log(CustomerID);
      pool.query(queries.getcustomerId,[CustomerID],(error,results)=>{
            if (error) throw error;
            if (results.rows.length != 0) {
                  res.status(200).json(results.rows[0]);
            }
            else {
                  res.status(201).json({ "msg": "Not Found" });
            }
            
      });
      
}
const getcustomerPhoneNumber = (req,res)=>{
      const { PhoneNumber } = req.body;
      pool.query(queries.getcustomerPhone,[PhoneNumber],(error,results)=>{
            if (error) throw error;
            if (results.rows.length != 0) {
                  res.status(200).json(results.rows[0]);
            }
            else {
                  res.status(201).json({ "msg": "Not Found" });
            }
            
      });
      
}

const getreservation = (req,res)=>{
      pool.query(queries.getreservation,(error,results)=>{
            if (error) throw error;
            if (results.rows.length != 0) {
                  res.status(200).json(results.rows);
            }
            else {
                  res.status(201).json({ "msg": "Not Found" });
            }
            
      });
      
}
const getreservationhistory = (req,res)=>{
      pool.query(queries.getreservationhistory,['Check-Out','Cancelled'],(error,results)=>{
            if (error) throw error;
            if (results.rows.length != 0) {
                  res.status(200).json(results.rows);
            }
            else {
                  res.status(201).json({ "msg": "Not Found" });
            }
      });
      
}
const getemployee = (req,res)=>{
      pool.query(queries.getemployee,(error,results)=>{
            if (error) throw error;
            if (results.rows.length != 0) {
                  res.status(200).json(results.rows);
            }
            else {
                  res.status(201).json({ "msg": "Not Found" });
            }
      });
      
}

const getemployeeID = (req, res) => {
      const { EmployeeID } = req.body;
      console.log(EmployeeID);
      pool.query(queries.getemployeeID,[EmployeeID],(error,results)=>{
            if (error) throw error;
            if (results.rows.length != 0) {
                  res.status(200).json(results.rows[0]);
            }
            else {
                  res.status(201).json({ "msg": "Not Found" });
            }
      });
      
}

const addEmployee = (req, res) => {
      const {EmployeeID, Name, PhoneNumber, Address, Email, nid, DateOfBirth, Position, Salary, JoiningDate, CurrentStatus} = req.body
      pool.query(queries.addEmployee,[EmployeeID, Name, PhoneNumber, Address, Email, nid, DateOfBirth, Position, Salary, JoiningDate, CurrentStatus],(error,results)=>{
            if (error) throw error;
           
                  res.status(200).send("Yes");
          
      });
      
}


const getcustomerEmail = (req,res)=>{
      const { Email } = req.body;
      pool.query(queries.getcustomerEmail,[Email],(error,results)=>{
            if (error) throw error;
            if (results.rows.length != 0) {
                  res.status(200).json(results.rows[0]);
            }
            else {
                  res.status(201).json({ "msg": "Not Found" });
            }
            
      });
      
}

const getreservationid = (req,res)=>{
      const { ReservationID } = req.body;
      console.log(ReservationID);
      pool.query(queries.getreservationid,[ReservationID],(error,results)=>{
            if (error) throw error;
            if (results.rows.length != 0) {
                  res.status(200).json(results.rows[0]);
            }
            else {
                  res.status(201).json({ "msg": "Not Found" });
            }
            
      });
      
}
const updateReservation = (req,res)=>{
      const { TotalAmmount, Payment, DuePayment, ReservationStatus, ReservationID } = req.body;
      console.log(ReservationID);
      pool.query(queries.updateReservation,[TotalAmmount,  DuePayment, Payment, ReservationStatus, ReservationID],(error,results)=>{
            if (error) throw error;
                  res.status(200).json(results.rows[0]);
            
      });
      
}
const getcustomer = (req,res)=>{
      pool.query(queries.getcustomer,(error,results)=>{
            if (error) throw error;
                  res.status(200).json(results.rows);
            
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
      getUsers,
      addCustomerUpdate,
      addReservation,
      getcustomerNid,
      getcustomerEmail,
      getcustomerPhoneNumber,
      getreservation,
      getreservationid,
      getcustomerid,
      updateReservation,
      getcustomer,
      getreservationhistory,
      addEmployee,
      getemployee,
      getemployeeID,
      updateemployee,
      addusers,
      addInventory,
      getInventory,
      resetPassword
};