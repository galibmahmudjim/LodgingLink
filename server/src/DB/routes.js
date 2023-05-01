const {Router}  = require("express");
const controller = require("./controller");



const router = Router();

router.post("/getuser", controller.getUser);
router.post("/adduser",controller.addUser);
router.delete("/:UserID",controller.deleteUser);
router.get("/:id", controller.getPassword);
router.post("/login", controller.loginAuth);
router.post("/login/verifyAuth", controller.verifyToken);
module.exports = router;