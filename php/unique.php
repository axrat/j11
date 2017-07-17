<?php
/**
 * Created by PhpStorm.
 * User: onoie
 * Date: 7/17/17
 * Time: 1:38 PM
 */
namespace Onoie\J;
class Unique{
    protected function __construct() { }
    public static function getInstance() {
        if (static::$instance === NULL) {
            static::$instance = new static;
        }
        return static::$instance;
    }
    static function renderReference(){
        echo <<< EOF
    
<link rel="stylesheet" href="//rawgit.com/TransAssist/cdn/master/css/x.css"/>
<link rel="stylesheet" href="//rawgit.com/TransAssist/cdn/master/css/v.css"/>
<link rel="stylesheet" href="//rawgit.com/TransAssist/cdn/master/css/h.css"/>
<link rel="stylesheet" href="//rawgit.com/TransAssist/cdn/master/css/c.css"/>
<link rel="stylesheet" href="//rawgit.com/TransAssist/cdn/master/css/ex.css"/>
<link rel="stylesheet" href="//rawgit.com/TransAssist/cdn/master/plugin/xslider/xslider.css"/>
<link rel="stylesheet" href="//rawgit.com/TransAssist/cdn/master/unique/onoie.com.css"/>
<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/animate.css/3.2.0/animate.min.css">
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"/>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script src="//rawgit.com/TransAssist/cdn/master/vendor/animatedModal.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/holder/2.9.4/holder.min.js"></script>
<script src="//rawgit.com/TransAssist/cdn/master/js/t.js"></script>
<script src="//rawgit.com/TransAssist/cdn/master/plugin/xslider/xslider.js"></script>
<script src="//rawgit.com/TransAssist/cdn/master/analytics/onoie.com.js"></script>

EOF;
    }
}