<?php
include "connection.php";
$stmt = $con->prepare("SELECT * FROM `users`");
$stmt->execute();
$data = $stmt->fetchAll(PDO::FETCH_ASSOC);
//
$stmt1 = $con->prepare("SELECT * FROM `messages`");
$stmt1->execute();

$data1 = $stmt1->fetchAll(PDO::FETCH_ASSOC);
if ($stmt->rowCount() > 0) {
    echo json_encode(array("status"=>"success","data"=>$data,"data1"=>$data1));
} else {
    echo json_encode("no chat");
}?>

