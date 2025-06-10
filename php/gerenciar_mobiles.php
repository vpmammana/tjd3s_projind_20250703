<?php
include 'identifica.cripto.php';

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Erro de conexão: " . $conn->connect_error);
}

// Se o botão "liberar mobile" foi clicado
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['id_chave_usuario'])) {
    $id = intval($_POST['id_chave_usuario']);
    $stmt = $conn->prepare("UPDATE usuarios SET tem_local_storage = 'nao', hash_mobile = NULL WHERE id_chave_usuario = ?");
    $stmt->bind_param("i", $id);
    $stmt->execute();
    $stmt->close();

    header("Location: " . $_SERVER['PHP_SELF'] . "?liberado=1");
    exit;
}

// Consulta os dados
$sql = "
SELECT 
  u.id_chave_usuario AS id,
  p.nome_pessoa,
  u.nome_usuario,
  u.data_inicio_cadastro AS data,
  u.tem_local_storage AS mobile
FROM usuarios u
JOIN pessoas p ON u.id_pessoa = p.id_chave_pessoa
ORDER BY u.id_chave_usuario ASC
";
$resultado = $conn->query($sql);
?>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <title>Gerenciar Mobile Registrado</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <style>
    body { font-family: sans-serif; padding: 1rem; }
    table { width: 100%; border-collapse: collapse; margin-top: 1rem; }
    th, td { padding: 0.5rem; border: 1px solid #ccc; text-align: left; }
    form.inline { display: inline; }
    button { padding: 0.3rem 0.6rem; }
  </style>
</head>
<body>

<h1>Gerenciar Dispositivos Mobile Registrados</h1>

<?php if (isset($_GET['liberado'])): ?>
  <p id="msg-liberado" style="color: green;"><strong>Dispositivo liberado com sucesso.</strong></p>
<?php endif; ?>

<?php if ($resultado && $resultado->num_rows > 0): ?>
  <table>
    <thead>
      <tr>
        <th>ID</th>
        <th>Nome da Pessoa</th>
        <th>Nome de Usuário</th>
        <th>Data de Início</th>
        <th>Mobile Registrado</th>
        <th>Ação</th>
      </tr>
    </thead>
    <tbody>
      <?php while ($row = $resultado->fetch_assoc()): ?>
        <tr>
          <td><?= htmlspecialchars($row['id']) ?></td>
          <td><?= htmlspecialchars($row['nome_pessoa']) ?></td>
          <td><?= htmlspecialchars($row['nome_usuario']) ?></td>
          <td><?= htmlspecialchars($row['data']) ?></td>
          <td><?= htmlspecialchars($row['mobile']) ?></td>
          <td>
            <?php if ($row['mobile'] === 'sim'): ?>
              <form method="POST" class="inline">
                <input type="hidden" name="id_chave_usuario" value="<?= intval($row['id']) ?>">
                <button type="submit">Liberar mobile</button>
              </form>
            <?php endif; ?>
          </td>
        </tr>
      <?php endwhile; ?>
    </tbody>
  </table>
<?php else: ?>
  <p>Nenhum usuário encontrado.</p>
<?php endif; ?>

<script>
// Remove ?liberado=1 da URL após o carregamento para evitar reaparecimento após F5
if (window.location.search.includes('liberado=1')) {
  window.history.replaceState({}, document.title, window.location.pathname);
}
</script>

</body>
</html>

