<?php

	if (count($_GET) == 0) {
		date_default_timezone_set('America/Costa_Rica');
		$date = date('d/m/Y h:i:s a', time());

		$posts = array();

		header('Content-type: application/json');
		echo json_encode(array('CURRENT_DATE'=>$date));
	} else {
		header('HTTP/1.1 500 Internal Server Error');
		echo "Par&aacute;metro incorrecto";
	}

?>

