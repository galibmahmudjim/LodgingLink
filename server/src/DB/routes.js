const {Router}  = require("express");
const controller = require("./controller");



const router = Router();

router.post("/getuser", controller.getUser);
router.post("/adduser",controller.addUser);
router.delete("/:UserID",controller.deleteUser);
router.get("/:id", controller.getPassword);
router.post("/login", controller.loginAuth);
router.post("/login/verifyAuth", controller.verifyToken);
router.post("/updatePassword", controller.updatePassword);
router.post("/getroomlist", controller.getroomlist);
router.post("/addcustomer", controller.addCustomerUpdate);
router.post("/addreservation", controller.addReservation);
router.post("/getcustomerNid", controller.getcustomerNid);
router.post("/getcustomerid", controller.getcustomerid);
router.post("/getcustomerPhoneNumber", controller.getcustomerPhoneNumber);
router.post("/getcustomerEmail", controller.getcustomerEmail);
router.post("/getreservation", controller.getreservation);
router.post("/getreservationhistory", controller.getreservationhistory);
router.post("/getreservationid", controller.getreservationid);
router.post("/updatereservation", controller.updateReservation);
router.post("/getcustomer", controller.getcustomer);
router.post("/addemployee", controller.addEmployee);
router.post("/getemployee", controller.getemployee);
router.post("/getemployeeID", controller.getemployeeID);
router.post("/updateemployee", controller.updateemployee);
router.post("/addusers", controller.addusers);
router.post("/addinventory", controller.addInventory);
router.post("/getinventory", controller.getInventory);
router.post("/passwordreset", controller.resetPassword);
router.post("/getroomlistNumber", controller.getroomlistNumber);
router.post('/sendsms', controller.sms);


module.exports = router;