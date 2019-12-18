<?php

	require_once './Dao/SiteDataDao.php';

	class SiteDataController {

		public static function RetrieveSiteDataBySiteId($siteId) {
			SiteDataDao::GetSiteDataBySiteId($siteId);
		}

	}

?>
