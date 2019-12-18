<?php

	require_once './Dao/UserDao.php';

	class UserController {

		public static function CreateAnonymousUser($name, $imei) {
			UserDao::CreateAnonymousUser($name, $imei);
		}

		public static function CreateFacebookUser($uid, $name, $imei) {
			UserDao::CreateFacebookUser($uid, $name, $imei);
		}

		public static function RetrieveUser($uid) {
			UserDao::RetrieveUser($uid);
		}

		public static function ExistUser($uid) {
			return UserDao::ExistUser($uid);
		}

		public static function UserVisitSite($uid, $site_id) {
			return UserDao::UserVisitSite($uid, $site_id);
		}

		public static function DeleteUser($uid, $user_type) {
			UserDao::DeleteUser($uid, $user_type);
		}


	}

?>
