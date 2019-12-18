<?php

	require_once './Controller/JwtController.php';
	require_once './Controller/UserController.php';

	if(isset($_SERVER['HTTP_AUTH'])) {
		$token = $_SERVER['HTTP_AUTH'];
	} else {
		$token = null;
	}

	if ($_SERVER['REQUEST_METHOD'] === 'POST') {
		if(isset($token) && JwtController::Check($token)) {
			if(isset($_POST['name'])) {
				$name = $_POST['name'];
			} else {
				$name = null;
			}
			if(isset($_POST['imei'])) {
				$imei = $_POST['imei'];
			} else {
				$imei = null;
			}
			if (count($_POST) == 2 && isset($name) && isset($imei)) {
				UserController::CreateAnonymousUser($name, $imei);			
			} else {
				header('HTTP/1.1 400 Bad Request');
				echo "<h1>400 Bad Request</h1>Par&aacute;metro incorrecto";
			}
		} else {
			header("HTTP/1.1 401 Unauthorized");
			echo "<h1>401 Unauthorized</h1>No ha proporcionado el par&aacute;metro de autenticaci&oacute;n o es incorrecto";
		}
	} else {
		header('HTTP/1.1 405 Method Not Allowed');
		echo "<h1>405 Method Not Allowed</h1>M&eacute;todo de solicitud inv&aacute;lido";
	}

?>
