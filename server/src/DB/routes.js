const {Router}  = require("express");
const controller = require("./controller");



const router = Router();

router.get("/", controller.getUser);
router.post("/",controller.addUser);
router.delete("/:UserID",controller.deleteUser);
router.get("/:id", controller.getPassword);
router.post("/loginauth", controller.loginAuth);

module.exports = router;