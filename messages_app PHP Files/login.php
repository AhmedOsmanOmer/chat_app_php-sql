<?php
include "connection.php";
$email     =htmlspecialchars(strip_tags($_POST['email']));
$password  =htmlspecialchars(strip_tags($_POST['password']));

$stmt=$con->prepare("SELECT * FROM `users` WHERE `email`=? And `password`=?");
$stmt->execute(array($email,$password));

$data=$stmt->fetch(PDO::FETCH_ASSOC);
if($stmt->rowCount()>0){
    echo json_encode(array("status"=>"success","data"=>$data));
}else{
    echo json_encode(array("status"=>"fail"));
}
?>