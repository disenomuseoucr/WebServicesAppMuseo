<?php

	require_once './Dao/SiteDao.php';

	class SiteController {

		public static function RetrieveSite($id) {

			if(isset($id)) {
				SiteDao::GetSite($id);
			} else {
				SiteDao::GetSites();
			}
		}

		public static function RetrieveVisitedSitesByUser($uid) {

			if(isset($uid)) {
				SiteDao::GetVisitedSitesByUser($uid);
			}

		}

		public static function RetrieveSiteByUser($id, $uid) {

			if(isset($id) && isset($uid)) {
				SiteDao::GetSiteByUser($id, $uid);
			}

		}

		public static function UserLikeSite($site_id, $uid, $like) {

			if(isset($site_id) && isset($uid) && isset($like)) {
				if($like) {
					SiteDao::UserLikeSite($site_id, $uid);
				} else {
					SiteDao::UserUnlikeSite($site_id, $uid);
				}
			}

		}

	}

?>
