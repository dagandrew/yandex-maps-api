<!doctype html>
<html lang="ru">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
	<link rel="stylesheet" href="{$css_path}/main.css">
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">
    <!-- go to favicon-generator.org, generate a favicon there and place it in /public_html/img/icon -->
	<link rel="apple-touch-icon" sizes="57x57" href="{$icon_path}/apple-icon-57x57.png">
	<link rel="apple-touch-icon" sizes="60x60" href="{$icon_path}/apple-icon-60x60.png">
    <link rel="apple-touch-icon" sizes="72x72" href="{$icon_path}/apple-icon-72x72.png">
    <link rel="apple-touch-icon" sizes="76x76" href="{$icon_path}/apple-icon-76x76.png">
    <link rel="apple-touch-icon" sizes="114x114" href="{$icon_path}/apple-icon-114x114.png">
    <link rel="apple-touch-icon" sizes="120x120" href="{$icon_path}/apple-icon-120x120.png">
    <link rel="apple-touch-icon" sizes="144x144" href="{$icon_path}/apple-icon-144x144.png">
    <link rel="apple-touch-icon" sizes="152x152" href="{$icon_path}/apple-icon-152x152.png">
    <link rel="apple-touch-icon" sizes="180x180" href="{$icon_path}/apple-icon-180x180.png">
    <link rel="icon" type="image/png" sizes="192x192"  href="{$icon_path}/android-icon-192x192.png">
    <link rel="icon" type="image/png" sizes="32x32" href="{$icon_path}/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="96x96" href="{$icon_path}/favicon-96x96.png">
    <link rel="icon" type="image/png" sizes="16x16" href="{$icon_path}/favicon-16x16.png">
    <link rel="manifest" href="{$icon_path}/manifest.json">
	<meta name="msapplication-TileColor" content="#ffffff">
	<meta name="msapplication-TileImage" content="{$icon_path}/ms-icon-144x144.png">
	<meta name="theme-color" content="#ffffff">
	{literal}
	<script src="https://api-maps.yandex.ru/2.1/?apikey=525928f3-86fc-41c4-b200-51ae5d1d8253&lang=ru_RU" type="text/javascript">
    </script>
    {/literal}
    <style>
		
	.myLink, .myLink:hover, .myLink:active, .myLink:visited, .myLink:focus {
		text-decoration:none;
		color: black;
}
    a {
      text-decoration:none;
   }
#menu {
            position: absolute;
            width: 12em;
            background: white;
            border: 1px solid #ccc;
            border-radius: 12px;
            padding-bottom: 10px;
            z-index: 9999999;
        }
        #menu ul {
            list-style-type: none;
            padding: 20px;
            margin: 0;
        }
        input {
            width: 10em;
        }
        .btn {
			margin: 2px;
		}

    </style>
    <title>{$name}</title>
  </head>
  <body>
	  
	<!-- navbar -->
    <nav class="navbar navbar-expand-lg navbar-light bg-light" style="position:fixed; width:100%; z-index: 100">
      <a class="navbar-brand" href="/postman">
      <img src="{$icon_path}/android-icon-36x36.png" width="30" height="30" class="d-inline-block align-top" alt="">
      {$name}
	  </a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarTogglerDemo02" aria-controls="navbarTogglerDemo02" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>

      <div class="collapse navbar-collapse" id="navbarTogglerDemo02">
        <ul class="navbar-nav mr-auto mt-2 mt-lg-0">
			
        
          
        </ul>
       </div>
	  
	<div id="daysInARow" class="progress" data-offset="40,20" data-toggle="dropdown" aria-expanded="false" style ="position: absolute; right: 15px; top: 8px; height: 40px; width: 90px; z-index: 1000;">
      <div class="progress-bar bg-warning" role="progressbar" style="width: 0%" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100">
		  <span style ="position:absolute; left: 13px;  color: gray; font-size: 20px; font-weight: 700;" id="daysInARowSpan">{$sum}</span>
	  </div>
    </div>
    
	<div class="btn-group">
	
	  <div class="dropdown-menu dropdown-menu-right" style="margin-top:30px" >
		<a href="profile.php" class="dropdown-item">Профиль</a>
		<button class="dropdown-item" type="button">Настройки</button>
		<a href="logout.php" class="dropdown-item">Выйти</a>
	  </div>
	</div>
    </nav>
    <div style="height:60px"></div>
    
    
    
    
    <!-- container -->
    <div class="container">		
		
        {if $page eq 'add'}
			<form action="" method="post">
			<div class="form-group">
				<label for="exampleFormControlTextarea1">Вставьте текст в формате "670000, Россия, г. Улан-Удэ, ул. Борсоева, 73, кв. 50 ШПИ 82050000369760"</a></label>
				<textarea class="form-control" id="exampleFormControlTextarea1" name="text" rows="3"></textarea>
			  </div>
			<div class="form-group">
				<label for="exampleFormControlTextarea1">Вставьте адресатов</a></label>
				<textarea class="form-control" id="exampleFormControlTextarea1" name="addressee" rows="3"></textarea>
			  </div>
			  <input class="full-width has-padding" type="submit" name="send" value="Отправить">
	    
			</form>

					
					
					
		
        {elseif $page eq "current_route"}
        
			Ваш текущий маршрут <br />
			<div id="mapx" style="width: 100%; height: 400px; margin-bottom: 50px"></div>
			<div class="card-columns">
			  
			{section name=address loop=$user_route_addresses}
			<div class="card">
				<ul class="list-group list-group-flush">
						<li class="list-group-item d-flex justify-content-between align-items-center">{$smarty.section.address.index + 1} - 
	{$user_route_addresses[address].street} - {$user_route_addresses[address].building} - {$user_route_addresses[address].apartment} - {$user_route_addresses[address].addressee}
					
			{if $user_route_addresses[address].status eq 0} <span id=pill{$smarty.section.address.index} class="badge badge-primary badge-pill">на руках</span>
			{elseif $user_route_addresses[address].status eq 1} <span id=pill{$smarty.section.address.index} class="badge badge-warning badge-pill">извещение</span>
			{elseif $user_route_addresses[address].status eq 2} <span id=pill{$smarty.section.address.index} class="badge badge-success badge-pill">вручено</span>
			{elseif $user_route_addresses[address].status eq 3} <span id=pill{$smarty.section.address.index} class="badge badge-danger badge-pill">неверный адрес</span>
			{elseif $user_route_addresses[address].status eq 4} <span id=pill{$smarty.section.address.index} class="badge badge-secondary badge-pill">другое</span>
			{/if}
					</li>
				</ul>
			  </div>
			
			
			
			{/section}
			
			</div>
			<form action="" method="POST">
				<input type="submit" name="delete_route" class="btn btn-danger" value="Удалить маршрут">
			</form>
		{elseif $page eq "mapcoordinates"}
		<div id="map" style="width: 100%; height: 400px; margin-bottom: 50px"></div>
		{literal} 
<script>
	

var myMap;
var coordinates = [];
ymaps.ready(init);

function init() {
    var myMap = new ymaps.Map('map', {
        center: [51.8336, 107.5840],
        zoom: 9,
        controls: ['zoomControl', 'searchControl', 'typeSelector',  'fullscreenControl', 'routeButtonControl']
    });
    
    {/literal}
		{section name=coordinates loop=$arrayWithCoordinates}
	
	
	{literal}
	        $('<input>').attr({
				'id' : 'coordinateInputLatitude' + {/literal}{$smarty.section.coordinates.index}{literal},
				'name': 'latitude[]',
				'style': 'display: none'
				}).appendTo('#form');
			$('<input>').attr({
				'id' : 'coordinateInputLongitude' + {/literal}{$smarty.section.coordinates.index}{literal},
				'name': 'longitude[]',
				'style': 'display: none'
				}).appendTo('#form');
			$('<input>').attr({
				'id' : 'street' + {/literal}{$smarty.section.coordinates.index}{literal},
				'name': 'street[]',
				'style': 'display: none'
				}).appendTo('#form');
			$('<input>').attr({
				'id' : 'building' + {/literal}{$smarty.section.coordinates.index}{literal},
				'name': 'building[]',
				'style': 'display: none'
				}).appendTo('#form');
			$('<input>').attr({
				'id' : 'apartment' + {/literal}{$smarty.section.coordinates.index}{literal},
				'name': 'apartment[]',
				'style': 'display: none'
				}).appendTo('#form');
			$('<input>').attr({
				'id' : 'addressee' + {/literal}{$smarty.section.coordinates.index}{literal},
				'name': 'addressee[]',
				'style': 'display: none'
				}).appendTo('#form');
					
			
				
			$('#street' + {/literal}{$smarty.section.coordinates.index}{literal}).val("{/literal}{$arrayWithCoordinates[coordinates].street}{literal}");
			$('#building' + {/literal}{$smarty.section.coordinates.index}{literal}).val("{/literal}{$arrayWithCoordinates[coordinates].building}{literal}");
			$('#apartment' + {/literal}{$smarty.section.coordinates.index}{literal}).val("{/literal}{$arrayWithCoordinates[coordinates].apartment}{literal}");
			$('#addressee' + {/literal}{$smarty.section.coordinates.index}{literal}).val("{/literal}{$arrayWithCoordinates[coordinates].addressee}{literal}");
			
    ymaps.geocode('Улан-Удэ, {/literal}{$arrayWithCoordinates[coordinates].street}{literal}, {/literal}{$arrayWithCoordinates[coordinates].building}{literal}', {
        results: 1
    }).then(function (res) {
            // Selecting the first result of geocoding.
            var firstGeoObject = res.geoObjects.get(0),
            
            // The coordinates of the geo object.
            coords = firstGeoObject.geometry.getCoordinates(),
            
            
            // The viewport of the geo object.
            bounds = firstGeoObject.properties.get('boundedBy');

			//get coordinates
            coordsX = firstGeoObject.geometry.getCoordinates()
            $('#coordinateInputLatitude' + {/literal}{$smarty.section.coordinates.index}{literal}).val(coordsX[0]);
				
			$('#coordinateInputLongitude' + {/literal}{$smarty.section.coordinates.index}{literal}).val(coordsX[1]);
			
				
            });
        {/literal}
       {/section}
		  {literal}
		  
	  }
	  
	  </script>
    {/literal}
		  Добавление координат
			<form id = "form" action="" method="post">
				
				
				
				<input type="submit" name="sendCoordinates" class="btn btn-success" value="Продолжить">
			</form>
		
		{elseif $page eq "correction"}
			
			<form action="" method="post">
			{section name=street loop=$streets}
			{$streets[street].full}
			<br>
			
			
					  <div class="form-row align-items-center">
						<div class="col-auto">
						  <label class="sr-only" for="inlineFormInput">Name</label>
						  <input name="street[]" type="text" class="form-control mb-2" id="inlineFormInput" placeholder="Улица" style="width: 130px" value={$streets[street].street}>
				
				</div>
						<div class="col-auto">
						  <label class="sr-only" for="inlineFormInputGroup">Username</label>
						  <input name="building[]" type="text" class="form-control mb-2" id="inlineFormInputGroup" style="width: 60px;" value={$streets[street].other}>
						</div>
						<div class="col-auto">
						  <label class="sr-only" for="inlineFormInputFlat">Username</label>
						  <div class="input-group mb-2">
							<div class="input-group-prepend">
							  <div class="input-group-text">кв.</div>
							</div>
							<input name="apartment[]" type="text" class="form-control" id="inlineFormInputFlat" style="width: 60px;">
							<input name="addressee[]" type="text" class="form-control" id="inlineFormInputAddressee" style="display:none;" value="{$streets[street].addressee}">
						  </div>
						</div>
					  </div>
					
				
			{/section}	
			
			<input type="submit" name="correct" class="btn btn-success" value="Все правильно!">
			</form>
		
		{else}
			<div class="jumbotron">
			  <h2 class="display-4">Хай!</h2>
			  <p class="lead">Этот сайт помогает почтальонам в их трудной работе.</p>
			  <hr class="my-4">
			  <p>На данный момент не найдено ваших маршрутов.</p>
			  <a class="btn btn-primary btn-lg" href="index.php?p=add" role="button">Добавить маршрут</a>
			</div>
		{/if}
    </div>
    
    
    
    
    
    <div style="height:60px"></div>
    <div class="footer" style="position: fixed; left: 0; bottom: 0; width: 100%; background-color: #efefef; color: white; text-align: center; z-index: 10001"> 
		{section name=navs loop=$nav}
		<a href="{$nav[navs].link}" id="phoneMenu{$smarty.section.navs.index}"><i class="{$nav[navs].badge}" style = "
		{if $page eq $smarty.section.navs.index}
		color:#007bff; 
		{else}
		color: black; 
		{/if}
		font-size: 2em; margin: 10px;"></i></a>
         {/section}
    </div>
    
    
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
{literal} 
<script>
    <!-- Optional JavaScript -->
var coordinatesArray = [];
var markersArray = [];
{/literal}
		{section name=address loop=$user_route_addresses}
	{literal}
	
markersArray.push( ["{/literal}{$user_route_addresses[address].street}{literal}", "{/literal}{$user_route_addresses[address].building}{literal}", "{/literal}{$user_route_addresses[address].apartment}{literal}", "{/literal}{$user_route_addresses[address].addressee}{literal}", "{/literal}{$user_route_addresses[address].status}{literal}", "{/literal}{$user_route_addresses[address].id}{literal}"]);
coordinatesArray.push( [{/literal}{$user_route_addresses[address].latitude}{literal}, {/literal}{$user_route_addresses[address].longitude}{literal}]);
     {/literal}
		{/section}
	{literal}
	ymaps.ready(function () {
    var mapCenter = [51.8336, 107.5840],
        map = new ymaps.Map('mapx', {
            center: mapCenter,
            zoom: 9,
            controls: ['smallMapDefaultSet']
        }),
        // Возможные значения цветов иконок.
        placemarkColors = [
            '#FF1F1F', '#1F44FF', '#1FFF8E', '#FF1FF5',
            '#FFEF1F', '#FF931F', '#AE6961', '#6193AE'
        ];
    
    {/literal}
		{section name=polyline loop=$routes_polylines}
	{literal}
	
	var myPolyline{/literal}{$smarty.section.polyline.index}{literal} = new ymaps.Polyline({/literal}{$routes_polylines[polyline]}{literal}, {
            // Описываем свойства геообъекта.
            // Содержимое балуна.
            balloonContent: "Ломаная линия"
        }, {
            // Задаем опции геообъекта.
            // Отключаем кнопку закрытия балуна.
            balloonCloseButton: true,
            // Цвет линии.
            strokeColor: '#ff0000',
			strokeWidth: 5
        });
        map.geoObjects.add(myPolyline{/literal}{$smarty.section.polyline.index}{literal});

	{/literal}
		{/section}
	{literal}
	
	firstButton = new ymaps.control.Button("Линия");
	map.controls.add(firstButton, {float: 'right'});
	firstButton.events.add('click', function (e) {
		var polyline = new ymaps.Polyline([], {}, {
			strokeColor: '#ff0000',
			strokeWidth: 5 // ширина линии
		});
		map.geoObjects.add(polyline);
		polyline.editor.startEditing();	
		polyline.editor.startDrawing();	
		firstButton.events.add('click', function (e) {
			polyline.editor.stopEditing();
			printGeometry(polyline.geometry.getCoordinates());
			firstButton.events.add('click', function (e) {
				var polyline = new ymaps.Polyline([], {}, {
					strokeColor: '#ff0000',
					strokeWidth: 5 // ширина линии
				});
				polyline.editor.startDrawing();	
				map.geoObjects.add(polyline);
				polyline.editor.startEditing();	
			});
		});
	});
	
	
	$('#stopEditPolyline').attr('disabled', false);
 
            // Обработка нажатия на любую кнопку.
    $('#stopEditPolyline').click(function () {
		// Отключаем кнопки, чтобы на карту нельзя было
		// добавить более одного редактируемого объекта (чтобы в них не запутаться).
		$('#stopEditPolyline').attr('disabled', true);

		

	});	
 
      
	
	
    
    // Создаем собственный макет с информацией о выбранном геообъекте.
    var customItemContentLayout = ymaps.templateLayoutFactory.createClass(
        // Флаг "raw" означает, что данные вставляют "как есть" без экранирования html.
        '<div class=ballon_body>{{ properties.balloonContentBody|raw }}</div>' +
        '<div class=ballon_footer>{{ properties.balloonContentFooter|raw }}</div>'
    );
    
    var clusterer = new ymaps.Clusterer({
        clusterIconLayout: 'default#pieChart',
        clusterIconPieChartRadius: 25,
        clusterIconPieChartCoreRadius: 10,
        clusterIconPieChartStrokeWidth: 3,
        clusterOpenBalloonOnClick: true,
        // Устанавливаем стандартный макет балуна кластера "Аккордеон".
        clusterBalloonContentLayout: 'cluster#balloonAccordion',
        // Устанавливаем собственный макет.
        clusterBalloonItemContentLayout: customItemContentLayout,
        // Устанавливаем режим открытия балуна. 
        // В данном примере балун никогда не будет открываться в режиме панели.
        clusterBalloonPanelMaxMapArea: 0,
        // Устанавливаем размеры макета контента балуна (в пикселях).
        clusterBalloonContentLayoutWidth: 250,
        clusterBalloonContentLayoutHeight: 200,
    });
    
    // Заполняем кластер геообъектами со случайными позициями.
    var placemarks = [];
    for (var i = 0; i < coordinatesArray.length; i++) {
        var placemark = new ymaps.Placemark(coordinatesArray[i], {
            // Устаналиваем данные, которые будут отображаться в балуне.
            balloonContentHeader: '<a class="myLink" href="#">' + (i + 1) + ' ' + markersArray[i][0] + ' ' + markersArray[i][1] + ', кв. ' + markersArray[i][2] + '</a>',
            balloonContentBody: getContentBody(i),
            balloonContentFooter: markersArray[i][3]
        }, {
            iconColor: getColor(i)
        });
        placemarks.push(placemark);
    }
    
    clusterer.add(placemarks);
    map.geoObjects.add(clusterer);

    function getColor(i) {
		//var status = markersArray[i][4];
		return "#007bff";
		/*
		if(status == 0){
			return "#007bff";
		} else if (status == 1){
			return "#ffc107";
		} else if (status == 2) {
			return "#28a745";
		} else if (status == 3) {
			return "#dc3545";
		} else {
			return "#6c757d";
		}
		*/
    }
    
    var placemarkBodies;
    function getContentBody (i) {
		return '<button type="button" class="btn-sm btn btn-outline-warning" onclick="updateStatus(1, ' + i + ')">Извещение</button><button type="button" id="s2i' + i + '" class="btn-sm btn btn-outline-success" onclick="updateStatus(2, ' + i + ')">Вручено</button><button type="button" id="s3i' + i + '" class="btn-sm btn btn-outline-danger" onclick="updateStatus(3, ' + i + ')">Неверный адрес</button><button type="button" id="s4i' + i + '" class="btn-sm btn btn-outline-secondary" onclick="updateStatus(4, ' + i + ')">Другое</button>';
    }
    //clusterer.balloon.open(clusterer.getClusters()[0]);
});

function updateStatus(status, i){
	if (status == 1){
		$('#pill' + i).attr('class', 'badge badge-warning badge-pill');
		$('#pill' + i).text('извещение');
	} else if (status == 2){
		$('#pill' + i).attr('class', 'badge badge-success badge-pill');
		$('#pill' + i).text('вручено');
	} else if (status == 3){
		$('#pill' + i).attr('class', 'badge badge-danger badge-pill');
		$('#pill' + i).text('неверный адрес');
	} else if (status == 4){
		$('#pill' + i).attr('class', 'badge badge-secondary badge-pill');
		$('#pill' + i).text('другое');
	}
	var id = markersArray[i][5];
	$.ajax({
            type: "POST",
            url: "resources/updateStatus.php",
            data: {status:status, id:id, route:{/literal}{$route}{literal}, user:{/literal}{$user}{literal}  }, 
            success: function(data){
                $('#daysInARowSpan').text(data);
            }
    });
    
}

function printGeometry (coords) {
            $.ajax({
				type: "POST",
				url: "resources/sendPolyline.php",
				data: {coordinates: stringify(coords), route:{/literal}{$route}{literal}, user:{/literal}{$user}{literal}  }, 
				/*success: function(data){
					$('#geometry').text(data);
				},
				error: function(data){
					$('#geometry').text(data);
				}
				*/
			});
 
            function stringify (coords) {
                var res = '';
                if ($.isArray(coords)) {
                    res = '[ ';
                    for (var i = 0, l = coords.length; i < l; i++) {
                        if (i > 0) {
                            res += ', ';
                        }
                        res += stringify(coords[i]);
                    }
                    res += ' ]';
                } else if (typeof coords == 'number') {
                    res = coords.toPrecision(6);
                } else if (coords.toString) {
                    res = coords.toString();
                }
 
                return res;
            }
		}
	
    </script>
    {/literal}
    </body>
</html>


    
  
