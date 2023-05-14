const getUser = 'SELECT * FROM "User" where "UserID"=$1';
const getPassword = 'select "Password" from "User" where "UserID" = $1';
const checkEmail = 'select * from "User" where "UserID" = $1';
const insertUser = 'insert into "User"("UserID","Password","Role") values($1, $2, $3)';
const deleteUser = 'delete from "User" where "UserID" = $1';
const updatePassword = 'update "User" set "Password"=$1, "Status"=$3 where "UserID" = $2';
const getroomlist = 'select * from room';
const get = 'select * from "User"';
const getcustomerNid = 'select * from "customer" where "NID" = $1';
const getcustomerPhone = 'select * from "customer" where "PhoneNumber" = $1';
const getcustomerEmail = 'select * from "customer" where "Email" = $1';
const addCustomerUpdate = 'INSERT INTO customer("CustomerID","Name","PhoneNumber","Email","Address","NID","DateOfBirth") VALUES($1,$2,$3,$4,$5,$6,$7) ON CONFLICT ("CustomerID") DO    UPDATE SET "Name" = $2,"Email" = $4,"Address" = $5,"NID"=$6,"DateOfBirth" = $7'
const addreservation = 'INSERT INTO reservations("ReservationID", "ReservationDate", "DurationOfStay", "CheckInDate", "CheckOutDate", "CustomerID", "TotalRoom", "RoomNumber", "DuePayment", "TotalAmmount", "ReservationStatus","PaymentMethod", "Payment") VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13)'
const getreservationhistory = 'SELECT * FROM reservations WHERE "ReservationStatus" = $1 OR "ReservationStatus" = $2';
const getreservation = 'select * from reservations';
const getreservationid = 'select * from reservations where "ReservationID" = $1';
const getcustomerId = 'select * from "customer" where "CustomerID" = $1';
const getcustomer = 'select * from "customer"';
const updateReservation = 'Update reservations set "TotalAmmount" = $1, "DuePayment"=$2, "Payment" = $3, "ReservationStatus" = $4 where "ReservationID" = $5';
module.exports= {
      getUser,
      getPassword,
      checkEmail,
      insertUser,
      deleteUser,
      updatePassword,
      getroomlist,
      get,
      getcustomerNid,
      getcustomerPhone,
      getcustomerEmail,
      addCustomerUpdate,
      addreservation,
      getreservation,
      getreservationid,
      getcustomerId,
      updateReservation,
      getcustomer,
      getreservationhistory
}