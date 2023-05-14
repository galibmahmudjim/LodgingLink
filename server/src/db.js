const Pool = require('pg').Pool;

const pool = new Pool({
      user: 'postgres',
      password: 'system',
      host: 'localhost',
      database: 'Lodginglink',
      port: 5432
});
module.exports = pool;