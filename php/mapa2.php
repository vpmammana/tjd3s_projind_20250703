i<?php
require_once "identifica.cripto.php";

// Conexão
$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Erro na conexão: " . $conn->connect_error);
}

$sql = "SELECT id_chave_localizacao, latitude, longitude, display_name FROM localizacoes";
$result = $conn->query($sql);

$localizacoes = [];
while ($row = $result->fetch_assoc()) {
    // Inverter latitude e longitude se os dados estiverem trocados
    $localizacoes[] = [
        'id_chave_localizacao' => $row['id_chave_localizacao'],
        'latitude' => $row['longitude'],   // <- CORRIGIDO: aqui usamos longitude como latitude
        'longitude' => $row['latitude'],   // <- CORRIGIDO: aqui usamos latitude como longitude
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

        const map = L.map('map').setView([-15.7801, -47.9292], 4); // centro aproximado do Brasil
        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            maxZoom: 19,
            attribution: '&copy; OpenStreetMap'
        }).addTo(map);

        localizacoes.forEach(loc => {
            if (loc.latitude && loc.longitude) {
                const marker = L.marker([loc.latitude, loc.longitude]).addTo(map);
                marker.bindPopup(`<b>${loc.display_name}</b><br>ID: ${loc.id_chave_localizacao}`);
            }
        });
    </script>
</body>
</html>

