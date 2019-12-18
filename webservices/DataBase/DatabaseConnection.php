<?php

	class DatabaseConnection {

		public static function GetConnection () {

			$hostname_bases = "localhost";
			$database_bases = "prueba";
			$username_bases = "prueba";
			$password_bases = "prueba123";
			$conn = mysqli_connect($hostname_bases, $username_bases, $password_bases, $database_bases);

			if (!$conn) {
				echo "El sitio no se puede conectar a la base de datos en este momento, intente m&aacute;s tarde.";
				$e = mysqli_error();
				trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR);
			}

			return $conn;
		}
	}

?>






