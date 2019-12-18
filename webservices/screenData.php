<?php

	require_once './Controller/JwtController.php';
	require_once './Controller/ScreenDataController.php';

	if(isset($_SERVER['HTTP_AUTH'])) {
		$token = $_SERVER['HTTP_AUTH'];
	} else {
		$token = null;
	}

	if ($_SERVER['REQUEST_METHOD'] === 'GET') {
		if(isset($token) && JwtController::Check($token)) {
			if(isset($_GET['screen_id']) && filter_var($_GET['screen_id'], FILTER_VALIDATE_INT)) {
				$screenId = $_GET['screen_id'];
			} else {
				$screenId = null;
			}
			if(isset($_GET['screen_name'])) {
				$screenName = $_GET['screen_name'];
			} else {
				$screenName = null;
			}
			if (count($_GET) == 1 && isset($screenId) && !isset($screenName) || 
		    	    count($_GET) == 1 && isset($screenName) && !isset($screenId)) {
				if(isset($screenId)) {
					ScreenDataController::RetrieveScreenDataByScreenId($screenId);
				} elseif(isset($screenName)) {
					ScreenDataController::RetrieveScreenDataByScreenName($screenName);
				}
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
