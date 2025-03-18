var express = require('express');
var router = express.Router();
var mySQL = require('mysql');
var opt = {
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'wngine_mcc',
};
/* GET users listing. */

router.get('/', function(req, res, next) {
  res.send('respond with a resource');
});

router.post('/SignUp', function (req, res, next) {
    var { username, password} = req.body;
    // Validasi untuk memastikan username dan password tidak kosong
    if (!username || username.trim() === '') {
        return res.status(400).json(results); // HTTP status 400 untuk Bad Request
    }

    if (!password || password.trim() === '') {
        return res.status(400).json(results); // HTTP status 400 untuk Bad Request
    }

    var connection = mySQL.createConnection(opt);
    connection.connect();
    connection.query("INSERT INTO user_dataset(username, password) VALUES(?, ?)", [username, password], function (err, results) {
        connection.end();

        if (err) {
            return res.status(500).json(err); //Return Error dengan HTTP status 500
        }

        return res.status(200).json(results);
    });
});
router.post('/Login', function (req, res, next) {
    var { username, password,} = req.body;

    // Validasi untuk memastikan username dan password tidak kosong
    if (!username || username.trim() === '') {
        return res.status(400).json({ error: 'Username is required' }); // HTTP status 400 untuk Bad Request
    }

    if (!password || password.trim() === '') {
        return res.status(400).json({ error: 'Password is required' }); // HTTP status 400 untuk Bad Request
    }

    var connection = mySQL.createConnection(opt);
    connection.connect();
    connection.query("SELECT * FROM user_dataset WHERE username = ? AND password = ?", [username, password], function (err, results) {
        connection.end();

        if (err) {
            return res.status(500).json(err); // Return Error dengan HTTP status 500
        }

        if (results.length === 0) {
            return res.status(401).json({ error: 'Invalid username or password' }); // HTTP status 401 untuk Unauthorized
        }
    
        return res.status(200).json({ message: 'Login successful', user: results[0] });
    });
});

router.post('/googleLogin', function (req, res, next) {
  const { email, displayName } = req.body;

  // Validasi input
  if (!email || email.trim() === '') {
    return res.status(400).json({ error: 'Email is required' }); // HTTP status 400 untuk Bad Request
  }

  if (!displayName || displayName.trim() === '') {
    return res.status(400).json({ error: 'Display name is required' }); // HTTP status 400 untuk Bad Request
  }

  const connection = mySQL.createConnection(opt);
  connection.connect();

  // Masukkan atau perbarui data pengguna di database dengan displayName sebagai username
  const query = `INSERT INTO user_dataset (email, username) VALUES (?, ?) 
                 ON DUPLICATE KEY UPDATE username = ?`;
  connection.query(query, [email, displayName, displayName], function (err, results) {
    connection.end();

    if (err) {
      return res.status(500).json(err); // Return Error dengan HTTP status 500
    }

    return res.status(200).json({ message: 'Login successful', user: { email, username: displayName } });
  });
});

module.exports = router;




module.exports = router;
