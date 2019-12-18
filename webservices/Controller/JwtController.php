<?php
	use Firebase\JWT\JWT;

	require_once './lib/php-jwt/autoload.php';
	require_once './Utils/Utils.php';


	class JwtController {

		private static $secret_key = 'secreto';
		private static $encrypt = ['HS256'];
    
		public static function Check($token) {
			if(empty($token)) {
				throw new Exception("Invalid token supplied.");
			}
			try {
				$decode = JWT::decode(
					$token,
					base64_decode(Utils::GetSecretKey()),
					self::$encrypt
				);
			} catch (Exception $e) {
				return false;
			}
			return true;
		}
    
		public static function GetData($token) {
			return JWT::decode(
            			$token,
				self::$secret_key,
				self::$encrypt
			);
		}
    
	}

?>
