<?php
namespace Onoie\J;
function echoArg($args){
	return $args;
}
function first(){
	echo <<< EOF

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width,initial-scale=1"/>

EOF;
}
function middle(){
	echo <<< EOF

</head>
<body>


EOF;
}
function last(){
	echo <<< EOF

</body>
</html>

EOF;
}
?>
