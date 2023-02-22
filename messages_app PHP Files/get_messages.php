<?php
include "connection.php";
$sender_id     =htmlspecialchars(strip_tags($_POST['sender_id']));
$reciver_id  =htmlspecialchars(strip_tags($_POST['reciver_id']));


    $stmt = $con->prepare("SELECT * From `messages` Where `sender_id`=? And `reciver_id`=? OR `sender_id`=? And `reciver_id`=? ");
    $stmt->execute(array($sender_id,$reciver_id,$reciver_id,$sender_id));
    $data = $stmt->fetchAll(PDO::FETCH_ASSOC);
    if ($stmt->rowCount() > 0) {
        echo json_encode(array("status"=>"success","data"=>$data));
    } else {      
        echo json_encode("fail");
    }
?>