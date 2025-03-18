var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');

var indexRouter = require('./routes/index');
var usersRouter = require('./routes/users');
// var registRouter =  require('/routers/regist');
var loginRouter = require('./routes/login');
var wngineRouter = require('./routes/wngine');

var app = express();

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

app.use('/', indexRouter);
app.use('/users', usersRouter);
// app.use('/regist', registRouter);
app.use('/login', loginRouter);
app.use('/wngine', wngineRouter);

module.exports = app;
