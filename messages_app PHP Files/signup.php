<?php
include "connection.php";
$name      =htmlspecialchars(strip_tags($_POST['name']));
$email     =htmlspecialchars(strip_tags($_POST['email']));
$password  =htmlspecialchars(strip_tags($_POST['password']));


    $stmt = $con->prepare("SELECT * FROM `users` WHERE `email`=?");
    $stmt->execute(array($email));

    $data = $stmt->fetch(PDO::FETCH_ASSOC);
    if ($stmt->rowCount() > 0) {
        echo json_encode("user_exist");
    } else {
        $image_name = imageUpload('file');
        if ($image_name != 'fail') {
        $stmt1 = $con->prepare("INSERT INTO `users`(`name`,`email`,`password`,`image_url`) values(?,?,?,?)");
        $stmt1->execute(array($name, $email, $password,$image_name));
        echo json_encode("success");
    }
    else{
        echo json_encode("image_error");
    
    }
    }

?>