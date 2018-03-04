<?php

namespace Onoie;

use Exception;
use SplFileInfo;
use DateTime;
use DateTimeZone;
use ZipArchive;

class J11{
    protected function __construct() { }
    public static function getInstance() {
        if (static::$instance === NULL) {
            static::$instance = new static;
        }
        return static::$instance;
    }
    public static function hello($name="Unknown") {
        echo 'Hello'.$name."!".PHP_EOL;
    }
    //echo(J\Func::systemInfo());
    public static function systemInfo() {
        return "PHP Version:".PHP_VERSION.PHP_EOL;
    }
    public static function allUserDefined() {
        return get_defined_constants(TRUE)['user'];
    }
    public static function escapeHtml($str) {
        return htmlspecialchars($str, ENT_QUOTES, 'UTF-8');
    }
    public static function echoDirTree($path,$base = null){
        if ($handle = opendir($path)){
            echo '<ul style="list-style: none;">';
            $queue = array();
            while (false !== ($file = readdir($handle))){
                if (is_dir($path.$file) && $file != '.' && $file !='..') {
                    self::printSubDir($base,$file, $path, $queue);
                } else if ($file != '.' && $file !='..') {
                    $queue[] = $file;
                }
            }
            self::printQueue($base,$queue, $path);
            echo '</ul>';
        }
    }
    public static function printQueue($base,$queue,$path){
        foreach ($queue as $file){
            self::printFile($base,$file, $path);
        }
    }
    public static function printFile($base,$file,$path){
        echo "<li><a href=\"".($base==null?$path:$base).$file."\">$file</a></li>\n";
    }
    public static function printSubDir($base,$dir,$path){
        echo "<li><span class=\"dir\">$dir</span>";
        self::echoDirTree($path.$dir."/", $base);
        echo "</li>\n";
    }
    public static function deltree($dir) {
        if($handle = opendir("$dir")) {
            while(false !== ($item = readdir($handle))) {
                if($item != "." && $item != "..") {
                    if(is_dir("$dir/$item")) {
                        self::deltree("$dir/$item");
                    }else{
                        unlink("$dir/$item");
                        //echo " removing $dir/$item<br>\n";
                    }
                }
            }
            closedir($handle);
            rmdir($dir);
            //echo "removing $dir<br/>\n";
        }
    }
    public static function cptree($dir, $dst) {
        if (!file_exists($dst)) if(!mkdir($dst, 0755, true)) return false;
        if (!is_dir($dir) || is_link($dir)) return copy($dir, $dst); // should not happen
        $files = array_diff(scandir($dir), array('.','..'));
        $sep = (substr($dir, -1) == DIRECTORY_SEPARATOR ? '' : DIRECTORY_SEPARATOR);
        $dsp = (substr($dst, -1) == DIRECTORY_SEPARATOR ? '' : DIRECTORY_SEPARATOR);
        foreach ($files as $file) {
            (is_dir("$dir$sep$file")) ? self::cptree("$dir$sep$file", "$dst$dsp$file") : copy("$dir$sep$file", "$dst$dsp$file");
        }
        return true;
    }
    public static function unzip($zip_path, $unzip_dir) {
        $zip = new ZipArchive();
        if( $zip->open($zip_path) === true ) {
            $zip->extractTo($unzip_dir);
            $stat = $zip->statIndex(0);
            $folder = $stat['name'];
            $zip->close();
            return $folder;
        }else {
            die('ZIP not supported on this server!');
        }
    }
    public static function curl_download($url,$destination,$username=null,$password=null) {
        try{
            $fp = fopen($destination, "w");
            $ch = curl_init();
            curl_setopt($ch, CURLOPT_URL, $url);
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, false);
            if(isset($username)&&isset($password)){
                curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
                curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
                curl_setopt($ch, CURLOPT_HTTPAUTH, CURLAUTH_BASIC);
                curl_setopt($ch, CURLOPT_USERPWD, $username . ":" . $password);
            }
            curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 30);
            curl_setopt($ch, CURLOPT_TIMEOUT, 10);
            curl_setopt($ch, CURLOPT_FILE, $fp);
            curl_exec($ch);
        }catch (Exception $ex){
            throw new Exception('Download Exception', 500);
        }finally{
            if ($ch != null) curl_close($ch);
            if ($fp != null) fclose($fp);
        }
    }

    /**
     * Ex) http://example.com/$base/child/params
     * @param $base
     * @return array(child,params)
     */
    public static function serviceFacade($base){
        try {
            if ($_SERVER["REQUEST_URI"] === $base) {
                //echo "Index";
            } else {
                $child_and_params = str_replace($base, "", $_SERVER["REQUEST_URI"]);
                if (preg_match('/(.+)\//', $child_and_params, $child)) {
                    $params = str_replace($child[1]."/", "", $child_and_params);
                    return array($child[1],$params);
                } else {
                    echo "UnknownPattern:[" . $child_and_params . "]";
                }
                exit;
            }
        } catch (Exception $e) {
            if (self::isLocalhost()) {
                echo $e->getMessage() . PHP_EOL;
            } else {
                header('Content-Type: text/plain; charset=UTF-8', true, 500);
                echo("Error Occurred");
            }
            exit;
        }
    }
    public static function echoTitleChangeScript($title=""){
        echo "<script>document.title='".$title."';</script>";
    }
    public static function getCurrentUrl(){
        return (empty($_SERVER["HTTPS"])?"http://" : "https://").$_SERVER["HTTP_HOST"].$_SERVER["REQUEST_URI"];
    }
    public static function isLocalhost(){
        $S_AD = $_SERVER['SERVER_ADDR'];
        $R_AD = $_SERVER['REMOTE_ADDR'];
        return substr($S_AD,0,mb_strrpos($S_AD,'.')) == substr($R_AD,0,mb_strrpos($R_AD,'.'));
    }
    public static function getOffset(){
        return date('Z')*1000;
    }
    public static function getUTC(){
        return ceil(microtime(true)*1000)-self::getOffset();
    }
    public static function getTokyoDateTimeString($utc){
        try {
            if(is_numeric($utc)){
                $date = new DateTime();
                $date->setTimestamp($utc/1000)->setTimezone(new DateTimeZone('Asia/Tokyo'));
                $date->modify('+9 hours');
                return $date->format('Y-m-d H:i:s');
            }else{
                return "ConvertError";
            }
        } catch (Exception $e) {
            return $e->getMessage() . PHP_EOL;
        }
    }
    function imgHeader($filename,$extension){
        mb_http_output("pass");
        header('Pragma: cache');
        //header("Cache-Control: max-age=" . (60 * 60 * 24 * 1));
        header("Content-type: image/".$extension);
        header("Content-Disposition: inline; filename=".$filename );
    }
    function showLocalImage($image_path){
        if (file_exists($image_path)) {
            $fp   = fopen($image_path,'rb');
            $size = filesize($image_path);
            $img  = fread($fp, $size);
            $info = new SplFileInfo($image_path);
            fclose($fp);
            header('Content-Type: image/'.$info->getExtension());
            echo $img;
        }else{
            self::getImage404();
        }
        exit(1);
    }
    public static function return404base64(){
        header("Content-type: image/png");
        header("Content-Disposition: inline; filename=404.png");
        echo base64_decode(IMG404);
    }
    public static function returnImage404(){
        try{
            $not_found="/j11/img/404.png";
            if (file_exists($not_found)) {
                self::showLocalImage($not_found);
                exit;
            }
        }finally{
            self::return404base64();
        }
    }
    //EOF
    public static function snscard($title,$description,$url,$type,$img){
//<meta property="fb:app_id" content="App ID" />
//<meta property="article:publisher" content="FacebookPageURL" />
        echo <<< EOF

<meta property="og:title" content="$title" />
<meta property="og:type" content="website" />
<meta property="og:url" content="$url" />
<meta property="og:image" content="$img" />
<meta property="og:site_name"  content="$title" />
<meta property="og:description" content="$description" />
<meta name="twitter:card" content="$type" />
<meta name="twitter:site" content="@Twitter" />
<meta name="twitter:title" content="$title" />
<meta name="twitter:url" content="$url" />
<meta name="twitter:description" content="$description" />
<meta name="twitter:image" content="$img" />

EOF;
    }
    public static function first(){
        echo <<< EOF

<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width,initial-scale=1"/>

EOF;
    }
    public static function middle(){
        echo <<< EOF

</head>
<body>


EOF;
    }
    public static function last(){
        echo <<< EOF

</body>
</html>

EOF;
    }
}
//Define
define("TWITTER_BTN",'<a href="https://twitter.com/share" class="twitter-share-button">Tweet</a> <script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?\'http\':\'https\';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+\'://platform.twitter.com/widgets.js\';fjs.parentNode.insertBefore(js,fjs);}}(document, \'script\', \'twitter-wjs\');</script>');
define("IMG404","iVBORw0KGgoAAAANSUhEUgAAAIAAAACACAYAAADDPmHLAAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH4QMKBzYqbjm2FQAAABl0RVh0Q29tbWVudABDcmVhdGVkIHdpdGggR0lNUFeBDhcAAALUSURBVHja7dm9TmppFIDhhSgkosQ7IKHR2mhtaetP7PRSSEg0obL2BrwFBe7AmNhQW3oJJBv8YU0xczjHGSYZsTjiPE9C4d5kxY/vley9LWVmBv9bSz4CASAABIAAEAACQAAIAAEgAASAABAAAkAACAABIAAEgAAQAAJAAAgAASAABIAAEAACQAAIAAEgAASAABAAAkAACAABIAAEgAAQAAJAAAgAASAABIAAEAACQAAIAAEgAASAAH44OTmJUqkUpVLpH+fG43G02+1oNptRrVaj2WxGu92O5+fnT839dnJBXV9fZ6VSyYjIWcs4Ojqanvv1dXx8/Km5381CrvDp6Sk3Njby/Px85kZ1u92MiKzX69nr9bIoiuz1elmv1zMist/vzzVXAF/E/v5+bm9v58vLy8yNOj09zYjITqfz7nin08mIyLOzs7nmCuALuLq6ykqlkoPB4M8FzNiozc3NjIjpe34YDAYZEbm1tTXXXAH8Zo+Pj1mr1fLi4uLnAmZs1NraWkZEDofDd8eHw2FGRK6vr8819zsq/bXYL28ymcTe3l4URRF3d3exvLwcETG9Uv91GeVyOSaTSby9vcXS0tK7GeVyOcrlcry+vn547ne0vCi/6OXlZdzf38fDw8N0k/7N6upqDIfDKIoiarXa9HhRFNPz88x1G/gbVavVmbd1f3999BrgI3O/o4V5EDQej//ze3d3dyMi4ubm5t3xHz/v7OzMNdc3wFe8ip3xF3p7ezt9DtDv93M0GmW/358+B+h2u3PNdRewIAFkZh4cHMz8Kj88PPzUXAEsSACj0ShbrVY2Go1cWVnJRqORrVYrR6ORABbxNhD/DUQACAABIAAEgAAQAAJAAAgAASAABIAAEAACQAAIAAEgAASAABAAAkAACAABIAAB+AgEgAAQAAJAAAgAASAABIAAEAACQAAIAAEgAASAABAAAkAACAABsLD+ALZVBG2zs62rAAAAAElFTkSuQmCC");
