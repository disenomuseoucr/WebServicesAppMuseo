<?php

	require_once './DataBase/DatabaseConnection.php';

	class SiteDao {

		public static function GetSites() {

			$conn = DatabaseConnection::GetConnection();

		        /* sacamos los sites de bd */
		        $query = "SELECT * FROM SITE ORDER BY id";
		        $result = mysqli_query($conn,$query) or die('Query no funcional:  '.$query);

		        /* creamos el array con los datos */
		        $sites = array();
		        if(mysqli_num_rows($result)) {
		                while($site = mysqli_fetch_assoc($result)) {
		                        $sites[] = array_map('utf8_encode', $site);
		                }
		        }

	                header('Content-type: application/json');
	                echo json_encode($sites);

			mysqli_close($conn);

		}

		public static function GetSite($id) {

			$conn = DatabaseConnection::GetConnection();

		        /* sacamos los sites de bd */
		        $query = "SELECT * FROM SITE WHERE ID = ? ORDER BY id";
		        $stid = mysqli_prepare($conn,$query);

			mysqli_stmt_bind_param($stid, "d", $id);

			mysqli_stmt_execute($stid);

			$result = mysqli_stmt_get_result($stid);

		        if(mysqli_num_rows($result)) {
		                $site = mysqli_fetch_assoc($result);
		                header('Content-type: application/json');
		                echo json_encode(array_map('utf8_encode', $site));
		        } else {
				header("HTTP/1.0 404 Not Found");
				echo "<h1>404 Not Found</h1>La b&uacute;squeda no ha devuelto resultados";
			}

			mysqli_close($conn);
		}

		public static function GetVisitedSitesByUser($uid) {

			$conn = DatabaseConnection::GetConnection();

		        /* sacamos los sites de bd */
		        $query = "SELECT S.ID, S.LATITUDE, S.LONGITUDE, S.ACCESS_DISTANCE, S.NAME, ".
				 "(SELECT COUNT(*) FROM USER_SITE US WHERE US.SITE_ID = S.ID AND US.UID = ?) AS VISITED ". 
				 "FROM SITE S ORDER BY id";
		        $stid = mysqli_prepare($conn,$query);

			mysqli_stmt_bind_param($stid, "s", $uid);

			mysqli_stmt_execute($stid);

			$result = mysqli_stmt_get_result($stid);

		        /* creamos el array con los datos */
		        $sites = array();
		        if(mysqli_num_rows($result)) {
		                while($site = mysqli_fetch_assoc($result)) {
		                        $sites[] = array_map('utf8_encode', $site);
		                }
		        }

	                header('Content-type: application/json');
	                echo json_encode($sites);

			mysqli_close($conn);

		}

		public static function GetSiteByUser($site_id, $uid) {

			$conn = DatabaseConnection::GetConnection();

		        /* sacamos los sites de bd */
		        $query = "SELECT S.ID, S.LATITUDE, S.LONGITUDE, S.ACCESS_DISTANCE, S.NAME, ". 
				 "(SELECT COUNT(*) FROM USER_SITE US WHERE US.SITE_ID = ? AND US.UID = ?) AS VISITED, ". 
				 "(SELECT COUNT(*) FROM SITE_LIKES SL1 WHERE SL1.SITE_ID = ? AND SL1.UID = ?) AS HIT_LIKE, ". 
				 "(SELECT COUNT(*) FROM SITE_LIKES SL2 WHERE SL2.SITE_ID = ?) AS TOTAL_LIKES ".
				 "FROM SITE S ORDER BY id";
		        $stid = mysqli_prepare($conn,$query);

			mysqli_stmt_bind_param($stid, "dsdsd", $site_id, $uid, $site_id, $uid, $site_id);

			mysqli_stmt_execute($stid);

			$result = mysqli_stmt_get_result($stid);

		        if(mysqli_num_rows($result)) {
		                $site = mysqli_fetch_assoc($result);
		                header('Content-type: application/json');
		                echo json_encode(array_map('utf8_encode', $site));
		        } else {
				header("HTTP/1.0 404 Not Found");
				echo "<h1>404 Not Found</h1>La b&uacute;squeda no ha devuelto resultados";
			}

			mysqli_close($conn);
		}

		public static function UserLikeSite($site_id, $uid) {
			$conn = DatabaseConnection::GetConnection();

			$query = "INSERT INTO SITE_LIKES (SITE_ID,UID) VALUES (?,?)";
		        $stid = mysqli_prepare($conn,$query);

			mysqli_stmt_bind_param($stid, "ss", $site_id, $uid);

			mysqli_stmt_execute($stid);

			mysqli_close($conn);
		}

		public static function UserUnlikeSite($site_id, $uid) {
			$conn = DatabaseConnection::GetConnection();

			$query = "DELETE FROM SITE_LIKES WHERE SITE_ID = ? AND UID = ?";
		        $stid = mysqli_prepare($conn,$query);

			mysqli_stmt_bind_param($stid, "ss", $site_id, $uid);

			mysqli_stmt_execute($stid);

			mysqli_close($conn);
		}


	}

?>