<?php
require_once "identifica.cripto.php";

// Conexão
$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Erro na conexão: " . $conn->connect_error);
}

$sql = "SELECT id_chave_localizacao, latitude, longitude, display_name FROM localizacoes WHERE latitude IS NOT NULL AND longitude IS NOT NULL";
$result = $conn->query($sql);

$localizacoes = [];
while ($row = $result->fetch_assoc()) {
    // Corrigir inversão de latitude/longitude se necessário
    $localizacoes[] = [
        'id_chave_localizacao' => $row['id_chave_localizacao'],
        'latitude' => $row['latitude'], 
        'longitude' => $row['longitude'], 
        'display_name' => $row['display_name']
    ];
}
$conn->close();
?>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Mapa de Localizações</title>
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
    <style>
        #map { height: 90vh; width: 100%; }
    </style>
</head>
<body>
    <h2>Mapa de Localizações</h2>
    <div id="map"></div>

    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
    <script>
        const localizacoes = <?php echo json_encode($localizacoes, JSON_UNESCAPED_UNICODE); ?>;
        const map = L.map('map');
        const bounds = [];

        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            maxZoom: 19,
            attribution: '&copy; OpenStreetMap'
        }).addTo(map);

        localizacoes.forEach(loc => {
            if (loc.latitude && loc.longitude) {
                const latlng = [loc.latitude, loc.longitude];
                bounds.push(latlng);
                const marker = L.marker(latlng).addTo(map);
                marker.bindPopup(`<b>${loc.display_name}</b><br>ID: ${loc.id_chave_localizacao}`);
            }
        });

        if (bounds.length > 0) {
            map.fitBounds(bounds, { padding: [20, 20] });
        } else {
            map.setView([-15.78, -47.92], 4); // fallback para Brasil
        }
    </script>
</body>
</html>

