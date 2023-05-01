const getUser = 'SELECT * FROM "User" where "UserID"=$1';
const getPassword = 'select "Password" from "User" where "UserID" = $1';
const checkEmail = 'select * from "User" where "UserID" = $1';
const insertUser = 'insert into "User"("UserID","Password","Role") values($1, $2, $3)';
const deleteUser = 'delete from "User" where "UserID" = $1';


module.exports= {
      getUser,
      getPassword,
      checkEmail,
      insertUser,
      deleteUser
}