// DOC: https://leafletjs.com/reference-1.4.0.html
import 'leaflet/dist/leaflet.js';

document.addEventListener('DOMContentLoaded', function() {
  var map = document.getElementById('map');

  // WARNING: if doesn't find any `dataset`, doesn't create the map
  var latitude  = parseFloat(map.dataset.latitude);
  var longitude = parseFloat(map.dataset.longitude);

  var leaflet_map = L.map('map').setView([latitude, longitude], 17);

  L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
  }).addTo(leaflet_map);

  L.marker([latitude, longitude]).addTo(leaflet_map);
});
