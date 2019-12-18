<?php

	require_once './Controller/JwtController.php';
	require_once './Controller/SiteController.php';

	if(isset($_SERVER['HTTP_AUTH'])) {
		$token = $_SERVER['HTTP_AUTH'];
	} else {
		$token = null;
	}

	if ($_SERVER['REQUEST_METHOD'] === 'GET') {
		if(isset($token) && JwtController::Check($token)) {
			if(isset($_GET['site_id']) && filter_var($_GET['site_id'], FILTER_VALIDATE_INT)) {
				$site_id = $_GET['site_id'];
			} else {
				$site_id = null;
			}
			if(isset($_GET['uid'])) {
				$uid = $_GET['uid'];
			} else {
				$uid = null;
			}
			if(isset($_GET['like'])) {
				$like = $_GET['like'];
			} else {
				$like = null;
			}
			if (count($_GET) == 3 && isset($site_id) && isset($uid) && isset($like)) {
				SiteController::UserLikeSite($site_id, $uid, $like);			
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
