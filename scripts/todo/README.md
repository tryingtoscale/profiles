# todo
PHP CLI - Linux Server - To Do - Lists

#### Purpose: To encrypt things left, to do, on a Server.

** Each user, has their own password protected, to do, items! **

Note: replace php7.4 with most current version of PHP!

$ apt-get install php7.4-cli php7.4-sqlite3

Useage: todo help

Useage: todo add "Stuff left...."

Useage: todo

Creates an SQLite3 file in ~/.todo/todo.db

Requires: php 7.0 CLI or better for Lib-Sodium Crypto, also sqlite3 for PHP.

FROM: https://github.com/tryingtoscale/todo
Author: Robert Strutts
