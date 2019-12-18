<?php

	require_once './DataBase/DatabaseConnection.php';

	class UserDao {

		public static function CreateAnonymousUser($name, $imei) {

			$conn = DatabaseConnection::GetConnection();

			$query = "DELETE FROM USER WHERE IMEI = ?";
			$stid = mysqli_prepare($conn,$query);

			mysqli_stmt_bind_param($stid, "s", $imei);

			mysqli_stmt_execute($stid);

			$query = "INSERT INTO USER (USER_TYPE,NAME,IMEI) VALUES (0,?,?)";
		        $stid = mysqli_prepare($conn,$query);

			mysqli_stmt_bind_param($stid, "ss", $name, $imei);

			mysqli_stmt_execute($stid);

		        /* Devolver el UID */
		        $query = "SELECT UID FROM USER WHERE USER_TYPE = 0 AND NAME = ? AND IMEI = ?";
		        $stid = mysqli_prepare($conn,$query);

			mysqli_stmt_bind_param($stid, "ss", $name, $imei);

			mysqli_stmt_execute($stid);

			$result = mysqli_stmt_get_result($stid);

		        if(mysqli_num_rows($result)) {
		                $uid = mysqli_fetch_assoc($result);
		                header('Content-type: application/json');
		                echo json_encode(array_map('utf8_encode', $uid));
		        } else {
				header("HTTP/1.0 404 Not Found");
				echo "<h1>404 Not Found</h1>La b&uacute;squeda no ha devuelto resultados";
			}

			mysqli_close($conn);
		}

		public static function CreateFacebookUser($uid, $name, $imei) {

			$conn = DatabaseConnection::GetConnection();

			$query = "INSERT INTO USER (UID,USER_TYPE,NAME,IMEI) VALUES (?,1,?,?)";
		        $stid = mysqli_prepare($conn,$query);

			mysqli_stmt_bind_param($stid, "sss", $uid, $name, $imei);

			mysqli_stmt_execute($stid);

			mysqli_close($conn);
		}


		public static function RetrieveUser($uid) {

			$conn = DatabaseConnection::GetConnection();

		        /* sacamos los sites de bd */
		        $query = "SELECT * FROM USER WHERE UID = ? ORDER BY uid";
		        $stid = mysqli_prepare($conn,$query);

			mysqli_stmt_bind_param($stid, "s", $uid);

			mysqli_stmt_execute($stid);

			$result = mysqli_stmt_get_result($stid);

		        if(mysqli_num_rows($result)) {
		                $user = mysqli_fetch_assoc($result);
		                header('Content-type: application/json');
		                echo json_encode(array_map('utf8_encode', $user));
		        } else {
				header("HTTP/1.0 404 Not Found");
				echo "<h1>404 Not Found</h1>La b&uacute;squeda no ha devuelto resultados";
			}

			mysqli_close($conn);
		}

		public static function ExistUser($uid) {

			$conn = DatabaseConnection::GetConnection();

		        /* sacamos los sites de bd */
		        $query = "SELECT * FROM USER WHERE UID = ? ORDER BY uid";
		        $stid = mysqli_prepare($conn,$query);

			mysqli_stmt_bind_param($stid, "s", $uid);

			mysqli_stmt_execute($stid);

			$result = mysqli_stmt_get_result($stid);

			$exist_user = FALSE;

		        if(mysqli_num_rows($result)) {
				$exist_user = TRUE;
		        }

			mysqli_close($conn);

			return $exist_user;
		}

		public static function UserVisitSite($uid, $site_id) {
			$conn = DatabaseConnection::GetConnection();

			$query = "INSERT INTO USER_SITE (UID,SITE_ID) VALUES (?,?)";
		        $stid = mysqli_prepare($conn,$query);

			mysqli_stmt_bind_param($stid, "ss", $uid, $site_id);

			mysqli_stmt_execute($stid);

			mysqli_close($conn);
		}

		public static function DeleteUser($uid, $user_type) {
			$conn = DatabaseConnection::GetConnection();

			$query = "DELETE FROM USER WHERE UID = ? AND USER_TYPE = ?";
		        $stid = mysqli_prepare($conn,$query);

			mysqli_stmt_bind_param($stid, "sd", $uid, $user_type);

			mysqli_stmt_execute($stid);

			mysqli_close($conn);
		}


	}

?>