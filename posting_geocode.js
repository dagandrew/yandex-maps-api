ymaps.geocode('" . $full_address . "', {
        results: 1
    }).then(function (res) {
            // Selecting the first result of geocoding.
            var firstGeoObject = res.geoObjects.get(0),
            
            // The coordinates of the geo object.
            coords = firstGeoObject.geometry.getCoordinates(),
            // The viewport of the geo object.
            bounds = firstGeoObject.properties.get('boundedBy');

            firstGeoObject.options.set({'preset': 'islands#redStretchyIcon',
                                        'hasBalloon': false
            });
            // Getting the address string and displaying it in the geo object icon.
            //firstGeoObject.properties.set('iconCaption', '" . ($i + 1) ."');
            firstGeoObject.properties.set({
                    iconContent: '" . ($i + 1) ."',
                    hintContent: '" . $full_address . "',
                    balloonContentBody: '" . $full_address . "',
                    
                });
          
            
            // Adding first found geo object to the map.

        firstGeoObject.events.add('click', function (e) {
        // Если меню метки уже отображено, то убираем его.
        if ($('#menu').css('display') == 'block') {
            $('#menu').remove();
        } else {
            // HTML-содержимое контекстного меню.
            var menuContent =
                '<div id=\"menu\">\
                    <ul id=\"menu_list\">\
                        <li>" . ($i + 1) . "</li>\
                        <li>" .$full_address . "</li>\
                        <li>ФИО</li>\
                    </ul>\
                <div align=\"center\"><button id=\"izvesch\">Извещение</button></div>\
                <div align=\"center\"><button id=\"given\">Вручено</button></div>\
                </div>';

            // Размещаем контекстное меню на странице
            $('body').append(menuContent);

            // Задаем позицию меню.
            $('#menu').css({
                left: e.get('pagePixels')[0],
                top: e.get('pagePixels')[1]
            });

            // Заполняем поля контекстного меню текущими значениями свойств метки.

            // При нажатии на кнопку \"Сохранить\" изменяем свойства метки
            // значениями, введенными в форме контекстного меню.
            
            $('#izvesch').click(function () {
                firstGeoObject.options.set({
                    preset: 'islands#blueStretchyIcon'
                });
                $('#badge' + " . ($i + 1) . ").text('извещение');
                $('#menu').remove();
            });
            $('#given').click(function () {
                firstGeoObject.options.set({
                    preset: 'islands#greenStretchyIcon'
                });
                $('#badge' + " . ($i + 1) . ").text('вручено')
                $('#menu').remove();
            });
        }
    });

    myMap.events.add('click', function (e) {
        if ($('#menu').css('display') == 'block') {
            $('#menu').remove();
        }
    });
            myMap.geoObjects.add(firstGeoObject);

            // Scaling the map to the geo object viewport.
            myMap.setBounds(bounds, {
                // Checking the availability of tiles at the given zoom level.
                checkZoomRange: true
            });
        });";
       }
