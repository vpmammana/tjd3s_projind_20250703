// Initialize map with a default location
var map = L.map('map').setView([51.505, -0.09], 13); // Default view (London)

// Add OpenStreetMap tiles
L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    maxZoom: 19,
}).addTo(map);

// Automatically locate user on page load
window.onload = function () {
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(showPosition, showError);
    } else {
        alert("Geolocation is not supported by this browser.");
    }
};

// Function to handle successful geolocation
function showPosition(position) {
    var lat = position.coords.latitude;
    var lon = position.coords.longitude;

    // Center map on user's location
    map.setView([lat, lon], 13);

    // Add a marker at user's current location
    L.marker([lat, lon]).addTo(map)
        .bindPopup("Você está aqui")
        .openPopup();
}

// Handle geolocation errors
function showError(error) {
    switch (error.code) {
        case error.PERMISSION_DENIED:
            alert("User denied the request for Geolocation.");
            break;
        case error.POSITION_UNAVAILABLE:
            alert("Location information is unavailable.");
            break;
        case error.TIMEOUT:
            alert("The request to get user location timed out.");
            break;
        case error.UNKNOWN_ERROR:
            alert("An unknown error occurred.");
            break;
    }
}

// Create the centralize button using Leaflet utility
var centerButton = L.DomUtil.create('a', 'leaflet-control-center');
centerButton.href = '#';
centerButton.title = 'Center on Location';
centerButton.innerHTML = '<span><i class="fas fa-crosshairs"></span>';

centerButton.onclick = function (e) {
    e.preventDefault();
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(function (position) {
            var lat = position.coords.latitude;
            var lon = position.coords.longitude;
            map.setView([lat, lon], 13); // Center the map on user's location
            addUserMarker(lat, lon); // Update or add marker
        });
    } else {
        alert("Geolocation is not supported by this browser.");
    }
};

// Append the center button to the existing zoom controls
var zoomControlContainer = document.querySelector('.leaflet-control-zoom');
zoomControlContainer.appendChild(centerButton);