<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style type="text/css">
            html { height: 100% }
            body { height: 100%; margin: 0; padding: 0 }
            #map_canvas { height: 100% }
        </style>
        <script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?key=AIzaSyCFZuMFIU_oIXt5B2UnfsEscppaxaU17F0&sensor=true&libraries=geometry">
        </script>
        <script type="text/javascript">
            var deliveryArea, deliveryClosedArea, map;

            function initialize() {
                var myLatLng = new google.maps.LatLng(24.886436490787712, -70.2685546875);
                var mapOptions = {
                    //center: new google.maps.LatLng(-22.413790800714608, -45.451812744140625),
                    center: myLatLng,
                    zoom: 5,
                    mapTypeId: google.maps.MapTypeId.ROADMAP
                };
                map = new google.maps.Map(document.getElementById("map_canvas"), mapOptions);

                deliveryArea = new google.maps.Polyline({
                    paths: [],
                    strokeColor: '#FF0000',
                    strokeOpacity: 0.8,
                    strokeWeight: 3,
                    fillColor: '#FF0000',
                    fillOpacity: 0.35,
                    draggable: true
                });

                deliveryArea.setMap(map);

                google.maps.event.addListener(map, 'click', function(event) {
                    addPolygonLine(event);
                });

                google.maps.event.addListener(deliveryArea, 'dblclick', function(event) {
                    closeArea(event);
                });
            }

            var addPolygonLine = function(event) {
                deliveryArea.getPath().push(event.latLng);
            };
            var closeArea = function(event) {
                deliveryArea.getPath().push(event.latLng);
                deliveryClosedArea = new google.maps.Polygon({
                    paths: deliveryArea.getPath(),
                    strokeColor: '#FF0000',
                    strokeOpacity: 0.8,
                    strokeWeight: 3,
                    fillColor: '#FF0000',
                    fillOpacity: 0.35,
                    editable: true,
                    draggable: true
                });

                deliveryArea.setMap(null);
                deliveryClosedArea.setMap(map);

                google.maps.event.clearListeners(map);
                
                google.maps.event.addListener(map, 'click', function(event) {
                    alert(isWithinPoly(event));
                });
            };

            function isWithinPoly(event) {
                var isWithinPolygon = google.maps.geometry.poly.containsLocation(event.latLng, deliveryClosedArea);
                return isWithinPolygon;
            }
        </script>

    </head>
    <body onload="initialize();">
        <div id="map_canvas">
        </div>

    </body>
</html>
