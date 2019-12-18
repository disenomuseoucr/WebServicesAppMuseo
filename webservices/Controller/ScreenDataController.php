<?php

	require_once './Dao/ScreenDataDao.php';

	class ScreenDataController {

		public static function RetrieveScreenDataByScreenId($screenId) {
			ScreenDataDao::GetScreenDataByScreenId($screenId);
		}

		public static function RetrieveScreenDataByScreenName($screenName) {
			ScreenDataDao::GetScreenDataByScreenName($screenName);
		}

	}

?>
