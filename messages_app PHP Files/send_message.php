<?php
include "connection.php";
$message      =htmlspecialchars(strip_tags($_POST['message']));
$sender_id     =htmlspecialchars(strip_tags($_POST['sender_id']));
$reciver_id  =htmlspecialchars(strip_tags($_POST['reciver_id']));


    $stmt = $con->prepare("INSERT INTO `messages`(`message`,`sender_id`,`reciver_id`) value (?,?,?)");
    $stmt->execute(array($message,$sender_id,$reciver_id));
   // $data = $stmt->fetch(PDO::FETCH_ASSOC);
    if ($stmt->rowCount() > 0) {
        echo json_encode("success");
    } else {
       
        echo json_encode("fail");
    }
?>