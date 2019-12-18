<?php

	require_once './DataBase/DatabaseConnection.php';

	class SiteDataDao {

		public static function GetSiteDataBySiteId($siteId) {

			$conn = DatabaseConnection::GetConnection();

		        /* sacamos los sitesData de bd */
		        $query = "SELECT * FROM SITE_DATA WHERE SITE_ID = ? ORDER BY ORDER_DATA";
		        $stid = mysqli_prepare($conn,$query);

			mysqli_stmt_bind_param($stid, "d", $siteId);

			mysqli_stmt_execute($stid);

			$result = mysqli_stmt_get_result($stid);

		        /* creamos el array con los datos */
		        $sitesData = array();
		        if(mysqli_num_rows($result)) {
		                while($siteData = mysqli_fetch_assoc($result)) {
		                        $sitesData[] = array_map('utf8_encode', $siteData);
		                }
		        }

	                header('Content-type: application/json');
	                echo json_encode($sitesData);

			mysqli_close($conn);
		}


	}

?>