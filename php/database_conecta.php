<?php
//$servername = "papedins_db";
//$username = getenv('mysqluser'); // teste .gitignore
//$password = getenv('mysqlpassword');
//$dbname = "papedins_db";

include "identifica.cripto.php";

try {
    $conn = new PDO("mysql:host=$servername;dbname=$dbname", $username, $password);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    echo "Connection failed: " . $e->getMessage();
}
