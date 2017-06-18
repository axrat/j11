<?php
namespace Onoie\J;
class Func{
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
    //Helper
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