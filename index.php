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

$smarty->assign('css_path', '/post/public_html/css');
$smarty->assign('js_path', '/post/public_html/js');
$smarty->assign('icon_path', '/post/public_html/img/icon');

$assign_table = 'pm_assign';

$siteName = "Post";
$smarty->assign('name', $siteName);
$smarty->assign('page', '');
//for add page and for the future :)
if (isset($_GET["p"])) {
	$smarty->assign('page', $_GET["p"]);
	if ($_GET["p"] == "add"){
		error_reporting(0);
	}
} else {
error_reporting(0);
}
/*
if ($_GET["p"] == "test"){
	error_reporting(1);
}
*/

$cookie_name = "loggedin";
$cookie_time = 60 * 60 * 24 * 30;

//log in and registration
if (isset($_COOKIE[$cookie_name])){
	$user = $_COOKIE[$cookie_name];

	$route = 0;
	$routes_polylines = array();
	$user_route_addresses = array();
	$query = "SELECT id FROM $routes_table WHERE user_id = $user AND isFinished = 0";
	if ($result = mysqli_query($link, $query)) {
		if(mysqli_num_rows($result)!=0){
		while ($row = mysqli_fetch_assoc($result)) {
			$route = $row['id'];
		}
		mysqli_free_result($result);
		$smarty->assign('p', 'current_route');
		$smarty->assign('route', $route);
		
		$queryPolylines = "SELECT id, coordinates FROM $polylines_table WHERE user_id = $user and route_id = $route";
		
		if ($result = mysqli_query($link, $queryPolylines)) {
			while ($row = mysqli_fetch_assoc($result)) {
				array_push($routes_polylines, array('id' => $row['id'], 'coordinates' => $row['coordinates']));
			}
			$smarty->assign('routes_polylines', $routes_polylines);
			mysqli_free_result($result);
		}
		if ($_GET["p"] == "test"){
			$ad_tb = $addresses_table;
			$bu_tb = "pm_buildings";
			$st_tb = "pm_streets";
			$query = "SELECT $ad_tb.id, status, note, apartment, addressee, $st_tb.street, $bu_tb.building, $ad_tb.status, $bu_tb.latitude, $bu_tb.longitude FROM $ad_tb LEFT JOIN $bu_tb ON $ad_tb.building_id = $bu_tb.id LEFT JOIN $st_tb ON $bu_tb.street_id = $st_tb.id WHERE user_id = $user AND route_id = $route AND $ad_tb.building_id = 2 ORDER BY $ad_tb.id";
			if ($result = mysqli_query($link, $query)) {
				$sum = 0;
				while ($row = mysqli_fetch_assoc($result)) {
					array_push($user_route_addresses, array('note' => $row["note"], 'id' => $row["id"], 'street' => $row["street"], 'building' => $row["building"], 'apartment' => $row["apartment"], 'addressee' => $row["addressee"], 'status' => $row["status"], 'latitude' => $row["latitude"], 'longitude' => $row["longitude"]));
					if ($row['status'] == 1 || $row['status'] >= 4) { $sum += 5; }
					else if ($row['status'] == 2) {$sum += 15;}
					else if ($row['status'] == 3) {$sum += 3;}
				}
				$smarty->assign('user_route_addresses', $user_route_addresses);
				$smarty->assign('sum', $sum . ' р.');
				mysqli_free_result($result);
			}
		}
		else {
			$query = "SELECT id, note, street, building, apartment, addressee, status, longitude, latitude FROM $addresses_table WHERE user_id = $user AND route_id = $route ORDER BY id";
			if ($result = mysqli_query($link, $query)) {
				$sum = 0;
				while ($row = mysqli_fetch_assoc($result)) {
					array_push($user_route_addresses, array('note' => $row["note"], 'id' => $row["id"], 'street' => $row["street"], 'building' => $row["building"], 'apartment' => $row["apartment"], 'addressee' => $row["addressee"], 'status' => $row["status"], 'latitude' => $row["latitude"], 'longitude' => $row["longitude"]));
					if ($row['status'] == 1 || $row['status'] >= 4) { $sum += 5; }
					else if ($row['status'] == 2) {$sum += 15;}
					else if ($row['status'] == 3) {$sum += 3;}
				}
				$smarty->assign('user_route_addresses', $user_route_addresses);
				$smarty->assign('sum', $sum . ' р.');
				mysqli_free_result($result);
			}
		}
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
	
	//delete route and make a new one
	if (isset($_POST['delete_route'])){
		$sql = "UPDATE $routes_table SET isFinished = 1 WHERE id = $route";
		$link->query($sql);
		header("Location: index.php");
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
		
		$sql = "INSERT INTO $routes_table (user_id, name) VALUES ($_COOKIE[$cookie_name], '$today')";
		
		if($link->query($sql)===TRUE){
			
		} else {
			echo "Error: " . $sql . "<br>" . $link->error;
		}
		
		$query = "SELECT id FROM $routes_table ORDER BY id DESC LIMIT 1";
		if ($result = mysqli_query($link, $query)) {
			
			while ($row = mysqli_fetch_assoc($result)) {
				$route_id = $row["id"];
				
			}
			mysqli_free_result($result);
		}
		
		
		for ($i = 0; $i < sizeof($tstreets); $i++){
			
			$sql2 = "INSERT INTO $addresses_table (user_id, route_id, street, building, apartment, addressee, latitude, longitude) VALUES ($_COOKIE[$cookie_name], $route_id, '$tstreets[$i]', '$tbuildings[$i]', '$tapartments[$i]', '$taddressees[$i]', '$tlatitude[$i]', '$tlongitude[$i]')";
		
			if($link->query($sql2)===TRUE){
				
			} else {
				echo "failed";
			}
		}
		header("Location: index.php");
	}

function my_ofset($text){
	preg_match('/^\D*(?=\d)/', $text, $m);
	return isset($m[0]) ? strlen($m[0]) : false;
}

	// adding route page
	if (isset($_POST['send'])){
		function my_mb_ucfirst($str) {
			$fc = mb_strtoupper(mb_substr($str, 0, 1));
			return $fc.mb_substr($str, 1);
		}
		 // streets array
		$streets = array();
		$query = "SELECT street FROM $streets_table";
		if ($result = mysqli_query($link, $query)) {
			while ($row = mysqli_fetch_assoc($result)) {
				array_push($streets, $row["street"]);
			}
			mysqli_free_result($result);
		}
		 $string = mb_strtolower($_POST['text']);
		 $addressees = $_POST['addressee'];
		 $addressees = str_replace("\"", "", $addressees);
		 $string=str_replace(['г. улан-удэ', 'улан-удэ', 'россия', 'железнодорожный', 'октябрьский', 'советский', 'бурятия респ', 'бурятия', 'респ,', 'респ.', ' ул.', ' ул,', ',ул,', ',ул', 'ул ', 'г.', 'г,'], "", $string);
		 
		 $string=str_replace(".",",",$string);
		 $pieces = preg_split( "/(шпи|ШПИ|Шпи|ШПи|шПи|шпИ|ШпИ|\r)/", $string );
		 $addressees = preg_split( "/\r/", $addressees );
		 $adr = array();
		 for ($i = 0; $i < sizeof($pieces); $i++){
			/*foreach ($streets as $street){
				if ((strpos(mb_strtolower($pieces[$i]), mb_strtolower(mb_substr($street, 0, 3))) !== false) && (strpos(mb_strtolower($pieces[$i]), mb_strtolower(mb_substr($street, 3, strlen($street)))) !== false)) {
					$full = $street . " " . substr(*$pieces[$i], strcspn( $full_address, '0123456789'));
					array_push($adr, array('full' => $full, 'street' => $street, 'other' => $street_building, 'addressee' => "$addressee"));
					break;
				} 
				else if ($street == end($streets)) {
					array_push($adr, array('full' => $full_address, 'street' => $full_address, 'other' => '', 'addressee' => "$addressee"));
				}
			}
			*/
			$street='';
			
			$addressee = $addressees[$i];
			$full = preg_replace('/^[^а-яА-я]+/', '', $pieces[$i]);
			$street = preg_replace('/,.+/', '', $full);
			$street = preg_replace('/[0-9]+/', '', $street);
			preg_match_all('/(\d+)/', $full, $street_building);
			array_push($adr, array('full' => my_mb_ucfirst($full), 'street' => my_mb_ucfirst($street), 'building' => $street_building[0][0], 'apartment' => $street_building[0][1], 'addressee' => "$addressee"));
		 }
		 
	$smarty->assign('streets', $adr);
	$smarty->assign('page', 'correction');

	}
	
	
	$cookie_value = $_COOKIE[$cookie_name];
	
	$smarty->assign('user', $cookie_value);
	$assign = array();
	$query = "SELECT addresses, addressees FROM $assign_table WHERE user_id = $cookie_value ORDER BY id DESC LIMIT 1";
	if ($result = mysqli_query($link, $query)) {
		while ($row = mysqli_fetch_assoc($result)) {
			array_push($assign, $row["addresses"], $row["addressees"]);
		}
		mysqli_free_result($result);
	}
	$smarty->assign('assign', $assign);
	
	$smarty->display('index.tpl');
	mysqli_close($link);
} else {
	
	/*if (isset($_POST['assign'])){
		$addresses = $_POST['addresses'];
		$addressees = $_POST['addressees'];
		$sql = "INSERT INTO $assign_table (user_id, addresses, addressees) VALUES  (1, '$addresses', '$addressees');";
		
		mysqli_query($link, $sql);
	} else 
	*/
if (isset($_POST['login'])){
		$user = $_POST['email'];
		$pass = $_POST['password'];
		
		$phash = sha1(sha1($pass."salt")."salt");
		
		$sql = "SELECT * FROM $users_table WHERE $users_table_email='$user' AND $users_table_password='$phash';";
		$result = mysqli_query($link, $sql);
		$count = mysqli_num_rows($result);
		if ($count == 1) {
			while($row =  mysqli_fetch_assoc($result)) {
				$cookie_value = $row["id"];
				setcookie($cookie_name, $cookie_value, time() + $cookie_time, "/");
				header("Location: index.php");
			}
		} else {
			//echo "Неправильный email или пароль";
		}
		
	} else if (isset($_POST['register'])){
		$user = $_POST['email'];
		$pass = $_POST['password'];
		$name = $_POST['name'];
		
		$phash = sha1(sha1($pass."salt")."salt");
		
		$sql = "INSERT INTO $users_table ($users_table_id, $users_table_email, $users_table_password, name) VALUES  ('', '$user', '$phash', '$name');";
		
		$result = mysqli_query($link, $sql);
		
		$sql2 = "SELECT * FROM $users_table WHERE $users_table_email='$user' AND $users_table_password='$phash';";
		
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
