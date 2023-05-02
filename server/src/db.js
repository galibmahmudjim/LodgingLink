const Pool = require('pg').Pool;

const pool = new Pool({
      user: 'postgres',
      password: 'system',
      host: '192.168.192.204',
      database: 'Lodginglink',
      port: 5432
});
module.exports = pool;