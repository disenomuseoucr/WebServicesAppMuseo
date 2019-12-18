<?php

        class Utils {

		const CONFIG_FILE_PATH = "../pruebas-files/config.txt";
                const CONFIG_VAR_KEY = "key";


                public static function GetSecretKey() {
			$lines_array = file(Utils::CONFIG_FILE_PATH);
			$search_string = Utils::CONFIG_VAR_KEY;

			foreach($lines_array as $line) {
			    if(strpos($line, $search_string) !== false) {
			        list(, $new_str) = explode(":", $line);
				$value = trim($new_str);
			    }
			}

                        return $value;
                }

        }

?>

