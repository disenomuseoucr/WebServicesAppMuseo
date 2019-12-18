<?php

	require_once './Dao/ScreenDao.php';

	class ScreenController {

		public static function RetrieveScreen($id) {
			if(isset($id)) {
				ScreenDao::GetScreen($id);
			} else {
				ScreenDao::GetScreens();
			}
		}

	}

?>
