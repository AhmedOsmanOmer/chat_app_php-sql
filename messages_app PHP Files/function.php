<?php 
define('MB',1048576);

function imageUpload($imageRequest){
    global $msgError;
    $imagename= rand(1000,10000)  .$_FILES[$imageRequest]['name'];
    $imagetmp =$_FILES[$imageRequest]['tmp_name'];
    $imagesize=$_FILES[$imageRequest]['size'];
    $imagename=$_FILES[$imageRequest]['name'];
    $allowExt=array("jpg","png","jpeg");
    $strToArray=explode(".",$imagename);
    $ext=end($strToArray);
    $ext=strtolower($ext);
    if(!empty($imagename) && !in_array($ext,$allowExt)){
       $msgError[]="Ext";
    }
    if($imagesize > 10*MB){
        $msgError[]="size";
   
    }
    if(empty($msgError)){
        move_uploaded_file("$imagetmp","upload/" .$imagename);
        return $imagename;
    }else{
        return "fail";
    }
}
?>