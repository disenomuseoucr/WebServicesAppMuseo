<?php

	require_once './DataBase/DatabaseConnection.php';

	class ScreenDataDao {

		public static function GetScreenDataByScreenId($screenId) {

			$conn = DatabaseConnection::GetConnection();

		        /* sacamos los screensData de bd */
		        $query = "SELECT * FROM SCREEN_DATA WHERE SCREEN_ID = ? ORDER BY ORDER_DATA";
		        $stid = mysqli_prepare($conn,$query);

			mysqli_stmt_bind_param($stid, "d", $screenId);

			mysqli_stmt_execute($stid);

			$result = mysqli_stmt_get_result($stid);

		        /* creamos el array con los datos */
		        $screensData = array();
		        if(mysqli_num_rows($result)) {
		                while($screenData = mysqli_fetch_assoc($result)) {
		                        $screensData[] = array_map('utf8_encode', $screenData);
		                }
		        }

	                header('Content-type: application/json');
	                echo json_encode($screensData);

			mysqli_close($conn);
		}

		public static function GetScreenDataByScreenName($screenName) {

			$conn = DatabaseConnection::GetConnection();

		        /* sacamos los screensData de bd */
		        $query = "SELECT * FROM SCREEN, SCREEN_DATA WHERE SCREEN.ID = SCREEN_DATA.SCREEN_ID AND BINARY SCREEN.NAME = ? ORDER BY ORDER_DATA";
		        $stid = mysqli_prepare($conn,$query);

			mysqli_stmt_bind_param($stid, "s", $screenName);

			mysqli_stmt_execute($stid);

			$result = mysqli_stmt_get_result($stid);

		        /* creamos el array con los datos */
		        $screensData = array();
		        if(mysqli_num_rows($result)) {
		                while($screenData = mysqli_fetch_assoc($result)) {
		                        $screensData[] = array_map('utf8_encode', $screenData);
		                }
		        }

	                header('Content-type: application/json');
	                echo json_encode($screensData);

			mysqli_close($conn);
		}



	}

?>