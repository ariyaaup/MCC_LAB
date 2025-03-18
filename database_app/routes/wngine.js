var express = require('express');
var router = express.Router();
var mySQL = require('mysql');
var opt = {
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'wngine_mcc',
};

router.post('/insert', function (req, res, next) {
    var { name, price, rarityGUN, baseATK, baseAdvStat, description, typeID, level, gun_image} = req.body;
    if (!name || !price || !rarityGUN || !baseATK || !baseAdvStat || !description || !typeID || !level) {
        return res.status(400).json({ error: 'All fields except gun_image are required.' });
    }
    const imageBuffer = gun_image ? Buffer.from(gun_image, 'base64') : null;

    var connection = mySQL.createConnection(opt);
    connection.connect();
    connection.query("INSERT INTO gun_dataset(name, price, rarityGUN, baseATK, baseAdvStat, description, typeID, level, gun_image) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)", 
        [name, price, rarityGUN, baseATK, baseAdvStat, description, typeID, level, imageBuffer], function (err, results) {
        connection.end();

        if (err) {
            return res.status(500).json(err); //Return Error dengan HTTP status 500
        }

        return res.status(200).json(results);
    });
});

router.post('/update', function (req, res) {
    const { name, price, rarityGUN, baseATK, baseAdvStat, description, typeID, level, gun_image, wNgineID} = req.body;

    // Validate required fields
    if ( !name || !price || !rarityGUN || !baseATK || !baseAdvStat || !description || !typeID || !level || !wNgineID) {
        return res.status(400).json({ error: 'All fields except gun_image are required, including id.' });
    }

    // Convert gun_image to buffer if provided
    const imageBuffer = gun_image ? Buffer.from(gun_image, 'base64') : null;

    // Create MySQL connection
    const connection = mySQL.createConnection(opt);
    connection.connect();

    // Execute update query
    const query = `UPDATE gun_dataset SET name = ?, price = ?, rarityGUN = ?, baseATK = ?, baseAdvStat = ?, description = ?, typeID = ?, level = ?, gun_image = ? WHERE wNgineID = ?`;
    const values = [name, price, rarityGUN, baseATK, baseAdvStat, description, typeID, level, imageBuffer, wNgineID];

    connection.query(query, values, function (err, results) {
        connection.end(); // Ensure connection is closed

        if (err) {
            return res.status(500).json({ error: 'Database error', details: err });
        }

        if (results.affectedRows === 0) {
            return res.status(404).json({ message: 'No record found to update' });
        }

        return res.status(200).json({ message: 'Record updated successfully', results });
    });
});

 router.delete('/deleteWngine', (req, res) => {
     const {wNgineID} = req.body
     
     var connection = mySQL.createConnection(opt);
     connection.connect();
     connection.query( `DELETE FROM gun_dataset WHERE wNgineID = ?`,[wNgineID], function (err, results) {
        console.log(wNgineID); 
        connection.end();      
        if (err) {
            return res.status(500).json(err); //Return Error dengan HTTP status 500
          }
      
          return res.status(200).json(results);
        })
 })

router.get('/display', function (req, res, next) {

    var connection = mySQL.createConnection(opt);
    connection.connect();
    connection.query("SELECT * FROM gun_dataset", function (err, results) {
        connection.end();      

        if (err) {
            return res.status(500).json(err); //Return Error dengan HTTP status 500
        }
        results.forEach(result => {
            if(result.gun_image){
              result.gun_image = Buffer.from(result.gun_image).toString('base64');
            }
          });
        return res.status(200).json(results);
    });
});


router.get('/search', (req, res) => {
    const name = req.query.q || ''; // Query parameter untuk pencarian

    const connection = mySQL.createConnection(opt);

    connection.connect((err) => {
        if (err) {
            console.error('Database connection error:', err);
            return res.status(500).json({ error: 'Database connection failed' });
        }

        const query = "SELECT * FROM gun_dataset WHERE name LIKE ?";
        const values = [`%${name}%`];

        connection.query(query, values, (err, results) => {
            connection.end(); // Tutup koneksi

            if (err) {
                console.error('Query error:', err);
                return res.status(500).json({ error: 'Database query failed', details: err });
            }

            if (results.length === 0) {
                return res.status(404).json({ message: 'No records found' });
            }

            // Convert gun_image to base64 if available
            results.forEach((result) => {
                if (result.gun_image) {
                    result.gun_image = Buffer.from(result.gun_image).toString('base64');
                }
            });

            return res.status(200).json(results);
        });
    });
});

module.exports = router;
