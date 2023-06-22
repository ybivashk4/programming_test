<?php

$host = 'localhost';

$port = 5433;

$dbname = 'tests';

$username = 'postgres';

$password = '123';

try {

$conn = new PDO("pgsql:host=$host;port=$port;dbname=$dbname", $username, $password);

} catch (PDOException $pe) {

die("Could not connect to the database $dbname :" . $pe->getMessage());

}
?>