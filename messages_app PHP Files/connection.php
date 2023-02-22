<?php
include "function.php";
$dsn="mysql:host=localhost;dbname=messages_app";
$user="root";
$pass="";
try {
$con=new PDO($dsn,$user,$pass);
$con->setAttribute(PDO::ATTR_ERRMODE,PDO::ERRMODE_EXCEPTION);
return "Success";
} catch (PDOException $e) {
echo $e->getMessage();
return "fail";
}


?>