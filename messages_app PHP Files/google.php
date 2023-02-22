<?php
include "connection.php";
$name      =htmlspecialchars(strip_tags($_POST['name']));
$email     =htmlspecialchars(strip_tags($_POST['email']));
$image_name = imageUpload('file');

$stmt=$con->prepare("SELECT * FROM `users` WHERE `email`=?");
$stmt->execute(array($email));
$data = $stmt->fetch(PDO::FETCH_ASSOC);
if($stmt->rowCount()>0){
    echo json_encode(array('status'=>"user_exist","data"=>$data));

}else{
    $stmt1=$con->prepare("INSERT INTO `users`(`name`,`email`,`image_url`) values(?,?,?)");
    $stmt1->execute(array($name,$email,$image_name));
    $stmt2=$con->prepare("SELECT * From `users` Where `email`=?");
    $stmt2->execute(array($email));
    $data = $stmt2->fetch(PDO::FETCH_ASSOC);
    echo json_encode(array('status'=>"success","data"=>$data));
}
?>