<?php
include "connection.php";
$id      =htmlspecialchars(strip_tags($_POST['id']));
$image_name = imageUpload('file');

if ($image_name != 'fail') {
    $stmt = $con->prepare("UPDATE `users` SET `image_url`=? WHERE `id`=?");
    $stmt->execute(array($image_name, $id));
    if ($stmt->rowCount() > 0) {
        echo json_encode("success");
    }
}
else{
    echo json_encode("image_error");

}

?>