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
				$id = $_GET['site_id'];
			} else {
				$id = null;
			}
			if(isset($_GET['uid'])) {
				$uid = $_GET['uid'];
			} else {
				$uid = null;
			}
			if(isset($_GET['user_type']) && filter_var($_GET['user_type'], FILTER_VALIDATE_INT)) {
				$user_type = $_GET['user_type'];
			} else {
				$user_type = null;
			}
			if (count($_GET) == 0 || count($_GET) == 1 && isset($id)) {
				SiteController::RetrieveSite($id);
			} elseif (count($_GET) == 1 && isset($uid)) {
				SiteController::RetrieveVisitedSitesByUser($uid);
			} elseif (count($_GET) == 2 && isset($id) && isset($uid)) {
				SiteController::RetrieveSiteByUser($id, $uid);			
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
