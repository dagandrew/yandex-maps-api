<?php
//defaults and Smarty
require('resources/config.php');
require('lib/php/Smarty/Smarty.class.php');
date_default_timezone_set('Asia/Irkutsk');
mysqli_set_charset($link, "utf8");
$smarty = new Smarty();
$smarty->setTemplateDir('smarty/templates');
$smarty->setCompileDir('smarty/templates_c');
$smarty->setCacheDir('smarty/cache');
$smarty->setConfigDir('smarty/configs');

//for 
if (isset($_GET["p"])) {
	$smarty->assign('page', $_GET["p"]);
}

$siteName = "Postman";
$smarty->assign('name', $siteName);

//describe your users table - name and 3 rows
$users_table_name = "users";
$users_table_id = "id";
$users_table_email = "email";
$users_table_password = "password";

//how long the log in cookie lives - 30 days
$cookie_name = "loggedin";
$cookie_time = 60 * 60 * 24 * 30;

//if route exists, show it
$user_route_addresses = array();
$query = "SELECT * FROM users_routes WHERE user_id = '$_COOKIE[$cookie_name]' AND isFinished = 0";
if ($result = mysqli_query($link, $query)) {
    while ($row = mysqli_fetch_assoc($result)) {
        $smarty->assign('current_route', 1);
    }
    mysqli_free_result($result);
    
    $query = "SELECT routes_addresses.id, route_id, street, building, apartment, addressee, status, longitude, latitude FROM routes_addresses LEFT JOIN users_routes ON users_routes.id = routes_addresses.route_id WHERE users_routes.user_id = '$_COOKIE[$cookie_name]' AND isFinished = 0 ORDER BY routes_addresses.id";
	if ($result = mysqli_query($link, $query)) {
		while ($row = mysqli_fetch_assoc($result)) {
			array_push($user_route_addresses, array('id' => $row["id"], 'street' => $row["street"], 'building' => $row["building"], 'apartment' => $row["apartment"], 'addressee' => $row["addressee"], 'status' => $row["status"], 'latitude' => $row["latitude"], 'longitude' => $row["longitude"]));
		}
		$smarty->assign('user_route_addresses', $user_route_addresses);
		mysqli_free_result($result);
	}
	
}


// correction page
$arrayWithCoordinates = array();
if (isset($_POST['correct'])){
	
	$cstreets = $_POST['street'];
	$cbuildings = $_POST['building'];
	$capartments = $_POST['apartment'];
	$caddressees = $_POST['addressee'];
	
	
	
	for ($i = 0; $i < sizeof($cstreets); $i++){
		array_push($arrayWithCoordinates, array('street' => $cstreets[$i], 'building' => $cbuildings[$i], 'apartment' => $capartments[$i], 'addressee' => $caddressees[$i]));
	}

	$smarty->assign('arrayWithCoordinates', $arrayWithCoordinates);
	
	$smarty->assign('page', 'mapcoordinates');
	//header("Location: index.php");
}

// building map page
if (isset($_POST['sendCoordinates'])){
	$tstreets = $_POST['street'];
	$tbuildings = $_POST['building'];
	$tapartments = $_POST['apartment'];
	$taddressees = $_POST['addressee'];
	$tlatitude = $_POST['latitude'];
	$tlongitude = $_POST['longitude'];
	$today = date("m.d.y");
	
	$sql = "INSERT INTO users_routes(user_id, name) VALUES ($_COOKIE[$cookie_name], '$today')";
	
	if($link->query($sql)===TRUE){
		
	} else {
		echo "Error: " . $sql . "<br>" . $link->error;
	}
	
	$query = "SELECT id FROM users_routes ORDER BY id DESC LIMIT 1";
	if ($result = mysqli_query($link, $query)) {
		
		while ($row = mysqli_fetch_assoc($result)) {
			$route_id = $row["id"];
			
		}
		mysqli_free_result($result);
	}
	
	
	for ($i = 0; $i < sizeof($tstreets); $i++){
		
		$sql2 = "INSERT INTO routes_addresses (user_id, route_id, street, building, apartment, addressee, latitude, longitude) VALUES ($_COOKIE[$cookie_name], $route_id, '$tstreets[$i]', '$tbuildings[$i]', '$tapartments[$i]', '$taddressees[$i]', '$tlatitude[$i]', '$tlongitude[$i]')";
	
		if($link->query($sql2)===TRUE){
			
		} else {
			echo "failed";
		}
	}
	//header("Location: index.php");
}



// adding route page
if (isset($_POST['send'])){
	function my_ofset($text){
		preg_match('/^\D*(?=\d)/', $text, $m);
		return isset($m[0]) ? strlen($m[0]) : false;
	}
	 // streets array
	$streets = array();
	$query = "SELECT street FROM streets";
	if ($result = mysqli_query($link, $query)) {
		while ($row = mysqli_fetch_assoc($result)) {
			array_push($streets, $row["street"]);
		}
		mysqli_free_result($result);
	}
     $string = $_POST['text'];
     $addressees = $_POST['addressee'];
     $addressees = str_replace("\"", "", $addressees);
     $string=str_replace("----","Улан-Удэ", $string);
     $string=str_replace("-...","Улан-Удэ", $string);
     $string=str_replace("--","Улан-Удэ", $string);
     $string=str_replace(".",",",$string);
     $pieces = preg_split( "/(шпи|ШПИ|Шпи|ШПи|шПи|шпИ|ШпИ|\r)/", $string );
     $addressees = preg_split("/\r/", $addressees);
	 $array = array();
	 $corrected = array();
	 $adr = array();
	 
	 for ($i = 0; $i < sizeof($pieces); $i++){
		$pos = strpos(mb_strtolower($pieces[$i]), 'улан');
        $full_address = substr($pieces[$i], $pos + 16);
		$number_pos = my_ofset($full_address);
		$street_address = substr($full_address, 0, $number_pos);
		$street_address = str_replace(str_split('-I|.,'), '', $street_address);
		$number_pos = my_ofset($full_address);
		$addressee = $addressees[$i];
		$street_building = substr($full_address, $number_pos, strpos(substr($full_address, $number_pos), ','));
		if(!$street_building) {$street_building = substr($full_address, $number_pos, strpos(substr($full_address, $number_pos), ' '));}
		foreach ($streets as $street){
                if ((strpos(mb_strtolower($street_address), mb_strtolower(mb_substr($street, 0, 3))) !== false) && (strpos(mb_strtolower($street_address), mb_strtolower(mb_substr($street, 3, strlen($street)))) !== false)) {
					$full = $street . " " . substr($full_address, strcspn( $full_address, '0123456789'));
					array_push($adr, array('full' => $full, 'street' => $street, 'other' => $street_building, 'addressee' => "$addressee"));
                    break;
                } 
                else if ($street == end($streets)) {
					array_push($adr, array('full' => $full_address, 'street' => $full_address, 'other' => '', 'addressee' => "$addressee"));
                }
        }
	 }
	 
$smarty->assign('streets', $adr);
$smarty->assign('page', 'correction');

}

//log in and registration
if (isset($_COOKIE[$cookie_name])){
	$cookie_value = $_COOKIE[$cookie_name];
	$smarty->assign('user', $cookie_value);
	$nav = [['badge' => 'fas fa-graduation-cap', 'link' => '/', 'name' => 'Уроки'],
			['badge' => 'fas fa-dumbbell', 'link' => '/trainings/', 'name' => 'Тренировки'],
			['badge' => 'fas fa-align-left', 'link' => '/texts/', 'name' => 'Тексты'],
			['badge' => 'fas fa-book-open', 'link' => '/dictionary/', 'name' => 'Словарь'],
			['badge' => 'fas fa-list-alt', 'link' => '/grammar/', 'name' => 'Грамматика']];
    $smarty->assign('nav', $nav);
	$smarty->display('index.tpl');
	mysqli_close($link);
} else {
	
	if (isset($_POST['login'])){
		$user = $_POST['email'];
		$pass = $_POST['password'];
		
		$phash = sha1(sha1($pass."salt")."salt");
		
		$sql = "SELECT * FROM $users_table_name WHERE $users_table_email='$user' AND $users_table_password='$phash';";
		$result = mysqli_query($link, $sql);
		$count = mysqli_num_rows($result);
		if ($count == 1) {
			while($row =  mysqli_fetch_assoc($result)) {
				$cookie_value = $row["id"];
				setcookie($cookie_name, $cookie_value, time() + $cookie_time, "/");
				header("Location: index.php");
			}
		} else {
			echo "Неправильный email или пароль";
		}
		
	} else if (isset($_POST['register'])){
		$user = $_POST['email'];
		$pass = $_POST['password'];
		
		$phash = sha1(sha1($pass."salt")."salt");
		
		$sql = "INSERT INTO $users_table_name ($users_table_id, $users_table_email, $users_table_password) VALUES  ('', '$user', '$phash');";
		
		$result = mysqli_query($link, $sql);
		
		$sql2 = "SELECT * FROM $users_table_name WHERE $users_table_email='$user' AND $users_table_password='$phash';";
		
		$result2 = mysqli_query($link, $sql2);
		$count2 = mysqli_num_rows($result2);
		if ($count2 == 1) {
			while($row =  mysqli_fetch_assoc($result2)) {
				$cookie_value = $row["id"];
				setcookie($cookie_name, $cookie_value, time() + $cookie_time, "/");
				header("Location: index.php");
			}
		} 
	}
	$smarty->display('registration.tpl');

}

?>
