<?php
include 'identifica.cripto.php';

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Erro de conexão: " . $conn->connect_error);
}

if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $nome_pessoa  = trim($_POST['nome_pessoa']);
    $email        = trim($_POST['email']);
    $telefone     = trim($_POST['telefone']);
    $nome_usuario = trim($_POST['nome_usuario']);
    $pode_msg     = isset($_POST['pode_msg']) ? 'sim' : 'nao';

    if ($nome_pessoa && $email && $nome_usuario) {
        $stmt = $conn->prepare("SELECT id_chave_pessoa FROM pessoas WHERE email = ?");
        $stmt->bind_param("s", $email);
        $stmt->execute();
        $stmt->bind_result($id_pessoa);
        if ($stmt->fetch()) {
            $stmt->close();
            header("Location: " . $_SERVER['PHP_SELF'] . "?erro=email_existente");
            exit;
        } else {
            $stmt->close();
            $stmt = $conn->prepare("INSERT INTO pessoas (nome_pessoa, email, telefone) VALUES (?, ?, ?)");
            $stmt->bind_param("sss", $nome_pessoa, $email, $telefone);
            if ($stmt->execute()) {
                $id_pessoa = $stmt->insert_id;
                $stmt->close();

                $hash = hash('sha256', 'agora_vai' . $nome_usuario);
                $data_inicio = date('Y-m-d');
                $senha_fake = ''; // campo requerido no banco

                $stmt = $conn->prepare("INSERT INTO usuarios (nome_usuario, senha, hash, data_inicio_cadastro, id_pessoa, pode_msg) VALUES (?, ?, ?, ?, ?, ?)");
                $stmt->bind_param("ssssis", $nome_usuario, $senha_fake, $hash, $data_inicio, $id_pessoa, $pode_msg);
                if ($stmt->execute()) {
                    $stmt->close();
                    header("Location: " . $_SERVER['PHP_SELF'] . "?sucesso=1");
                    exit;
                } else {
                    $erro = $stmt->error;
                    $stmt->close();
                    header("Location: " . $_SERVER['PHP_SELF'] . "?erro=usuarios&msg=" . urlencode($erro));
                    exit;
                }
            } else {
                $erro = $stmt->error;
                $stmt->close();
                header("Location: " . $_SERVER['PHP_SELF'] . "?erro=pessoas&msg=" . urlencode($erro));
                exit;
            }
        }
    } else {
        header("Location: " . $_SERVER['PHP_SELF'] . "?erro=campos_obrigatorios");
        exit;
    }
}

$sql = "
SELECT nome_pessoa, nome_usuario, 
  CONCAT('https://h5g37o62z.specchio.info/tjd3s_projind_20250703/index.html?hash=', hash) AS link
FROM usuarios
JOIN pessoas ON id_pessoa = id_chave_pessoa
";
$resultado = $conn->query($sql);
?>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <title>Cadastro e Listagem de Usuários</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <style>
    body { font-family: sans-serif; padding: 1rem; }
    form, table { margin-top: 2rem; width: 100%; }
    input, button { padding: 0.5rem; width: 100%; margin-bottom: 0.5rem; box-sizing: border-box; }
    table { border-collapse: collapse; width: 100%; }
    th, td { padding: 0.5rem; border: 1px solid #ccc; word-break: break-all; }
    label.inline { display: inline-flex; align-items: center; gap: 0.4rem; margin-top: 0.5rem; }
  </style>
</head>
<body>

<h1>Usuários Cadastrados</h1>
<?php if ($resultado && $resultado->num_rows > 0): ?>
  <table>
    <thead>
      <tr>
        <th>Nome</th>
        <th>Usuário</th>
        <th>Link direto</th>
      </tr>
    </thead>
    <tbody>
      <?php while ($row = $resultado->fetch_assoc()): ?>
        <tr>
          <td><?= htmlspecialchars($row['nome_pessoa']) ?></td>
          <td><?= htmlspecialchars($row['nome_usuario']) ?></td>
          <td><?= htmlspecialchars($row['link']) ?></td>
        </tr>
      <?php endwhile; ?>
    </tbody>
  </table>
<?php else: ?>
  <p>Nenhum usuário encontrado.</p>
<?php endif; ?>

<h2>Formulário de Cadastro</h2>

<?php if (isset($_GET['sucesso'])): ?>
  <p><strong style="color: green;">Usuário cadastrado com sucesso.</strong></p>
<?php elseif (isset($_GET['erro'])): ?>
  <p><strong style="color: red;">
    <?php
      switch ($_GET['erro']) {
        case 'email_existente': echo "Erro: E-mail já cadastrado."; break;
        case 'campos_obrigatorios': echo "Erro: Preencha todos os campos obrigatórios."; break;
        case 'pessoas':
        case 'usuarios':
          echo "Erro ao salvar: " . htmlspecialchars($_GET['msg'] ?? ''); break;
        default: echo "Erro desconhecido.";
      }
    ?>
  </strong></p>
<?php endif; ?>

<form method="POST">
  <input type="text" name="nome_pessoa" placeholder="Nome completo" required>
  <input type="email" name="email" placeholder="E-mail" required>
  <input type="text" name="telefone" placeholder="Telefone">
  <input type="text" name="nome_usuario" placeholder="Nome de usuário" required>
  <label class="inline"><input type="checkbox" name="pode_msg"> Pode enviar mensagens</label><br><br>
  <button type="submit">Cadastrar</button>
</form>
<script>
  if (window.location.search.includes('sucesso=1')) {
    window.history.replaceState({}, document.title, window.location.pathname);
  }
</script>

</body>
</html>

