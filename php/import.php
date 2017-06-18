<?php
require_once ("func.php");
function createPDO($db_host, $db_user, $db_pass, $db_name){
    $pdo= new PDO('mysql:dbname='.$db_name.';host='.$db_host, $db_user,$db_pass);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    $pdo->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
    return $pdo;
}
function createMysqli($db_host, $db_user, $db_pass, $db_name){
    return new mysqli($db_host, $db_user, $db_pass, $db_name);
}
function getTokyoDateTimeString($utc){
    if(is_numeric($utc)){
        $date = new DateTime();
        $date->setTimestamp($utc/1000)->setTimezone(new DateTimeZone('Asia/Tokyo'));
        $date->modify('+9 hours');
        return $date->format('Y-m-d H:i:s');
    }else{
        return "ConvertError";
    }
}
?>