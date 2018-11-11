import "leaflet/dist/leaflet.js";

document.addEventListener("turbolinks:load", function () {
  var map = document.getElementById("map");

  var latitude  = parseFloat(map.dataset.latitude);
  var longitude = parseFloat(map.dataset.longitude);

  var leaflet_map = L.map("map").setView([latitude, longitude], 17);
  L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png')
   .addTo(leaflet_map);
});
