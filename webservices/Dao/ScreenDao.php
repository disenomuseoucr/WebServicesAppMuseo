<?php

	require_once './DataBase/DatabaseConnection.php';

	class ScreenDao {

		public static function GetScreens() {

			$conn = DatabaseConnection::GetConnection();

		        /* sacamos los screens de bd */
		        $query = "SELECT * FROM SCREEN ORDER BY id";
		        $result = mysqli_query($conn,$query) or die('Query no funcional:  '.$query);

		        /* creamos el array con los datos */
		        $screens = array();
		        if(mysqli_num_rows($result)) {
		                while($screen = mysqli_fetch_assoc($result)) {
		                        $screens[] = array_map('utf8_encode', $screen);
		                }
		        }

	                header('Content-type: application/json');
	                echo json_encode($screens);

			mysqli_close($conn);
		}

		public static function GetScreen($id) {

			$conn = DatabaseConnection::GetConnection();

		        /* sacamos los screens de bd */
		        $query = "SELECT * FROM SCREEN WHERE ID = ? ORDER BY id";
		        $stid = mysqli_prepare($conn,$query);

			mysqli_stmt_bind_param($stid, "d", $id);

			mysqli_stmt_execute($stid);

			$result = mysqli_stmt_get_result($stid);

		        if(mysqli_num_rows($result)) {
		                $screen = mysqli_fetch_assoc($result);
		                header('Content-type: application/json');
		                echo json_encode(array_map('utf8_encode', $screen));
		        } else {
				header("HTTP/1.0 404 Not Found");
				echo "<h1>404 Not Found</h1>La b&uacute;squeda no ha devuelto resultados";
			}

			mysqli_close($conn);
		}


	}

?>